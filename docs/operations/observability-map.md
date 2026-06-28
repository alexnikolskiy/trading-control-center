# Observability Map

Observability is a cross-repo contract. Every runtime service must make its work
traceable across SDK calls, MCP tool calls, agent sessions, operator actions, and
backtest evidence.

## Stack

| Layer | Standard |
| --- | --- |
| Traces and spans | Phoenix for platform, MCP, LLM, agent, and backtest spans. |
| Logs | Structured JSON logs in all runtime services. |
| Correlation | Stable IDs propagated across SDK, MCP, HTTP, job, and agent boundaries. |
| Evidence | Backtester evidence records include job IDs, strategy IDs, bundle hashes, SDK version, and validation outcome. |

## Telemetry Ownership

| Repo / service | Emits | Owns traces | Exposes metrics |
| --- | --- | --- | --- |
| `trading-platform` | Market data ingestion events, execution events, MCP tool call spans, API request logs, structured errors. | Platform request traces, MCP server spans, execution lifecycle spans, market data ingestion spans. | API latency/error rates, MCP tool latency/error rates, market data freshness, execution success/failure counts, queue depth where applicable. |
| `trading-lab` | Agent loop events, LLM call spans, MCP client spans, research session events, hypothesis evaluation logs. | Agent session traces, LLM spans, planner/critic/researcher spans, outbound MCP client spans. | Agent run duration, LLM latency/cost, tool-call count, hypothesis acceptance/rejection counts, workflow failure rates. |
| `trading-backtester` | Backtest job traces, bundle validation spans, evidence run events, strategy evaluation metrics. | Backtest job traces, strategy bundle validation traces, evidence generation spans. | Job duration, pass/fail counts, strategy evaluation scores, bundle validation failures, evidence artifact counts. |
| `trading-office` | Operator action logs, UI session events, API connector logs. | Operator workflow traces when an action calls platform, lab, or backtester services. | UI/API error rates, operator action latency, session counts, failed action counts. |
| `trading-platform-sdk` | No runtime telemetry by itself; SDK is a library. It may propagate caller-provided correlation IDs and expose hooks/helpers for instrumentation. | None as an owning service. Consumers own spans created through SDK calls. | None as an owning service. Consumers expose metrics for SDK-backed operations. |
| `trading-mock-platform` | Contract conformance test results, simulated platform request logs, fixture mismatch diagnostics. | Mock request traces in test environments and contract conformance spans. | Contract pass/fail counts, fixture mismatch counts, simulated request latency. |

## Required Correlation Identifiers

| Identifier | Created by | Propagated to | Purpose |
| --- | --- | --- | --- |
| `trace_id` | First runtime boundary that starts the request or job. | All downstream services. | Join logs and spans across repos. |
| `request_id` | HTTP/API ingress or operator action boundary. | Platform, office, lab, SDK-backed clients. | Debug a single external request or operator action. |
| `agent_session_id` | `trading-lab`. | Lab spans, MCP client calls, platform MCP spans. | Join agent loop decisions to platform tool calls. |
| `tool_call_id` | MCP client or MCP server boundary. | Lab MCP client spans and platform MCP server spans. | Debug a single MCP invocation. |
| `backtest_job_id` | `trading-backtester`. | Backtester traces, platform calls made for validation, evidence records. | Join evidence, platform events, and validation output. |
| `strategy_id` | Lab or backtester depending on workflow. | Lab, backtester, evidence records. | Identify the strategy under evaluation. |
| `bundle_hash` | `trading-backtester`. | Backtester, SDK consumers, lab evidence references. | Identify the canonical strategy bundle content. |
| `sdk_version` | SDK consumer at runtime or test time. | Logs, traces, evidence records. | Debug compatibility issues. |

## Correlation Strategy

### MCP Boundaries

MCP clients pass `trace_id`, `agent_session_id`, and `tool_call_id` in request
metadata whenever the protocol surface supports metadata. The platform records
those IDs on the MCP server span and in structured logs. If the platform creates
child spans for execution or market data operations, those spans inherit the same
trace context.

### Backtest Jobs

`trading-backtester` creates `backtest_job_id` at job submission. Any platform or
mock-platform request made for that job carries `backtest_job_id`, `trace_id`,
`strategy_id`, `bundle_hash`, and `sdk_version`. Evidence artifacts store the
same identifiers so a failed validation can be traced back to platform events and
SDK version.

### Agent Sessions

`trading-lab` creates `agent_session_id` for research or agent loops. Each LLM
call, hypothesis evaluation, MCP client call, and downstream platform MCP span
must include that session ID. This lets a single agent decision be reconstructed
from lab trace, LLM span, MCP tool call, and platform result.

### Operator Actions

`trading-office` creates or forwards `request_id` for each operator action.
Actions that call platform, lab, or backtester services also carry `trace_id`.
Operator logs should include the target service, action name, outcome, and any
returned domain identifier such as `backtest_job_id` or `agent_session_id`.

## Alert Ownership

| Alert category | Primary owner | Escalate to | Examples |
| --- | --- | --- | --- |
| Platform API or MCP failures | `trading-platform` | SDK owner if client compatibility is suspected; lab/office/backtester owner if isolated to one consumer. | Elevated MCP errors, API 5xx, execution failures. |
| Market data ingestion freshness | `trading-platform` | Backtester owner if validation data is affected. | Stale market data, ingestion lag, missing exchange updates. |
| SDK compatibility failures | `trading-platform-sdk` | Affected consumer owner. | `sdk:verify` failure, clean-consumer failure, semver mismatch. |
| Agent run failures or LLM/tool-call regressions | `trading-lab` | Platform owner if MCP server spans fail; SDK owner if client types/helpers are implicated. | Agent loop crash, repeated tool-call failures, unexpected LLM cost spike. |
| Backtest job or evidence failures | `trading-backtester` | Platform owner for execution/data issues; SDK owner for contract issues. | Bundle validation failure, evidence generation failure, strategy evaluation errors. |
| Operator workflow failures | `trading-office` | Platform, lab, or backtester owner based on target service. | Failed operator action, UI-triggered API error, session-level workflow failure. |
| Mock contract drift | `trading-mock-platform` | SDK and platform owners. | Contract fixture mismatch, mock response no longer matches SDK expectations. |

## Escalation Path

1. Page or notify the primary owner for the alert category.
2. Attach `trace_id`, `request_id`, and any domain identifier such as
   `agent_session_id`, `tool_call_id`, `backtest_job_id`, or `bundle_hash`.
3. If the trace crosses a repo boundary, notify the downstream or upstream owner
   listed in the alert table.
4. If production behavior changed, open or update an incident record and preserve
   Phoenix trace links, log queries, release versions, and rollback decisions.
