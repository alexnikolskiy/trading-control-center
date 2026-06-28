# trading-control-center

Coordination repository for the trading ecosystem.

This repository is not a runtime service and does not own product implementation code.
It owns the system map, architectural rules, cross-repo delivery playbooks,
operations knowledge, and historical records used by humans and coding agents.

## Ecosystem

The current sibling repositories are:

| Repository | Role | Source of truth |
| --- | --- | --- |
| `trading-platform` | Core platform for market data ingestion, storage, execution, and MCP/API surfaces. | Platform behavior, execution semantics, server MCP/API surfaces. |
| `trading-platform-sdk` | Standalone SDK repository for external and internal consumers. | Client-facing SDK contract, typed integration surface, examples. |
| `trading-lab` | Agent workflows, research loops, hypothesis generation, and orchestration. | Agentic workflows built on MCP/SDK. |
| `trading-office` | Operator UI and office workflows. | Human operator experience and office workflows. |
| `trading-backtester` | Backtesting, validation flows, and evidence-oriented scenarios. | Backtest execution and validation evidence. |
| `trading-mock-platform` | Mock/simulated platform implementation. | Contract and integration test doubles. |

## Scope

This repo should contain:

- ecosystem maps and repository catalog entries;
- durable architecture principles and ADRs;
- cross-repo change playbooks and release checklists;
- deployment topology, runbooks, and rollback notes;
- observability, logging, telemetry, and alert ownership maps;
- historical records: RFCs, migrations, incidents, postmortems, experiments, and cross-repo changelogs.

This repo should not contain:

- core runtime code from `trading-platform`;
- SDK runtime code from `trading-platform-sdk`;
- agent runtime code from `trading-lab`;
- UI runtime code from `trading-office`;
- detailed implementation specs that belong to a sibling source repository;
- a monolithic deployable replacement for the ecosystem.

## First Files To Read

1. [AGENTS.md](AGENTS.md)
2. [docs/overview/ecosystem-map.md](docs/overview/ecosystem-map.md)
3. [docs/overview/repository-catalog.md](docs/overview/repository-catalog.md)
4. [docs/architecture/principles.md](docs/architecture/principles.md)
5. [docs/delivery/cross-repo-change-playbook.md](docs/delivery/cross-repo-change-playbook.md)
6. [docs/operations/observability-map.md](docs/operations/observability-map.md)
7. [docs/overview/gortex-workspace.md](docs/overview/gortex-workspace.md)

## Operating Model

Changes that affect a platform capability, MCP surface, API contract, SDK behavior,
or dependent consumer should be treated as cross-repo changes:

1. Update the source-of-truth repository first.
2. Update `trading-platform-sdk` when the consumer contract changes.
3. Update affected consumers such as `trading-lab`, `trading-backtester`, and `trading-office`.
4. Run validation gates across platform, SDK, mock platform, and consumers.
5. Record rollout notes, migration notes, or a changelog entry when behavior changes.

Use [docs/delivery/cross-repo-change-playbook.md](docs/delivery/cross-repo-change-playbook.md)
for the full workflow.

## Cross-Repo Code Intelligence

Use Gortex for sibling-repository lookup before falling back to raw file scans.
The expected tracked repos are `trading-platform`, `trading-platform-sdk`,
`trading-lab`, `trading-office`, `trading-backtester`, and `trading-mock-platform`.

See [docs/overview/gortex-workspace.md](docs/overview/gortex-workspace.md).
