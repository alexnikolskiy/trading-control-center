# AGENTS.md

## Purpose

`trading-control-center` is the coordination repository for the trading ecosystem.
It does not own core product runtime code. It owns system maps, architectural rules,
cross-repo delivery playbooks, operations knowledge, observability standards, and
historical records.

## Sibling Repositories

- `trading-platform` - core platform for market data ingestion, storage, execution,
  and MCP/API surfaces.
- `trading-platform-sdk` - standalone platform SDK repository; owns client-facing
  SDK packages, shared consumer types, integration helpers, and examples.
- `trading-lab` - agent workflows, research loops, hypothesis generation, and
  orchestration via MCP/SDK.
- `trading-office` - operator UI and office workflows.
- `trading-backtester` - backtesting-focused components, validation flows, and
  evidence-oriented scenarios.
- `trading-mock-platform` - mock/simulated platform surface for contract and
  integration testing.

## Repository Rules

- Keep this repo lightweight; do not move main product runtime code here.
- Link to source-of-truth docs in sibling repos instead of duplicating implementation details.
- Record durable architectural choices in `docs/architecture/decisions/`.
- Record cross-repo rollout steps in `docs/delivery/`.
- Record operational procedures in `docs/operations/`.
- Record incidents, migrations, postmortems, and cross-repo changelogs in `docs/history/`.
- Prefer small PRs for architecture, roadmap, runbook, and policy changes.

## First Files To Read

1. `docs/overview/ecosystem-map.md`
2. `docs/overview/repository-catalog.md`
3. `docs/architecture/principles.md`
4. `docs/delivery/cross-repo-change-playbook.md`
5. `docs/operations/observability-map.md`
6. `docs/operations/deployment-topology.md`
7. `docs/overview/gortex-workspace.md`

## Gortex Workspace

Use Gortex for cross-repo lookup across sibling repositories. Start with
`get_active_project` or `workspace_info`, then use `search_symbols`, `find_files`,
`smart_context`, `contracts`, or `get_editing_context` with explicit repo prefixes:

- `trading-platform`
- `trading-platform-sdk`
- `trading-lab`
- `trading-office`
- `trading-backtester`
- `trading-mock-platform`

If a sibling repo is missing from the graph, track or index it before drawing
architecture conclusions from incomplete search results.

## Cross-Repo Change Rule

When a platform capability, MCP surface, API contract, or behavior changes:

1. Update the source-of-truth platform repository.
2. Update `trading-platform-sdk` if the consumer contract changed.
3. Update dependent repos such as `trading-lab`, `trading-backtester`, and `trading-office`.
4. Run validation gates across platform, SDK, mock platform, and affected consumers.
5. Record rollout notes, migration notes, or changelog entries if behavior changed.

## Non-Goals

- Do not add core platform runtime code here.
- Do not add SDK package runtime code here.
- Do not add agent runtime code here.
- Do not add office UI runtime code here.
- Do not turn this repository into the only deployable monolith for the ecosystem.
