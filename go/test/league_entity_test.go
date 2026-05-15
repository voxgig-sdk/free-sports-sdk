package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/free-sports-sdk"
	"github.com/voxgig-sdk/free-sports-sdk/core"

	vs "github.com/voxgig/struct"
)

func TestLeagueEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.League(nil)
		if ent == nil {
			t.Fatal("expected non-nil LeagueEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := leagueBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "league." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set FREESPORTS_TEST_LEAGUE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		leagueRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.league", setup.data)))
		var leagueRef01Data map[string]any
		if len(leagueRef01DataRaw) > 0 {
			leagueRef01Data = core.ToMapAny(leagueRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = leagueRef01Data

		// LIST
		leagueRef01Ent := client.League(nil)
		leagueRef01Match := map[string]any{
			"api_key": setup.idmap["api_key01"],
		}

		leagueRef01ListResult, err := leagueRef01Ent.List(leagueRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, leagueRef01ListOk := leagueRef01ListResult.([]any)
		if !leagueRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", leagueRef01ListResult)
		}

	})
}

func leagueBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "league", "LeagueTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read league test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse league test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"league01", "league02", "league03", "api_key01"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("FREESPORTS_TEST_LEAGUE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"FREESPORTS_TEST_LEAGUE_ENTID": idmap,
		"FREESPORTS_TEST_LIVE":      "FALSE",
		"FREESPORTS_TEST_EXPLAIN":   "FALSE",
		"FREESPORTS_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["FREESPORTS_TEST_LEAGUE_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["FREESPORTS_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["FREESPORTS_APIKEY"],
			},
			extra,
		})
		client = sdk.NewFreeSportsSDK(core.ToMapAny(mergedOpts))
	}

	live := env["FREESPORTS_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["FREESPORTS_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
