# Contract: Platform To Lab

`trading-lab` integrates with `trading-platform` through MCP and SDK surfaces.

## Rules

- Lab workflows should not import private platform code.
- Tool calls, traces, and agent run identifiers should be observable across repo boundaries.
- Agent experiments that depend on new platform behavior should reference the platform
  capability version or rollout note.

