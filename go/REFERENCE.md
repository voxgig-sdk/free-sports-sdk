# FreeSports Golang SDK Reference

Complete API reference for the FreeSports Golang SDK.


## FreeSportsSDK

### Constructor

```go
func NewFreeSportsSDK(options map[string]any) *FreeSportsSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `TestSDK(testopts, sdkopts map[string]any) *FreeSportsSDK`

Create a test client with mock features active. Both arguments may be `nil`.

```go
client := sdk.TestSDK(nil, nil)
```


### Instance Methods

#### `Event(data map[string]any) FreeSportsEntity`

Create a new `Event` entity instance. Pass `nil` for no initial data.

#### `League(data map[string]any) FreeSportsEntity`

Create a new `League` entity instance. Pass `nil` for no initial data.

#### `Player(data map[string]any) FreeSportsEntity`

Create a new `Player` entity instance. Pass `nil` for no initial data.

#### `Team(data map[string]any) FreeSportsEntity`

Create a new `Team` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## EventEntity

```go
event := client.Event(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_event` | ``$STRING`` | No |  |
| `id_event` | ``$STRING`` | No |  |
| `int_away_score` | ``$STRING`` | No |  |
| `int_home_score` | ``$STRING`` | No |  |
| `str_away_team` | ``$STRING`` | No |  |
| `str_event` | ``$STRING`` | No |  |
| `str_home_team` | ``$STRING`` | No |  |
| `str_league` | ``$STRING`` | No |  |
| `str_sport` | ``$STRING`` | No |  |
| `str_status` | ``$STRING`` | No |  |
| `str_thumb` | ``$STRING`` | No |  |
| `str_time` | ``$STRING`` | No |  |
| `str_venue` | ``$STRING`` | No |  |
| `str_video` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Event(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `EventEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## LeagueEntity

```go
league := client.League(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_league` | ``$STRING`` | No |  |
| `int_formed_year` | ``$STRING`` | No |  |
| `str_badge` | ``$STRING`` | No |  |
| `str_country` | ``$STRING`` | No |  |
| `str_description_en` | ``$STRING`` | No |  |
| `str_league` | ``$STRING`` | No |  |
| `str_league_alternate` | ``$STRING`` | No |  |
| `str_logo` | ``$STRING`` | No |  |
| `str_sport` | ``$STRING`` | No |  |
| `str_website` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.League(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `LeagueEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## PlayerEntity

```go
player := client.Player(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_born` | ``$STRING`` | No |  |
| `id_player` | ``$STRING`` | No |  |
| `str_cutout` | ``$STRING`` | No |  |
| `str_description_en` | ``$STRING`` | No |  |
| `str_height` | ``$STRING`` | No |  |
| `str_nationality` | ``$STRING`` | No |  |
| `str_player` | ``$STRING`` | No |  |
| `str_position` | ``$STRING`` | No |  |
| `str_sport` | ``$STRING`` | No |  |
| `str_team` | ``$STRING`` | No |  |
| `str_thumb` | ``$STRING`` | No |  |
| `str_weight` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Player(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `PlayerEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## TeamEntity

```go
team := client.Team(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_team` | ``$STRING`` | No |  |
| `int_formed_year` | ``$STRING`` | No |  |
| `int_stadium_capacity` | ``$STRING`` | No |  |
| `str_alternate` | ``$STRING`` | No |  |
| `str_description_en` | ``$STRING`` | No |  |
| `str_league` | ``$STRING`` | No |  |
| `str_sport` | ``$STRING`` | No |  |
| `str_stadium` | ``$STRING`` | No |  |
| `str_stadium_location` | ``$STRING`` | No |  |
| `str_team` | ``$STRING`` | No |  |
| `str_team_badge` | ``$STRING`` | No |  |
| `str_team_jersey` | ``$STRING`` | No |  |
| `str_website` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Team(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `TeamEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewFreeSportsSDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

