#!/usr/bin/env bash
set -euo pipefail

cat <<'CHECKLIST'
Cross-repo release checklist

[ ] Source-of-truth repository updated
[ ] SDK updated if consumer contract changed
[ ] Mock platform or fixtures updated if contract changed
[ ] Dependent consumers checked or updated
[ ] Platform tests run
[ ] SDK tests and contract tests run
[ ] Backtester validation run when execution semantics changed
[ ] Observability coverage confirmed
[ ] Rollback path confirmed
[ ] Rollout, migration, or changelog notes recorded
CHECKLIST

