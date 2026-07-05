# FreeSports Golang SDK



The Golang SDK for the FreeSports API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.Event(nil)` — each with the same small set of operations (`List`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/free-sports-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/free-sports-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/free-sports-sdk/go=../free-sports-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/free-sports-sdk/go"
)

func main() {
    client := sdk.NewFreeSportsSDK(map[string]any{
        "apikey": os.Getenv("FREE_SPORTS_APIKEY"),
    })

    // List event records — the value is the array of records itself.
    events, err := client.Event(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }
    for _, item := range events.([]any) {
        fmt.Println(item)
    }
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
events, err := client.Event(nil).List(nil, nil)
if err != nil {
    // handle err
    return
}
_ = events
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

event, err := client.Event(nil).List(
    nil, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(event) // the returned mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewFreeSportsSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
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
cd go && go test ./test/...
```


## Reference

### NewFreeSportsSDK

```go
func NewFreeSportsSDK(options map[string]any) *FreeSportsSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *FreeSportsSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### FreeSportsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Event` | `(data map[string]any) FreeSportsEntity` | Create an Event entity instance. |
| `League` | `(data map[string]any) FreeSportsEntity` | Create a League entity instance. |
| `Player` | `(data map[string]any) FreeSportsEntity` | Create a Player entity instance. |
| `Team` | `(data map[string]any) FreeSportsEntity` | Create a Team entity instance. |

### Entity interface (FreeSportsEntity)

All entities implement the `FreeSportsEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `List` | a `[]any` of entity records |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    event, err := client.Event(nil).List(map[string]any{/* fields */}, nil)
    if err != nil { /* handle */ }
    // event is the returned record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Event

| Field | Description |
| --- | --- |
| `"date_event"` |  |
| `"id_event"` |  |
| `"int_away_score"` |  |
| `"int_home_score"` |  |
| `"str_away_team"` |  |
| `"str_event"` |  |
| `"str_home_team"` |  |
| `"str_league"` |  |
| `"str_sport"` |  |
| `"str_status"` |  |
| `"str_thumb"` |  |
| `"str_time"` |  |
| `"str_venue"` |  |
| `"str_video"` |  |

Operations: List.

API path: `/{apiKey}/searchevents.php`

#### League

| Field | Description |
| --- | --- |
| `"id_league"` |  |
| `"int_formed_year"` |  |
| `"str_badge"` |  |
| `"str_country"` |  |
| `"str_description_en"` |  |
| `"str_league"` |  |
| `"str_league_alternate"` |  |
| `"str_logo"` |  |
| `"str_sport"` |  |
| `"str_website"` |  |

Operations: List.

API path: `/{apiKey}/lookupleague.php`

#### Player

| Field | Description |
| --- | --- |
| `"date_born"` |  |
| `"id_player"` |  |
| `"str_cutout"` |  |
| `"str_description_en"` |  |
| `"str_height"` |  |
| `"str_nationality"` |  |
| `"str_player"` |  |
| `"str_position"` |  |
| `"str_sport"` |  |
| `"str_team"` |  |
| `"str_thumb"` |  |
| `"str_weight"` |  |

Operations: List.

API path: `/{apiKey}/searchplayers.php`

#### Team

| Field | Description |
| --- | --- |
| `"id_team"` |  |
| `"int_formed_year"` |  |
| `"int_stadium_capacity"` |  |
| `"str_alternate"` |  |
| `"str_description_en"` |  |
| `"str_league"` |  |
| `"str_sport"` |  |
| `"str_stadium"` |  |
| `"str_stadium_location"` |  |
| `"str_team"` |  |
| `"str_team_badge"` |  |
| `"str_team_jersey"` |  |
| `"str_website"` |  |

Operations: List.

API path: `/{apiKey}/searchteams.php`



## Entities


### Event

Create an instance: `event := client.Event(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date_event` | `string` |  |
| `id_event` | `string` |  |
| `int_away_score` | `string` |  |
| `int_home_score` | `string` |  |
| `str_away_team` | `string` |  |
| `str_event` | `string` |  |
| `str_home_team` | `string` |  |
| `str_league` | `string` |  |
| `str_sport` | `string` |  |
| `str_status` | `string` |  |
| `str_thumb` | `string` |  |
| `str_time` | `string` |  |
| `str_venue` | `string` |  |
| `str_video` | `string` |  |

#### Example: List

```go
events, err := client.Event(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(events) // the array of records
```


### League

Create an instance: `league := client.League(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id_league` | `string` |  |
| `int_formed_year` | `string` |  |
| `str_badge` | `string` |  |
| `str_country` | `string` |  |
| `str_description_en` | `string` |  |
| `str_league` | `string` |  |
| `str_league_alternate` | `string` |  |
| `str_logo` | `string` |  |
| `str_sport` | `string` |  |
| `str_website` | `string` |  |

#### Example: List

```go
leagues, err := client.League(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(leagues) // the array of records
```


### Player

Create an instance: `player := client.Player(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `date_born` | `string` |  |
| `id_player` | `string` |  |
| `str_cutout` | `string` |  |
| `str_description_en` | `string` |  |
| `str_height` | `string` |  |
| `str_nationality` | `string` |  |
| `str_player` | `string` |  |
| `str_position` | `string` |  |
| `str_sport` | `string` |  |
| `str_team` | `string` |  |
| `str_thumb` | `string` |  |
| `str_weight` | `string` |  |

#### Example: List

```go
players, err := client.Player(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(players) // the array of records
```


### Team

Create an instance: `team := client.Team(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id_team` | `string` |  |
| `int_formed_year` | `string` |  |
| `int_stadium_capacity` | `string` |  |
| `str_alternate` | `string` |  |
| `str_description_en` | `string` |  |
| `str_league` | `string` |  |
| `str_sport` | `string` |  |
| `str_stadium` | `string` |  |
| `str_stadium_location` | `string` |  |
| `str_team` | `string` |  |
| `str_team_badge` | `string` |  |
| `str_team_jersey` | `string` |  |
| `str_website` | `string` |  |

#### Example: List

```go
teams, err := client.Team(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(teams) // the array of records
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

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/free-sports-sdk/go/
├── free-sports.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/free-sports-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `List`, the entity
stores the returned data and match criteria internally.

```go
event := client.Event(nil)
event.List(nil, nil)

// event.Data() now returns the event data from the last list
// event.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
