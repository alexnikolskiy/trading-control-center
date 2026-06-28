# Ecosystem Map

`trading-control-center` coordinates a polyrepo trading ecosystem. The source
repositories keep implementation ownership; this repository keeps the shared map,
rules, and operational memory.

## Repository Graph

```text
trading-platform
  ├─ exposes MCP/API surfaces
  ├─ defines execution semantics
  ├─ integrates market data, storage, and execution
  └─ is exercised by trading-mock-platform and trading-backtester

trading-platform-sdk
  ├─ derives from public platform contracts
  ├─ exposes typed client integration
  └─ is consumed by trading-lab, trading-backtester, trading-office, and external users

trading-lab
  └─ builds agentic research and orchestration workflows on MCP/SDK

trading-office
  └─ builds operator workflows on SDK/API surfaces

trading-backtester
  └─ validates strategies and platform behavior through SDK/MCP-compatible flows

trading-mock-platform
  └─ provides mock and simulated platform behavior for contracts and integration tests
```

## Sources Of Truth

| Area | Source of truth |
| --- | --- |
| Platform behavior | `trading-platform` |
| Execution semantics | `trading-platform` |
| Server MCP/API surfaces | `trading-platform` |
| Client SDK contract | `trading-platform-sdk` |
| Consumer-facing examples | `trading-platform-sdk` |
| Agent workflows | `trading-lab` |
| Operator UI workflows | `trading-office` |
| Backtesting evidence | `trading-backtester` |
| Contract test doubles | `trading-mock-platform` |
| Cross-repo coordination rules | `trading-control-center` |

## Integration Direction

- Agentic systems integrate through MCP and SDK, not by importing internal platform code.
- Consumer repositories depend on `trading-platform-sdk` for typed client surfaces.
- Mock and backtest systems validate public contracts instead of private implementation details.
- Control-center documents index and coordinate source repos; they do not replace source repos.

