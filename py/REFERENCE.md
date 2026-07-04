# FreeSports Python SDK Reference

Complete API reference for the FreeSports Python SDK.


## FreeSportsSDK

### Constructor

```python
from free-sports_sdk import FreeSportsSDK

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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Event().list({})
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.League().list({})
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Player().list({})
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.Team().list({})
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

