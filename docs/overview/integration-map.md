# Integration Map

## Primary Integration Rules

- MCP is the primary platform-to-agent integration boundary.
- SDK packages are the primary typed client boundary for consumers.
- Public contracts should be validated against `trading-mock-platform` and relevant
  consumer tests before rollout.
- Internal imports between sibling repositories are not an integration strategy.

## Key Flows

| Flow | Producer | Consumer | Contract |
| --- | --- | --- | --- |
| Platform capability | `trading-platform` | SDK and consumers | MCP/API surface |
| SDK release | `trading-platform-sdk` | Lab, office, backtester, external users | SDK package version |
| Agent run | `trading-lab` | Platform | MCP tools, SDK helpers |
| Operator action | `trading-office` | Platform | SDK/API calls |
| Backtest job | `trading-backtester` | Platform or mock platform | SDK/MCP-compatible execution |
| Contract test | `trading-mock-platform` | SDK and consumers | Public platform contract |

