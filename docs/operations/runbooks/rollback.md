# Runbook: Rollback

## Steps

1. Identify the deployed change and affected contracts.
2. Check whether SDK or consumers depend on the new behavior.
3. Confirm data migration impact.
4. Roll back in dependency-aware order.
5. Watch logs, traces, metrics, and alerts.
6. Record rollback notes in history.

