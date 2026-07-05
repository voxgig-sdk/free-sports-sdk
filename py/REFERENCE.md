# FreeSports Python SDK Reference

Complete API reference for the FreeSports Python SDK.


## FreeSportsSDK

### Constructor

```python
from freesports_sdk import FreeSportsSDK

client = FreeSportsSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `FreeSportsSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = FreeSportsSDK.test()
```


### Instance Methods

#### `Event(data=None)`

Create a new `EventEntity` instance. Pass `None` for no initial data.

#### `League(data=None)`

Create a new `LeagueEntity` instance. Pass `None` for no initial data.

#### `Player(data=None)`

Create a new `PlayerEntity` instance. Pass `None` for no initial data.

#### `Team(data=None)`

Create a new `TeamEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## EventEntity

```python
event = client.Event()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_event` | `str` | No |  |
| `id_event` | `str` | No |  |
| `int_away_score` | `str` | No |  |
| `int_home_score` | `str` | No |  |
| `str_away_team` | `str` | No |  |
| `str_event` | `str` | No |  |
| `str_home_team` | `str` | No |  |
| `str_league` | `str` | No |  |
| `str_sport` | `str` | No |  |
| `str_status` | `str` | No |  |
| `str_thumb` | `str` | No |  |
| `str_time` | `str` | No |  |
| `str_venue` | `str` | No |  |
| `str_video` | `str` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Event().list()
for event in results:
    print(event)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `EventEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## LeagueEntity

```python
league = client.League()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_league` | `str` | No |  |
| `int_formed_year` | `str` | No |  |
| `str_badge` | `str` | No |  |
| `str_country` | `str` | No |  |
| `str_description_en` | `str` | No |  |
| `str_league` | `str` | No |  |
| `str_league_alternate` | `str` | No |  |
| `str_logo` | `str` | No |  |
| `str_sport` | `str` | No |  |
| `str_website` | `str` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.League().list()
for league in results:
    print(league)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `LeagueEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## PlayerEntity

```python
player = client.Player()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `date_born` | `str` | No |  |
| `id_player` | `str` | No |  |
| `str_cutout` | `str` | No |  |
| `str_description_en` | `str` | No |  |
| `str_height` | `str` | No |  |
| `str_nationality` | `str` | No |  |
| `str_player` | `str` | No |  |
| `str_position` | `str` | No |  |
| `str_sport` | `str` | No |  |
| `str_team` | `str` | No |  |
| `str_thumb` | `str` | No |  |
| `str_weight` | `str` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Player().list()
for player in results:
    print(player)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PlayerEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## TeamEntity

```python
team = client.Team()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id_team` | `str` | No |  |
| `int_formed_year` | `str` | No |  |
| `int_stadium_capacity` | `str` | No |  |
| `str_alternate` | `str` | No |  |
| `str_description_en` | `str` | No |  |
| `str_league` | `str` | No |  |
| `str_sport` | `str` | No |  |
| `str_stadium` | `str` | No |  |
| `str_stadium_location` | `str` | No |  |
| `str_team` | `str` | No |  |
| `str_team_badge` | `str` | No |  |
| `str_team_jersey` | `str` | No |  |
| `str_website` | `str` | No |  |

### Operations

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Team().list()
for team in results:
    print(team)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TeamEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = FreeSportsSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

