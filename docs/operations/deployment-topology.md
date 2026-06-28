# Deployment Topology

This document records the coordination view of deployments. Exact deployable
definitions belong in the owning infrastructure or source repository.

## Topology

| Component | Owning repo | Deployment concern |
| --- | --- | --- |
| Platform services | `trading-platform` | Market data, storage, execution, MCP/API. |
| SDK packages | `trading-platform-sdk` | Package publishing and compatibility. |
| Agent workflows | `trading-lab` | Agent execution, research loops, scheduled jobs. |
| Operator UI | `trading-office` | UI deployment, API configuration, operator access. |
| Backtester | `trading-backtester` | Batch jobs, evidence storage, historical data access. |
| Mock platform | `trading-mock-platform` | Contract test and simulation environments. |
| Observability | Shared | Phoenix traces, logs, metrics, alerts, dashboards. |

## Deployment Rules

- Deploy source-of-truth changes before dependent consumer changes unless a feature flag
  or compatibility shim requires another order.
- SDK releases must include compatibility notes.
- Rollbacks must account for SDK and consumer compatibility.
- Telemetry for new capabilities must be available before production rollout.

