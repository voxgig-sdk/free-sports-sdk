# FreeSports PHP SDK Reference

Complete API reference for the FreeSports PHP SDK.


## FreeSportsSDK

### Constructor

```php
require_once __DIR__ . '/freesports_sdk.php';

$client = new FreeSportsSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["apikey"]` | `string` | API key for authentication. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `FreeSportsSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = FreeSportsSDK::test();
```


### Instance Methods

#### `Event($data = null)`

Create a new `EventEntity` instance. Pass `null` for no initial data.

#### `League($data = null)`

Create a new `LeagueEntity` instance. Pass `null` for no initial data.

#### `Player($data = null)`

Create a new `PlayerEntity` instance. Pass `null` for no initial data.

#### `Team($data = null)`

Create a new `TeamEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): FreeSportsUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## EventEntity

```php
$event = $client->Event();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Event()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): EventEntity`

Create a new `EventEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## LeagueEntity

```php
$league = $client->League();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->League()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): LeagueEntity`

Create a new `LeagueEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## PlayerEntity

```php
$player = $client->Player();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Player()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): PlayerEntity`

Create a new `PlayerEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## TeamEntity

```php
$team = $client->Team();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Team()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): TeamEntity`

Create a new `TeamEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new FreeSportsSDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

