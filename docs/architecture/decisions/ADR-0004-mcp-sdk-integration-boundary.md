# ADR-0004: MCP And SDK Integration Boundary

## Status

Accepted

## Context

Consumers need stable integration without coupling to platform internals.

## Decision

Use MCP and SDK surfaces as the primary integration boundary.

## Consequences

- Agent and consumer repos avoid private platform imports.
- Contract tests can validate behavior at public boundaries.

