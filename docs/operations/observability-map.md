# Observability Map

Phoenix is the selected observability stack for agentic and LLM-facing telemetry.
This repository tracks the cross-repo observability map and ownership conventions.

## Signals

| Signal | Applies to | Notes |
| --- | --- | --- |
| Traces | Platform, lab, backtester, office | Correlate user/API request, MCP call, agent run, and job IDs. |
| Logs | All runtime repos | Structured logs with correlation identifiers. |
| Metrics | Platform and jobs | Latency, throughput, errors, queue depth, execution outcomes. |
| LLM telemetry | Lab and agentic flows | Model, prompt version, tool calls, cost, latency, failures. |
| Backtest evidence | Backtester | Dataset, strategy version, platform contract version, outputs. |
| Webhook callbacks | Platform and consumers | Delivery status, retries, target, correlation IDs. |

## Correlation Identifiers

Use stable identifiers across repo boundaries:

- `request_id`
- `trace_id`
- `agent_run_id`
- `tool_call_id`
- `backtest_job_id`
- `strategy_id`
- `platform_capability_version`
- `sdk_version`

## Ownership

- Platform telemetry: `trading-platform`.
- SDK telemetry hooks and examples: `trading-platform-sdk`.
- Agent traces and tool-call telemetry: `trading-lab`.
- Operator workflow logs: `trading-office`.
- Backtest job evidence: `trading-backtester`.
- Contract/simulation telemetry: `trading-mock-platform`.
- Cross-repo standards and maps: `trading-control-center`.

