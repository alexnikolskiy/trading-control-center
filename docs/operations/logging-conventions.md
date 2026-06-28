# Logging Conventions

## Requirements

- Prefer structured logs.
- Include correlation identifiers at repo boundaries.
- Do not log secrets, credentials, raw private keys, or sensitive account data.
- Log contract versions when behavior depends on platform or SDK compatibility.

## Suggested Fields

- `timestamp`
- `level`
- `service`
- `environment`
- `request_id`
- `trace_id`
- `agent_run_id`
- `tool_call_id`
- `backtest_job_id`
- `sdk_version`
- `platform_capability_version`
- `event`
- `outcome`

