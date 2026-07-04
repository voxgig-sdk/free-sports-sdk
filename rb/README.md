# FreeSports Ruby SDK



The Ruby SDK for the FreeSports API — an entity-oriented client using idiomatic Ruby conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to RubyGems. Install it from the
GitHub release tag (`rb/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/free-sports-sdk/releases](https://github.com/voxgig-sdk/free-sports-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ruby
require_relative "FreeSports_sdk"

client = FreeSportsSDK.new({
  "apikey" => ENV["FREE_SPORTS_APIKEY"],
})
```

### 2. List event records

```ruby
begin
  # list returns an Array of Event records — iterate directly.
  events = client.Event.list
  events.each do |item|
    puts "#{item["id"]} #{item["name"]}"
  end
rescue => err
  warn "list failed: #{err}"
end
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})

if result["ok"]
  puts result["status"]  # 200
  puts result["data"]    # response body
else
  warn result["err"]
end
```

### Prepare a request without sending it

```ruby
begin
  fetchdef = client.prepare({
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => { "id" => "example" },
  })
  puts fetchdef["url"]
  puts fetchdef["method"]
  puts fetchdef["headers"]
rescue => err
  warn "prepare failed: #{err}"
end
```

### Use test mode

Create a mock client for unit testing — no server required. Seed fixture
data via the `entity` option so offline calls resolve without a live server:

```ruby
client = FreeSportsSDK.test({
  "entity" => { "event" => { "test01" => { "id" => "test01" } } },
})

# load returns the bare mock record (raises on error).
event = client.Event.load({ "id" => "test01" })
puts event
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ruby
mock_fetch = ->(url, init) {
  return {
    "status" => 200,
    "statusText" => "OK",
    "headers" => {},
    "json" => ->() { { "id" => "mock01" } },
  }, nil
}

client = FreeSportsSDK.new({
  "base" => "http://localhost:8080",
  "system" => {
    "fetch" => mock_fetch,
  },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
FREE_SPORTS_TEST_LIVE=TRUE
FREE_SPORTS_APIKEY=<your-key>
```

Then run:

```bash
cd rb && ruby -Itest -e "Dir['test/*_test.rb'].each { |f| require_relative f }"
```


## Reference

### FreeSportsSDK

```ruby
require_relative "FreeSports_sdk"
client = FreeSportsSDK.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Hash` | Feature activation flags. |
| `extend` | `Hash` | Additional Feature instances to load. |
| `system` | `Hash` | System overrides (e.g. custom `fetch` lambda). |

### test

```ruby
client = FreeSportsSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### FreeSportsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Hash` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Hash` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Hash` | Build and send an HTTP request. Returns a result hash (`result["ok"]`); does not raise. |
| `Event` | `(data) -> EventEntity` | Create an Event entity instance. |
| `League` | `(data) -> LeagueEntity` | Create a League entity instance. |
| `Player` | `(data) -> PlayerEntity` | Create a Player entity instance. |
| `Team` | `(data) -> TeamEntity` | Create a Team entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch, ctrl) -> Array` | List entities matching the criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `update` | `(reqdata, ctrl) -> any` | Update an existing entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> any` | Remove an entity. Raises on error. |
| `data_get` | `() -> Hash` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> Hash` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the result data directly. On failure they
raise a `FreeSportsError` (a `StandardError` subclass), so wrap
calls in `begin`/`rescue` where you need to handle errors.

The `direct` escape hatch is the exception: it never raises and instead
returns a result `Hash` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `Integer` | HTTP status code. |
| `headers` | `Hash` | Response headers. |
| `data` | `any` | Parsed JSON response body. |
| `err` | `Error` | Present when `ok` is `false`. |

### Entities

#### Event

| Field | Description |
| --- | --- |
| `date_event` |  |
| `id_event` |  |
| `int_away_score` |  |
| `int_home_score` |  |
| `str_away_team` |  |
| `str_event` |  |
| `str_home_team` |  |
| `str_league` |  |
| `str_sport` |  |
| `str_status` |  |
| `str_thumb` |  |
| `str_time` |  |
| `str_venue` |  |
| `str_video` |  |

Operations: List.

API path: `/{apiKey}/searchevents.php`

#### League

| Field | Description |
| --- | --- |
| `id_league` |  |
| `int_formed_year` |  |
| `str_badge` |  |
| `str_country` |  |
| `str_description_en` |  |
| `str_league` |  |
| `str_league_alternate` |  |
| `str_logo` |  |
| `str_sport` |  |
| `str_website` |  |

Operations: List.

API path: `/{apiKey}/lookupleague.php`

#### Player

| Field | Description |
| --- | --- |
| `date_born` |  |
| `id_player` |  |
| `str_cutout` |  |
| `str_description_en` |  |
| `str_height` |  |
| `str_nationality` |  |
| `str_player` |  |
| `str_position` |  |
| `str_sport` |  |
| `str_team` |  |
| `str_thumb` |  |
| `str_weight` |  |

Operations: List.

API path: `/{apiKey}/searchplayers.php`

#### Team

| Field | Description |
| --- | --- |
| `id_team` |  |
| `int_formed_year` |  |
| `int_stadium_capacity` |  |
| `str_alternate` |  |
| `str_description_en` |  |
| `str_league` |  |
| `str_sport` |  |
| `str_stadium` |  |
| `str_stadium_location` |  |
| `str_team` |  |
| `str_team_badge` |  |
| `str_team_jersey` |  |
| `str_website` |  |

Operations: List.

API path: `/{apiKey}/searchteams.php`



## Entities


### Event

Create an instance: `event = client.Event`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date_event` | ``$STRING`` |  |
| `id_event` | ``$STRING`` |  |
| `int_away_score` | ``$STRING`` |  |
| `int_home_score` | ``$STRING`` |  |
| `str_away_team` | ``$STRING`` |  |
| `str_event` | ``$STRING`` |  |
| `str_home_team` | ``$STRING`` |  |
| `str_league` | ``$STRING`` |  |
| `str_sport` | ``$STRING`` |  |
| `str_status` | ``$STRING`` |  |
| `str_thumb` | ``$STRING`` |  |
| `str_time` | ``$STRING`` |  |
| `str_venue` | ``$STRING`` |  |
| `str_video` | ``$STRING`` |  |

#### Example: List

```ruby
# list returns an Array of Event records (raises on error).
events = client.Event.list
```


### League

Create an instance: `league = client.League`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id_league` | ``$STRING`` |  |
| `int_formed_year` | ``$STRING`` |  |
| `str_badge` | ``$STRING`` |  |
| `str_country` | ``$STRING`` |  |
| `str_description_en` | ``$STRING`` |  |
| `str_league` | ``$STRING`` |  |
| `str_league_alternate` | ``$STRING`` |  |
| `str_logo` | ``$STRING`` |  |
| `str_sport` | ``$STRING`` |  |
| `str_website` | ``$STRING`` |  |

#### Example: List

```ruby
# list returns an Array of League records (raises on error).
leagues = client.League.list
```


### Player

Create an instance: `player = client.Player`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date_born` | ``$STRING`` |  |
| `id_player` | ``$STRING`` |  |
| `str_cutout` | ``$STRING`` |  |
| `str_description_en` | ``$STRING`` |  |
| `str_height` | ``$STRING`` |  |
| `str_nationality` | ``$STRING`` |  |
| `str_player` | ``$STRING`` |  |
| `str_position` | ``$STRING`` |  |
| `str_sport` | ``$STRING`` |  |
| `str_team` | ``$STRING`` |  |
| `str_thumb` | ``$STRING`` |  |
| `str_weight` | ``$STRING`` |  |

#### Example: List

```ruby
# list returns an Array of Player records (raises on error).
players = client.Player.list
```


### Team

Create an instance: `team = client.Team`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id_team` | ``$STRING`` |  |
| `int_formed_year` | ``$STRING`` |  |
| `int_stadium_capacity` | ``$STRING`` |  |
| `str_alternate` | ``$STRING`` |  |
| `str_description_en` | ``$STRING`` |  |
| `str_league` | ``$STRING`` |  |
| `str_sport` | ``$STRING`` |  |
| `str_stadium` | ``$STRING`` |  |
| `str_stadium_location` | ``$STRING`` |  |
| `str_team` | ``$STRING`` |  |
| `str_team_badge` | ``$STRING`` |  |
| `str_team_jersey` | ``$STRING`` |  |
| `str_website` | ``$STRING`` |  |

#### Example: List

```ruby
# list returns an Array of Team records (raises on error).
teams = client.Team.list
```


## Explanation

### The operation pipeline

Every entity operation (load, list, create, update, remove) follows a
six-stage pipeline. Each stage fires a feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage returns an error, the pipeline short-circuits and the
error is returned to the caller as a second return value.

### Features and hooks

Features are the extension mechanism. A feature is a Ruby class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as hashes

The Ruby SDK uses plain Ruby hashes throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers.to_map()` to safely validate that a value is a hash.

### Module structure

```
rb/
├── FreeSports_sdk.rb       -- Main SDK module
├── config.rb                  -- Configuration
├── features.rb                -- Feature factory
├── core/                      -- Core types and context
├── entity/                    -- Entity implementations
├── feature/                   -- Built-in features (Base, Test, Log)
├── utility/                   -- Utility functions and struct library
└── test/                      -- Test suites
```

The main module (`FreeSports_sdk`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```ruby
event = client.Event
event.load({ "id" => "example_id" })

# event.data_get now returns the loaded event data
# event.match_get returns the last match criteria
```

Call `make` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
