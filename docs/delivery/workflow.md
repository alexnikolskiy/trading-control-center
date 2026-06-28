# Delivery Workflow

## Default Flow

1. Identify the source-of-truth repository.
2. Update the owning implementation or contract.
3. Update SDK artifacts when the consumer contract changes.
4. Update dependent consumers.
5. Run validation gates.
6. Record rollout, migration, or changelog notes.

## Validation Gates

- Platform tests for server behavior.
- SDK tests for typed client behavior.
- Mock platform contract tests.
- Consumer integration tests for affected repos.
- Backtester evidence when execution semantics change.

