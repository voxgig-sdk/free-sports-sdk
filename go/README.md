# FreeSports Golang SDK



The Golang SDK for the FreeSports API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

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

### 1. Create a client

```go
package main

import (
    "fmt"
    "os"

    sdk "github.com/voxgig-sdk/free-sports-sdk/go"
    "github.com/voxgig-sdk/free-sports-sdk/go/core"
)

func main() {
    client := sdk.NewFreeSportsSDK(map[string]any{
        "apikey": os.Getenv("FREE_SPORTS_APIKEY"),
    })
```

### 2. List events

```go
    result, err := client.Event(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }

    rm := core.ToMapAny(result)
    if rm["ok"] == true {
        for _, item := range rm["data"].([]any) {
            p := core.ToMapAny(item)
            fmt.Println(p["id"], p["name"])
        }
    }
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

result, err := client.Event(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
// result contains mock response data
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
| `Event` | `(data map[string]any) FreeSportsEntity` | Create a Event entity instance. |
| `League` | `(data map[string]any) FreeSportsEntity` | Create a League entity instance. |
| `Player` | `(data map[string]any) FreeSportsEntity` | Create a Player entity instance. |
| `Team` | `(data map[string]any) FreeSportsEntity` | Create a Team entity instance. |

### Entity interface (FreeSportsEntity)

All entities implement the `FreeSportsEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Update` | `(reqdata, ctrl map[string]any) (any, error)` | Update an existing entity. |
| `Remove` | `(reqmatch, ctrl map[string]any) (any, error)` | Remove an entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(any, error)`. The `any` value is a
`map[string]any` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `"ok"` | `bool` | `true` if the HTTP status is 2xx. |
| `"status"` | `int` | HTTP status code. |
| `"headers"` | `map[string]any` | Response headers. |
| `"data"` | `any` | Parsed JSON response body. |

On error, `"ok"` is `false` and `"err"` contains the error value.

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

```go
results, err := client.Event(nil).List(nil, nil)
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

```go
results, err := client.League(nil).List(nil, nil)
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

```go
results, err := client.Player(nil).List(nil, nil)
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

```go
results, err := client.Team(nil).List(nil, nil)
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
error is returned to the caller. An unexpected panic triggers the
`PreUnexpected` hook.

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

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
event := client.Event(nil)
event.Load(map[string]any{"id": "example_id"}, nil)

// event.Data() now returns the loaded event data
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
