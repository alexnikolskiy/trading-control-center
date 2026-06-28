# Architecture Principles

## Durable Invariants

- `trading-platform` remains agent-agnostic.
- `trading-platform` is the source of truth for server behavior, MCP/API surfaces,
  execution semantics, market data integration, and storage behavior.
- `trading-platform-sdk` is a separate sibling repository and the canonical SDK
  layer for consumers.
- `trading-platform-sdk` is the source of truth for client SDK contracts, typed
  integration surfaces, and consumer-facing examples.
- MCP is the primary integration boundary between the platform and agentic systems.
- Runtime implementation code stays in the owning source repository.
- Implementation-specific specs stay in their source repositories.
- `trading-control-center` stores system rules, indexes, durable decisions, playbooks,
  operational context, and historical memory.

## Dependency Rules

- Consumers may depend on public platform contracts and SDK packages.
- Consumers must not depend on private platform internals.
- Agent workflows should call MCP tools and SDK helpers instead of importing platform code.
- Contract and integration checks should use public surfaces and `trading-mock-platform`.
- Cross-repo behavior changes must include SDK, consumer, validation, and rollout review.

