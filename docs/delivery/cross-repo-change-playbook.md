# Cross-Repo Change Playbook

Use this playbook when a change affects platform behavior, MCP/API surfaces, SDK
contracts, telemetry contracts, or dependent consumer behavior.

## 1. Classify The Change

- Platform-only behavior change.
- Public MCP/API contract change.
- SDK contract change.
- Consumer behavior change.
- Observability or operational contract change.
- Migration or rollout change.

## 2. Update The Source Of Truth

- Platform behavior: update `trading-platform`.
- Client SDK contract: update `trading-platform-sdk`.
- Agent workflow: update `trading-lab`.
- Operator workflow: update `trading-office`.
- Backtest/validation behavior: update `trading-backtester`.
- Mock behavior: update `trading-mock-platform`.

## 3. Propagate Contract Changes

When a platform capability or MCP/API surface changes:

1. Update `trading-platform`.
2. Update `trading-platform-sdk` types, client methods, examples, and version metadata.
3. Update affected consumers.
4. Update mock platform behavior or contract fixtures.
5. Update validation gates and evidence expectations.

## 4. Validate

- Run platform tests.
- Run SDK tests and contract tests.
- Run mock-platform compatibility checks.
- Run affected consumer tests.
- Run backtester validation when execution semantics changed.

## 5. Roll Out

- Prepare rollout notes.
- Identify rollback path.
- Confirm observability coverage.
- Deploy in the agreed environment order.
- Record final status in changelog or migration notes.

