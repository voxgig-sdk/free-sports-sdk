# FreeSports TypeScript SDK Reference

Complete API reference for the FreeSports TypeScript SDK.


## FreeSportsSDK

### Constructor

```ts
new FreeSportsSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `FreeSportsSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = FreeSportsSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `FreeSportsSDK` instance in test mode.


### Instance Methods

#### `Event(data?: object)`

Create a new `Event` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `EventEntity` instance.

#### `League(data?: object)`

Create a new `League` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `LeagueEntity` instance.

#### `Player(data?: object)`

Create a new `Player` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `PlayerEntity` instance.

#### `Team(data?: object)`

Create a new `Team` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `TeamEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `FreeSportsSDK.test()`.

**Returns:** `FreeSportsSDK` instance in test mode.


---

## EventEntity

```ts
const event = client.Event()
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

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Event().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `EventEntity` instance with the same client and
options.

#### `client()`

Return the parent `FreeSportsSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## LeagueEntity

```ts
const league = client.League()
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

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.League().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `LeagueEntity` instance with the same client and
options.

#### `client()`

Return the parent `FreeSportsSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## PlayerEntity

```ts
const player = client.Player()
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

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Player().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `PlayerEntity` instance with the same client and
options.

#### `client()`

Return the parent `FreeSportsSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## TeamEntity

```ts
const team = client.Team()
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

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Team().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `TeamEntity` instance with the same client and
options.

#### `client()`

Return the parent `FreeSportsSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new FreeSportsSDK({
  feature: {
    test: { active: true },
  }
})
```

