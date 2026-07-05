# FreeSports Ruby SDK Reference

Complete API reference for the FreeSports Ruby SDK.


## FreeSportsSDK

### Constructor

```ruby
require_relative 'FreeSports_sdk'

client = FreeSportsSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `FreeSportsSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = FreeSportsSDK.test
```


### Instance Methods

#### `Event(data = nil)`

Create a new `Event` entity instance. Pass `nil` for no initial data.

#### `League(data = nil)`

Create a new `League` entity instance. Pass `nil` for no initial data.

#### `Player(data = nil)`

Create a new `Player` entity instance. Pass `nil` for no initial data.

#### `Team(data = nil)`

Create a new `Team` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## EventEntity

```ruby
event = client.Event
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_event` | `String` | No |  |
| `id_event` | `String` | No |  |
| `int_away_score` | `String` | No |  |
| `int_home_score` | `String` | No |  |
| `str_away_team` | `String` | No |  |
| `str_event` | `String` | No |  |
| `str_home_team` | `String` | No |  |
| `str_league` | `String` | No |  |
| `str_sport` | `String` | No |  |
| `str_status` | `String` | No |  |
| `str_thumb` | `String` | No |  |
| `str_time` | `String` | No |  |
| `str_venue` | `String` | No |  |
| `str_video` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Event.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `EventEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## LeagueEntity

```ruby
league = client.League
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_league` | `String` | No |  |
| `int_formed_year` | `String` | No |  |
| `str_badge` | `String` | No |  |
| `str_country` | `String` | No |  |
| `str_description_en` | `String` | No |  |
| `str_league` | `String` | No |  |
| `str_league_alternate` | `String` | No |  |
| `str_logo` | `String` | No |  |
| `str_sport` | `String` | No |  |
| `str_website` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.League.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `LeagueEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## PlayerEntity

```ruby
player = client.Player
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_born` | `String` | No |  |
| `id_player` | `String` | No |  |
| `str_cutout` | `String` | No |  |
| `str_description_en` | `String` | No |  |
| `str_height` | `String` | No |  |
| `str_nationality` | `String` | No |  |
| `str_player` | `String` | No |  |
| `str_position` | `String` | No |  |
| `str_sport` | `String` | No |  |
| `str_team` | `String` | No |  |
| `str_thumb` | `String` | No |  |
| `str_weight` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Player.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `PlayerEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## TeamEntity

```ruby
team = client.Team
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_team` | `String` | No |  |
| `int_formed_year` | `String` | No |  |
| `int_stadium_capacity` | `String` | No |  |
| `str_alternate` | `String` | No |  |
| `str_description_en` | `String` | No |  |
| `str_league` | `String` | No |  |
| `str_sport` | `String` | No |  |
| `str_stadium` | `String` | No |  |
| `str_stadium_location` | `String` | No |  |
| `str_team` | `String` | No |  |
| `str_team_badge` | `String` | No |  |
| `str_team_jersey` | `String` | No |  |
| `str_website` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Team.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `TeamEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = FreeSportsSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

