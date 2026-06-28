# Gortex Workspace

Gortex is the preferred code-intelligence layer for this control center. Use it to
inspect sibling repositories, find symbols, identify contracts, and scope changes
before reading large file trees manually.

## Expected Tracked Repositories

| Prefix | Repository |
| --- | --- |
| `trading-platform` | `/home/alexxxnikolskiy/projects/trading-platform` |
| `trading-platform-sdk` | `/home/alexxxnikolskiy/projects/trading-platform-sdk` |
| `trading-lab` | `/home/alexxxnikolskiy/projects/trading-lab` |
| `trading-office` | `/home/alexxxnikolskiy/projects/trading-office` |
| `trading-backtester` | `/home/alexxxnikolskiy/projects/trading-backtester` |
| `trading-mock-platform` | `/home/alexxxnikolskiy/projects/trading-mock-platform` |
| `trading-control-center` | `/home/alexxxnikolskiy/projects/trading-control-center` |

## Agent Workflow

1. Call `graph_stats` at the start of work.
2. Call `get_active_project` or `workspace_info` to confirm tracked repositories.
3. Use `search_symbols` or `find_files` with explicit repo prefixes for sibling lookup.
4. Use `smart_context` for focused implementation or documentation changes.
5. Use `contracts` for API, topic, environment, or OpenAPI contract discovery.
6. Before editing a file, call `get_editing_context`.
7. After edits, call `check_guards` and `get_test_targets`.

## Useful Cross-Repo Queries

| Goal | Example query |
| --- | --- |
| Platform capability | Search `trading-platform` for MCP/API/execution symbols. |
| SDK compatibility | Search `trading-platform-sdk` for contract version, client methods, and examples. |
| Agent impact | Search `trading-lab` for agent workflow, tool calls, orchestration, and MCP usage. |
| Operator impact | Search `trading-office` for API connectors and operator workflows. |
| Validation impact | Search `trading-backtester` for runner, jobs, evidence, and strategy validation. |
| Mock impact | Search `trading-mock-platform` for contract fixtures, MCP projections, and simulation behavior. |

## Notes

- Prefer explicit repo prefixes so temporary worktrees do not pollute the result set.
- If a repo is missing, track or index it before making architecture conclusions.
- Gortex narrows the search space; source files still confirm exact behavior.
