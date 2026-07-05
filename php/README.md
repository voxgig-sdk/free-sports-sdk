# FreeSports PHP SDK



The PHP SDK for the FreeSports API — an entity-oriented client using PHP conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `$client->Event()` — with named operations (`list`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Packagist. Install it from the
GitHub release tag (`php/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/free-sports-sdk/releases](https://github.com/voxgig-sdk/free-sports-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```php
<?php
require_once 'freesports_sdk.php';

$client = new FreeSportsSDK([
    "apikey" => getenv("FREE_SPORTS_APIKEY"),
]);
```

### 2. List event records

```php
try {
    // list() returns an array of Event records — iterate directly.
    $events = $client->Event()->list();
    foreach ($events as $item) {
        echo $item["date_event"] . "\n";
    }
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```


## Error handling

Entity operations throw a `\Throwable` on failure, so wrap them in
`try` / `catch`:

```php
try {
    $events = $client->Event()->list();
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```

`direct()` does **not** throw — it returns the result array. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```php
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example_id"],
]);

if (! $result["ok"]) {
    $err = $result["err"] ?? null;
    echo "request failed: " . ($err ? $err->getMessage() : "HTTP " . $result["status"]);
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```php
// direct() is the raw-HTTP escape hatch: it returns a result array
// (it does not throw). Branch on $result["ok"].
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);

if ($result["ok"]) {
    echo $result["status"];  // 200
    print_r($result["data"]);  // response body
} else {
    // On an HTTP error status there is no err (only a transport failure sets
    // it), so fall back to the status code.
    $err = $result["err"] ?? null;
    echo "Error: " . ($err ? $err->getMessage() : "HTTP " . $result["status"]);
}
```

### Prepare a request without sending it

```php
// prepare() throws on error and returns the fetch definition.
$fetchdef = $client->prepare([
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => ["id" => "example"],
]);

echo $fetchdef["url"];
echo $fetchdef["method"];
print_r($fetchdef["headers"]);
```

### Use test mode

Create a mock client for unit testing — no server required:

```php
$client = FreeSportsSDK::test();

// Entity ops return the bare mock record (throws on error).
$event = $client->Event()->list();
print_r($event);
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```php
$mock_fetch = function ($url, $init) {
    return [
        [
            "status" => 200,
            "statusText" => "OK",
            "headers" => [],
            "json" => function () { return ["id" => "mock01"]; },
        ],
        null,
    ];
};

$client = new FreeSportsSDK([
    "base" => "http://localhost:8080",
    "system" => [
        "fetch" => $mock_fetch,
    ],
]);
```

### Run live tests

Create a `.env.local` file at the project root:

```
FREE_SPORTS_TEST_LIVE=TRUE
FREE_SPORTS_APIKEY=<your-key>
```

Then run:

```bash
cd php && ./vendor/bin/phpunit test/
```


## Reference

### FreeSportsSDK

```php
require_once 'freesports_sdk.php';
$client = new FreeSportsSDK($options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `array` | Feature activation flags. |
| `extend` | `array` | Additional Feature instances to load. |
| `system` | `array` | System overrides (e.g. custom `fetch` callable). |

### test

```php
$client = FreeSportsSDK::test($testopts, $sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### FreeSportsSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `(): array` | Deep copy of current SDK options. |
| `get_utility` | `(): Utility` | Copy of the SDK utility object. |
| `prepare` | `(array $fetchargs): array` | Build an HTTP request definition without sending. |
| `direct` | `(array $fetchargs): array` | Build and send an HTTP request. |
| `Event` | `($data): EventEntity` | Create an Event entity instance. |
| `League` | `($data): LeagueEntity` | Create a League entity instance. |
| `Player` | `($data): PlayerEntity` | Create a Player entity instance. |
| `Team` | `($data): TeamEntity` | Create a Team entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(?array $reqmatch = null, $ctrl): array` | List entities matching the criteria (call with no argument to list all). |
| `data_get` | `(): array` | Get entity data. |
| `data_set` | `($data): void` | Set entity data. |
| `match_get` | `(): array` | Get entity match criteria. |
| `match_set` | `($match): void` | Set entity match criteria. |
| `make` | `(): Entity` | Create a new instance with the same options. |
| `get_name` | `(): string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (an `array` for single-entity
ops, a `list` for `list`) and throw on error. Wrap calls in
`try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `array`
you branch on via `$result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `array` | Response headers. |
| `data` | `mixed` | Parsed JSON response body. |

On error, `ok` is `false` and `$err` contains the error value.

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

Create an instance: `$event = $client->Event();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```php
// list() returns an array of Event records (throws on error).
$events = $client->Event()->list();
```


### League

Create an instance: `$league = $client->League();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```php
// list() returns an array of League records (throws on error).
$leagues = $client->League()->list();
```


### Player

Create an instance: `$player = $client->Player();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```php
// list() returns an array of Player records (throws on error).
$players = $client->Player()->list();
```


### Team

Create an instance: `$team = $client->Team();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```php
// list() returns an array of Team records (throws on error).
$teams = $client->Team()->list();
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

Features are the extension mechanism. A feature is a PHP class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as arrays

The PHP SDK uses plain PHP associative arrays throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers::to_map()` to safely validate that a value is an array.

### Directory structure

```
php/
├── freesports_sdk.php          -- Main SDK class
├── config.php                     -- Configuration
├── features.php                   -- Feature factory
├── core/                          -- Core types and context
├── entity/                        -- Entity implementations
├── feature/                       -- Built-in features (Base, Test, Log)
├── utility/                       -- Utility functions and struct library
└── test/                          -- Test suites
```

The main class (`freesports_sdk.php`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```php
$event = $client->Event();
$event->list();

// $event->data_get() now returns the event data from the last list
// $event->match_get() returns the last match criteria
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
