# FreeSports TypeScript SDK

The TypeScript SDK for the FreeSports API. Provides a type-safe, entity-oriented interface with full async/await support.


## Install
```bash
npm install free-sports
```
## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { FreeSportsSDK } from 'free-sports'

const client = new FreeSportsSDK({
  apikey: process.env.FREE-SPORTS_APIKEY,
})
```

### 2. List events

```ts
const result = await client.Event().list()

if (result.ok) {
  for (const item of result.data) {
    console.log(item.id, item.name)
  }
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```ts
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```ts
const client = FreeSportsSDK.test()

const result = await client.Planet().load({ id: 'test01' })
// result.ok === true
// result.data contains mock response data
```

You can also use the instance method:

```ts
const client = new FreeSportsSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Planet()

// First call sets internal match
await entity.load({ id: 'example' })

// Subsequent calls reuse the stored match
const data = entity.data()
console.log(data.id) // 'example'
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new FreeSportsSDK({
  apikey: '...',
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
FREE-SPORTS_TEST_LIVE=TRUE
FREE-SPORTS_APIKEY=<your-key>
```

Then run:

```bash
cd ts && npm test
```


## Reference

### FreeSportsSDK

#### Constructor

```ts
new FreeSportsSDK(options?: {
  apikey?: string
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Event(data?)` | `EventEntity` | Create a Event entity instance. |
| `League(data?)` | `LeagueEntity` | Create a League entity instance. |
| `Player(data?)` | `PlayerEntity` | Create a Player entity instance. |
| `Team(data?)` | `TeamEntity` | Create a Team entity instance. |
| `tester(testopts?, sdkopts?)` | `FreeSportsSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `FreeSportsSDK.test(testopts?, sdkopts?)` | `FreeSportsSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Result>` | Load a single entity by match criteria. |
| `list` | `list(reqmatch?, ctrl?): Promise<Result>` | List entities matching the criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Result>` | Create a new entity. |
| `update` | `update(reqdata?, ctrl?): Promise<Result>` | Update an existing entity. |
| `remove` | `remove(reqmatch?, ctrl?): Promise<Result>` | Remove an entity. |
| `data` | `data(data?): any` | Get or set entity data. |
| `match` | `match(match?): any` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): FreeSportsSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Result shape

All entity operations return a Result object:

```ts
{
  ok: boolean      // true if the HTTP status is 2xx
  status: number   // HTTP status code
  headers: object  // response headers
  data: any        // parsed JSON response body
}
```

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

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

Operations: list.

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

Operations: list.

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

Operations: list.

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

Operations: list.

API path: `/{apiKey}/searchteams.php`



## Entities


### Event

Create an instance: `const event = client.Event()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```ts
const events = await client.Event().list()
```


### League

Create an instance: `const league = client.League()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```ts
const leagues = await client.League().list()
```


### Player

Create an instance: `const player = client.Player()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```ts
const players = await client.Player().list()
```


### Team

Create an instance: `const team = client.Team()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```ts
const teams = await client.Team().list()
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
error is returned to the caller.

An unexpected exception triggers the `PreUnexpected` hook before
propagating.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
free-sports/
├── src/
│   ├── FreeSportsSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { FreeSportsSDK } from 'free-sports'
```

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const moon = client.Moon()
await moon.load({ planet_id: 'earth', id: 'luna' })

// moon.data() now returns the loaded moon data
// moon.match() returns { planet_id: 'earth', id: 'luna' }
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
