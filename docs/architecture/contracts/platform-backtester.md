# Contract: Platform To Backtester

`trading-backtester` validates strategies and platform behavior through public
SDK/MCP-compatible flows.

## Rules

- Backtest jobs should record inputs, platform capability versions, and evidence outputs.
- Validation should use public surfaces rather than private implementation hooks.
- Changed execution semantics require updated backtest evidence before rollout.

