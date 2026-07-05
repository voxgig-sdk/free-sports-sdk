# FreeSports TypeScript SDK



The TypeScript SDK for the FreeSports API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Event()` — each with a small set of operations (`list`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/free-sports-sdk/releases](https://github.com/voxgig-sdk/free-sports-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { FreeSportsSDK } from '@voxgig-sdk/free-sports'

const client = new FreeSportsSDK({
  apikey: process.env.FREE_SPORTS_APIKEY,
})
```

### 2. List event records

`list()` resolves to an array of Event objects — iterate it directly:

```ts
const events = await client.Event().list()

for (const event of events) {
  console.log(event)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const events = await client.Event().list()
  console.log(events)
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
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

if (result instanceof Error) {
  throw result
}
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

const event = await client.Event().list()
// event is a bare entity populated with mock response data
console.log(event)
```

You can also use the instance method:

```ts
const client = new FreeSportsSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Event()

// First call runs the operation and stores its result
await entity.list()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data)
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
FREE_SPORTS_TEST_LIVE=TRUE
FREE_SPORTS_APIKEY=<your-key>
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
| `Event(data?)` | `EventEntity` | Create an Event entity instance. |
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
| `list` | `list(reqmatch?, ctrl?): Promise<Entity[]>` | List entities matching the criteria. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): FreeSportsSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `list` resolves to an **array** of entity objects (iterate it directly;
  there is no `.data` and no `.ok`).

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

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

```ts
const teams = await client.Team().list()
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
import { FreeSportsSDK } from '@voxgig-sdk/free-sports'
```

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const event = client.Event()
await event.list()

// event.data() now returns the event data from the last `list`
// event.match() returns the last match criteria
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
