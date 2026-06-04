# FreeSports SDK

Free JSON sports data and artwork covering leagues, teams, players, and events

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About Free Sports API

The Free Sports API is provided by [TheSportsDB](https://www.thesportsdb.com/), a community-driven sports database that exposes its catalogue as JSON over HTTP at `https://www.thesportsdb.com/api/v1/json`. It covers a broad range of sports and includes both structured data and artwork.

What you get from the API:

- Lookups and listings for leagues, teams, players, and events
- Search by name (events, players) and filters by league or season
- Supplementary data such as venues, honours, TV listings and calendars, event highlights, and transfer information
- Country lists and artwork assets associated with teams and players

The free tier is served from `api/v1/json` and is intended for testing and light use; CORS is enabled on most endpoints. A paid tier (around USD 9/month at the time of writing) provides a dedicated production key, V2 API access, faster livescore updates, and video highlights. Specific rate limits for the free tier are not publicly enumerated, so treat the service as best-effort and cache where you can.

## Try it

**TypeScript**
```bash
npm install free-sports
```

**Python**
```bash
pip install free-sports-sdk
```

**PHP**
```bash
composer require voxgig/free-sports-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/free-sports-sdk/go
```

**Ruby**
```bash
gem install free-sports-sdk
```

**Lua**
```bash
luarocks install free-sports-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { FreeSportsSDK } from 'free-sports'

const client = new FreeSportsSDK({})

// List all events
const events = await client.Event().list()
```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o free-sports-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "free-sports": {
      "command": "/abs/path/to/free-sports-mcp"
    }
  }
}
```

## Entities

The API exposes 4 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Event** | A sporting fixture or match — searchable by name and season and retrievable with scores, highlights, and TV listings via the events endpoints. | `/{apiKey}/searchevents.php` |
| **League** | A competition grouping teams (e.g. a national league or cup); the free tier exposes a list-all-leagues endpoint with a cap on the number returned. | `/{apiKey}/lookupleague.php` |
| **Player** | An athlete profile with biographical fields such as birthday, searchable by name via the players endpoints. | `/{apiKey}/searchplayers.php` |
| **Team** | A club or national side belonging to a league, listable by league and enriched with venue and artwork data. | `/{apiKey}/searchteams.php` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from freesports_sdk import FreeSportsSDK

client = FreeSportsSDK({})

# List all events
events, err = client.Event(None).list(None, None)
```

### PHP

```php
<?php
require_once 'freesports_sdk.php';

$client = new FreeSportsSDK([]);

// List all events
[$events, $err] = $client->Event(null)->list(null, null);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/free-sports-sdk/go"

client := sdk.NewFreeSportsSDK(map[string]any{})

// List all events
events, err := client.Event(nil).List(nil, nil)
```

### Ruby

```ruby
require_relative "FreeSports_sdk"

client = FreeSportsSDK.new({})

# List all events
events, err = client.Event(nil).list(nil, nil)
```

### Lua

```lua
local sdk = require("free-sports_sdk")

local client = sdk.new({})

-- List all events
local events, err = client:Event(nil):list(nil, nil)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = FreeSportsSDK.test()
const result = await client.Event().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = FreeSportsSDK.test(None, None)
result, err = client.Event(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = FreeSportsSDK::test(null, null);
[$result, $err] = $client->Event(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Event(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = FreeSportsSDK.test(nil, nil)
result, err = client.Event(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Event(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the Free Sports API

- Upstream: [https://www.thesportsdb.com/](https://www.thesportsdb.com/)
- API docs: [https://www.thesportsdb.com/free_sports_api](https://www.thesportsdb.com/free_sports_api)

- Free tier provided by TheSportsDB.com; remains free at point of access.
- Usage governed by TheSportsDB terms of use and privacy policy.
- Premium tier (paid) unlocks dedicated production API keys and the V2 API.
- No explicit attribution requirement is published on the free tier page; check the official terms before redistributing data or artwork.

---

Generated from the Free Sports API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
