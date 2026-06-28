# ADR-0002: Platform Is Agent-Agnostic

## Status

Accepted

## Context

Agentic workflows need platform capabilities, but platform behavior should not be
shaped around one agent implementation.

## Decision

`trading-platform` remains agent-agnostic and exposes public MCP/API surfaces.

## Consequences

- Agent systems integrate through MCP and SDK.
- Platform semantics stay stable and testable outside any single agent workflow.

