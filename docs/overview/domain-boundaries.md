# Domain Boundaries

## Platform Boundary

`trading-platform` owns market data ingestion, storage, execution semantics, and
server-side MCP/API behavior. It should stay agent-agnostic.

## SDK Boundary

`trading-platform-sdk` owns typed client integration, client package ergonomics,
consumer-facing examples, and SDK version metadata.

## Agent Boundary

`trading-lab` owns agent workflows and research loops. It should use MCP and SDK
surfaces rather than private platform imports.

## Operator Boundary

`trading-office` owns operator screens and office workflows. It should depend on
public platform/SDK contracts.

## Validation Boundary

`trading-backtester` and `trading-mock-platform` own evidence, simulation, and
contract validation flows. They should validate public behavior and contracts.

