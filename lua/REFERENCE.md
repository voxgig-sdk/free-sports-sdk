# FreeSports Lua SDK Reference

Complete API reference for the FreeSports Lua SDK.


## FreeSportsSDK

### Constructor

```lua
local sdk = require("free-sports_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `Event(data)`

Create a new `Event` entity instance. Pass `nil` for no initial data.

#### `League(data)`

Create a new `League` entity instance. Pass `nil` for no initial data.

#### `Player(data)`

Create a new `Player` entity instance. Pass `nil` for no initial data.

#### `Team(data)`

Create a new `Team` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## EventEntity

```lua
local event = client:Event(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_event` | `string` | No |  |
| `id_event` | `string` | No |  |
| `int_away_score` | `string` | No |  |
| `int_home_score` | `string` | No |  |
| `str_away_team` | `string` | No |  |
| `str_event` | `string` | No |  |
| `str_home_team` | `string` | No |  |
| `str_league` | `string` | No |  |
| `str_sport` | `string` | No |  |
| `str_status` | `string` | No |  |
| `str_thumb` | `string` | No |  |
| `str_time` | `string` | No |  |
| `str_venue` | `string` | No |  |
| `str_video` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Event():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `EventEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## LeagueEntity

```lua
local league = client:League(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_league` | `string` | No |  |
| `int_formed_year` | `string` | No |  |
| `str_badge` | `string` | No |  |
| `str_country` | `string` | No |  |
| `str_description_en` | `string` | No |  |
| `str_league` | `string` | No |  |
| `str_league_alternate` | `string` | No |  |
| `str_logo` | `string` | No |  |
| `str_sport` | `string` | No |  |
| `str_website` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:League():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `LeagueEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## PlayerEntity

```lua
local player = client:Player(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_born` | `string` | No |  |
| `id_player` | `string` | No |  |
| `str_cutout` | `string` | No |  |
| `str_description_en` | `string` | No |  |
| `str_height` | `string` | No |  |
| `str_nationality` | `string` | No |  |
| `str_player` | `string` | No |  |
| `str_position` | `string` | No |  |
| `str_sport` | `string` | No |  |
| `str_team` | `string` | No |  |
| `str_thumb` | `string` | No |  |
| `str_weight` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Player():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PlayerEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## TeamEntity

```lua
local team = client:Team(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_team` | `string` | No |  |
| `int_formed_year` | `string` | No |  |
| `int_stadium_capacity` | `string` | No |  |
| `str_alternate` | `string` | No |  |
| `str_description_en` | `string` | No |  |
| `str_league` | `string` | No |  |
| `str_sport` | `string` | No |  |
| `str_stadium` | `string` | No |  |
| `str_stadium_location` | `string` | No |  |
| `str_team` | `string` | No |  |
| `str_team_badge` | `string` | No |  |
| `str_team_jersey` | `string` | No |  |
| `str_website` | `string` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Team():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TeamEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```lua
local client = sdk.new({
  feature = {
    test = { active = true },
  },
})
```

