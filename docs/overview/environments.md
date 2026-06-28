# Environments

This matrix is a coordination view. Exact environment configuration belongs in the
owning source or infrastructure repository.

| Environment | Purpose | Expected characteristics |
| --- | --- | --- |
| `local` | Developer and agent iteration. | Local services, mocks, test data, no production secrets. |
| `test` | Automated validation. | Deterministic fixtures, mock platform, contract checks. |
| `staging` | Release rehearsal. | Production-like topology, safe credentials, full observability. |
| `production` | Live workloads. | Managed rollout, alerting, incident response, rollback path. |

## Environment Rules

- Keep secrets out of this repository.
- Document required access and ownership in `docs/operations/secrets-and-access.md`.
- Link to deployable infrastructure definitions rather than copying them here.
- Record environment-impacting changes in `docs/history/migrations/` or changelogs.

