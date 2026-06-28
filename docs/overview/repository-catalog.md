# Repository Catalog

## Current Repositories

| Repository | Category | Primary responsibility | Key integration points |
| --- | --- | --- | --- |
| `trading-platform` | Execution-oriented platform | Market data, storage, execution engine, MCP/API surfaces. | MCP, API, storage, execution events, telemetry. |
| `trading-platform-sdk` | SDK and client contract | Typed client packages, shared consumer types, integration helpers, examples. | Platform MCP/API contracts, version metadata, examples. |
| `trading-lab` | Research and agentic workflows | Agent loops, research workflows, hypothesis generation, orchestration. | MCP, SDK, Phoenix traces, experiment records. |
| `trading-office` | Operator workflows | Operator UI and office workflows. | SDK/API, auth, observability dashboards. |
| `trading-backtester` | Validation and evidence | Backtest jobs, validation gates, evidence-oriented test flows. | SDK/MCP, historical data, mock platform. |
| `trading-mock-platform` | Test double | Mock/simulated platform implementation for contract and integration checks. | SDK contract tests, consumer integration tests. |

## Ownership Notes

- `trading-platform` owns platform behavior. Do not encode platform execution semantics
  as primary truth in consumer repositories.
- `trading-platform-sdk` owns consumer-facing typed integration. Do not make consumers
  import platform internals to bypass the SDK.
- `trading-control-center` owns coordination knowledge. It should point to implementation
  specs in sibling repos instead of copying them.

