# FreeSports PHP SDK Reference

Complete API reference for the FreeSports PHP SDK.


## FreeSportsSDK

### Constructor

```php
require_once __DIR__ . '/free-sports_sdk.php';

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

#### `optionsMap(): array`

Return a deep copy of the current SDK options.

#### `getUtility(): ProjectNameUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. Returns `[$result, $err]`.

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

**Returns:** `array [$result, $err]`

#### `prepare(array $fetchargs = []): array`

Prepare a fetch definition without sending the request. Returns `[$fetchdef, $err]`.


---

## EventEntity

```php
$event = $client->Event();
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

#### `list(array $reqmatch, ?array $ctrl = null): array`

List entities matching the given criteria. Returns an array.

```php
[$results, $err] = $client->Event()->list([]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): EventEntity`

Create a new `EventEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## LeagueEntity

```php
$league = $client->League();
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

#### `list(array $reqmatch, ?array $ctrl = null): array`

List entities matching the given criteria. Returns an array.

```php
[$results, $err] = $client->League()->list([]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): LeagueEntity`

Create a new `LeagueEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## PlayerEntity

```php
$player = $client->Player();
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

#### `list(array $reqmatch, ?array $ctrl = null): array`

List entities matching the given criteria. Returns an array.

```php
[$results, $err] = $client->Player()->list([]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): PlayerEntity`

Create a new `PlayerEntity` instance with the same client and
options.

#### `getName(): string`

Return the entity name.


---

## TeamEntity

```php
$team = $client->Team();
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

#### `list(array $reqmatch, ?array $ctrl = null): array`

List entities matching the given criteria. Returns an array.

```php
[$results, $err] = $client->Team()->list([]);
```

### Common Methods

#### `dataGet(): array`

Get the entity data. Returns a copy of the current data.

#### `dataSet($data): void`

Set the entity data.

#### `matchGet(): array`

Get the entity match criteria.

#### `matchSet($match): void`

Set the entity match criteria.

#### `make(): TeamEntity`

Create a new `TeamEntity` instance with the same client and
options.

#### `getName(): string`

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

