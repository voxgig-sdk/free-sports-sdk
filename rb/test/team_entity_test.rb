# Team entity test

require "minitest/autorun"
require "json"
require_relative "../FreeSports_sdk"
require_relative "runner"

class TeamEntityTest < Minitest::Test
  def test_create_instance
    testsdk = FreeSportsSDK.test(nil, nil)
    ent = testsdk.Team(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = team_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["list"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "team." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set FREESPORTS_TEST_TEAM_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    team_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.team")))
    team_ref01_data = nil
    if team_ref01_data_raw.length > 0
      team_ref01_data = Helpers.to_map(team_ref01_data_raw[0][1])
    end

    # LIST
    team_ref01_ent = client.Team(nil)
    team_ref01_match = {
      "api_key" => setup[:idmap]["api_key01"],
    }

    team_ref01_list_result, err = team_ref01_ent.list(team_ref01_match, nil)
    assert_nil err
    assert team_ref01_list_result.is_a?(Array)

  end
end

def team_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "team", "TeamTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = FreeSportsSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["team01", "team02", "team03", "api_key01"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["FREESPORTS_TEST_TEAM_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "FREESPORTS_TEST_TEAM_ENTID" => idmap,
    "FREESPORTS_TEST_LIVE" => "FALSE",
    "FREESPORTS_TEST_EXPLAIN" => "FALSE",
    "FREESPORTS_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["FREESPORTS_TEST_TEAM_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["FREESPORTS_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["FREESPORTS_APIKEY"],
      },
      extra || {},
    ])
    client = FreeSportsSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["FREESPORTS_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["FREESPORTS_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
