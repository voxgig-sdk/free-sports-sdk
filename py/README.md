# FreeSports Python SDK



The Python SDK for the FreeSports API — an entity-oriented client following Pythonic conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Event()` — each
carrying a small, uniform set of operations (`list`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to PyPI. Install it from the GitHub
release tag (`py/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/free-sports-sdk/releases)) or
from a source checkout:

```bash
pip install -e .
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```python
import os
from freesports_sdk import FreeSportsSDK

client = FreeSportsSDK({
    "apikey": os.environ.get("FREE_SPORTS_APIKEY"),
})
```

### 2. List event records

`list()` returns a `list` of records (each a `dict`) and raises on
error — iterate it directly.

```python
try:
    events = client.Event().list()
    for event in events:
        print(event)
except Exception as err:
    print(f"list failed: {err}")
```


## Error handling

Entity operations raise on failure, so wrap them in `try` / `except`:

```python
try:
    events = client.Event().list()
    print(events)
except Exception as err:
    print(f"list failed: {err}")
```

`direct()` does **not** raise — it returns the result envelope. Branch
on `ok`; on failure `status` holds the HTTP status (for error responses)
and `err` holds a transport error, so read both defensively:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example_id"},
})

if not result["ok"]:
    print("request failed:", result.get("status"), result.get("err"))
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})

if result["ok"]:
    print(result["status"])  # 200
    print(result["data"])    # response body
else:
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read both with .get() rather than indexing a key that may be absent.
    print(result.get("status"), result.get("err"))
```

### Prepare a request without sending it

```python
# prepare() returns the fetch definition and raises on error.
fetchdef = client.prepare({
    "path": "/api/resource/{id}",
    "method": "DELETE",
    "params": {"id": "example"},
})

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```python
client = FreeSportsSDK.test()

# Entity ops return the bare record and raise on error.
event = client.Event().list()
# event contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```python
def mock_fetch(url, init):
    return {
        "status": 200,
        "statusText": "OK",
        "headers": {},
        "json": lambda: {"id": "mock01"},
    }, None

client = FreeSportsSDK({
    "base": "http://localhost:8080",
    "system": {
        "fetch": mock_fetch,
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
cd py && pytest test/
```


## Reference

### FreeSportsSDK

```python
from freesports_sdk import FreeSportsSDK

client = FreeSportsSDK(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `str` | API key for authentication. |
| `base` | `str` | Base URL of the API server. |
| `prefix` | `str` | URL path prefix prepended to all requests. |
| `suffix` | `str` | URL path suffix appended to all requests. |
| `feature` | `dict` | Feature activation flags. |
| `extend` | `list` | Additional Feature instances to load. |
| `system` | `dict` | System overrides (e.g. custom `fetch` function). |

### test

```python
client = FreeSportsSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `None`.

### FreeSportsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> dict` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> dict` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> dict` | Build and send an HTTP request. Returns a result dict (branch on `ok`). |
| `Event` | `(data) -> EventEntity` | Create an Event entity instance. |
| `League` | `(data) -> LeagueEntity` | Create a League entity instance. |
| `Player` | `(data) -> PlayerEntity` | Create a Player entity instance. |
| `Team` | `(data) -> TeamEntity` | Create a Team entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(reqmatch, ctrl) -> list` | List entities matching the criteria. Raises on error. |
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `dict` for single-entity
ops, a `list` for `list`) and raise on error. Wrap calls in
`try`/`except` to handle failures.

The `direct()` escape hatch never raises — it returns a result `dict`
you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `True` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `dict` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `False` and `err` contains the error value.

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

Create an instance: `event = client.Event()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date_event` | `str` |  |
| `id_event` | `str` |  |
| `int_away_score` | `str` |  |
| `int_home_score` | `str` |  |
| `str_away_team` | `str` |  |
| `str_event` | `str` |  |
| `str_home_team` | `str` |  |
| `str_league` | `str` |  |
| `str_sport` | `str` |  |
| `str_status` | `str` |  |
| `str_thumb` | `str` |  |
| `str_time` | `str` |  |
| `str_venue` | `str` |  |
| `str_video` | `str` |  |

#### Example: List

```python
events = client.Event().list()
```


### League

Create an instance: `league = client.League()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id_league` | `str` |  |
| `int_formed_year` | `str` |  |
| `str_badge` | `str` |  |
| `str_country` | `str` |  |
| `str_description_en` | `str` |  |
| `str_league` | `str` |  |
| `str_league_alternate` | `str` |  |
| `str_logo` | `str` |  |
| `str_sport` | `str` |  |
| `str_website` | `str` |  |

#### Example: List

```python
leagues = client.League().list()
```


### Player

Create an instance: `player = client.Player()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date_born` | `str` |  |
| `id_player` | `str` |  |
| `str_cutout` | `str` |  |
| `str_description_en` | `str` |  |
| `str_height` | `str` |  |
| `str_nationality` | `str` |  |
| `str_player` | `str` |  |
| `str_position` | `str` |  |
| `str_sport` | `str` |  |
| `str_team` | `str` |  |
| `str_thumb` | `str` |  |
| `str_weight` | `str` |  |

#### Example: List

```python
players = client.Player().list()
```


### Team

Create an instance: `team = client.Team()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id_team` | `str` |  |
| `int_formed_year` | `str` |  |
| `int_stadium_capacity` | `str` |  |
| `str_alternate` | `str` |  |
| `str_description_en` | `str` |  |
| `str_league` | `str` |  |
| `str_sport` | `str` |  |
| `str_stadium` | `str` |  |
| `str_stadium_location` | `str` |  |
| `str_team` | `str` |  |
| `str_team_badge` | `str` |  |
| `str_team_jersey` | `str` |  |
| `str_website` | `str` |  |

#### Example: List

```python
teams = client.Team().list()
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

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

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is a Python class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dicts

The Python SDK uses plain dicts throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a dict.

### Module structure

```
py/
├── freesports_sdk.py         -- Main SDK module
├── config.py                    -- Configuration
├── features.py                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (Base, Test, Log)
├── utility/                     -- Utility functions and struct library
└── test/                        -- Test suites
```

The main module (`freesports_sdk`) exports the SDK class.
Import entity or utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```python
event = client.Event()
event.list()

# event.data_get() now returns the event data from the last list
# event.match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
