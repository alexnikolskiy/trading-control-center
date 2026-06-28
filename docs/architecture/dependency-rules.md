# Dependency Rules

## Allowed

- `trading-platform-sdk` consumes public platform MCP/API contracts.
- `trading-lab`, `trading-office`, and `trading-backtester` consume SDK packages.
- `trading-backtester` and `trading-mock-platform` validate public platform behavior.
- `trading-control-center` links to sibling repositories and records cross-repo context.

## Not Allowed

- Consumer repositories importing private `trading-platform` internals.
- Moving core runtime code into `trading-control-center`.
- Duplicating implementation-specific specs from sibling repos as competing sources of truth.
- Treating mock behavior as the primary source of platform semantics.

## Review Checklist

- Does this change preserve the platform as the server-side source of truth?
- Does this change preserve the SDK as the client contract source of truth?
- Are consumers using MCP/SDK rather than internal imports?
- Are validation gates updated for any changed contract?

