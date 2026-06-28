# Architecture Principles

These principles are durable constraints for the trading ecosystem. They are
intended to survive individual feature designs and keep cross-repo changes
predictable.

## 1. Platform Is Agent-Agnostic

`trading-platform` exposes platform capabilities through MCP and SDK-facing
contracts. It does not know about individual agent implementations, research
loops, prompt shapes, or lab orchestration details.

### Rationale

The platform must remain useful to agents, operator tools, backtests, and future
consumers without being coupled to one orchestration strategy. Keeping agent logic
outside the platform makes execution semantics easier to test, reason about, and
roll back.

### In Practice

- Agents communicate with the platform via MCP only.
- Platform capabilities are modeled as stable server behavior and public contract
  surfaces.
- Agent-specific prompts, planners, critics, and workflow state live in
  `trading-lab`, not in `trading-platform`.
- Platform PRs should not introduce dependencies on lab, office, or backtester
  runtime code.

## 2. SDK Is The Canonical Consumer Contract

The canonical consumer contract lives in `trading-platform-sdk`. Any platform
capability exposed to consumers must be represented in SDK types, helpers,
examples, and version metadata before downstream repositories treat it as stable.
SDK versioning follows semver; breaking changes require a migration path.

### Rationale

The SDK is the shared integration language for public and internal consumers. It
prevents each repo from inventing its own client, type model, compatibility
rules, and examples.

### In Practice

- New public platform capabilities flow through SDK types and helpers.
- Consumers use SDK packages instead of private platform imports.
- Breaking SDK changes require a major version, migration notes, and a consumer
  update plan.
- SDK releases should include examples for lab, office, or backtester usage when
  the capability is consumer-facing.

## 3. Boundaries Are Strictly Enforced

Agent-side and consumer repositories must not import `trading-platform` internals.
Cross-repo changes follow the cross-repo change playbook. `trading-mock-platform`
must conform to SDK and public platform contracts.

### Rationale

Direct imports across repo boundaries create hidden coupling, unreviewed contract
changes, and brittle releases. Strict boundaries make dependency direction clear
and keep validation focused on public behavior.

### In Practice

- `trading-lab`, `trading-office`, and `trading-backtester` integrate through
  MCP, SDK, or documented public APIs.
- Mock platform behavior is updated when public contracts change.
- Cross-repo PRs link to the same spec, RFC, ADR, or rollout note.
- Reviewers reject changes that rely on private implementation details from a
  sibling repository.

## 4. Development Is Spec-Driven

Features start with a spec in `docs/superpowers/specs/` in the relevant source
repository. Implementation follows the spec. If the design changes during
implementation, the spec is updated and the PR references the current spec.

### Rationale

Specs make agent-assisted work reproducible. They preserve intent, scope,
non-goals, validation gates, and rollout assumptions beyond a single chat or
branch.

### In Practice

- Platform features start with a platform spec.
- SDK contract changes start with an SDK spec or linked platform spec.
- Backtester bundle changes start with a backtester spec.
- PR descriptions reference the spec and call out any implementation-time
  deviations.
- Specs live in the owning source repo; this control center links to them and
  records cross-repo coordination decisions.

## 5. Validation Gates Protect Contracts

SDK changes must pass the consumer validation set: `clean-consumer`,
`sdk:verify`, backtester SDK tests, and `pnpm check`. Platform changes that
affect the MCP surface must be reflected in `trading-mock-platform`.

### Rationale

Most ecosystem regressions happen at repo boundaries: stale SDK types, mock
platform drift, unvalidated consumers, or changed MCP behavior. Validation gates
make those failures visible before release.

### In Practice

- SDK PRs run `clean-consumer`, `sdk:verify`, backtester SDK tests, and
  `pnpm check`.
- Platform MCP changes update mock platform fixtures or behavior in the same
  rollout.
- Consumer PRs in lab, office, or backtester verify compatibility with the target
  SDK version.
- Backtester evidence is required when execution semantics or strategy bundle
  behavior changes.

## 6. Observability Is First-Class

All runtime services emit structured logs. All agentic and MCP pipeline calls
produce traces. Phoenix is the observability stack for traces, spans, and
LLM/agent observability.

### Rationale

Agentic trading workflows cross many boundaries: operator action, lab session,
MCP tool call, platform execution, backtest evidence, and SDK version. Without
consistent telemetry, incidents and validation failures cannot be reconstructed.

### In Practice

- Runtime services emit structured JSON logs with correlation identifiers.
- MCP calls carry trace, agent session, and tool-call identifiers.
- Lab traces include LLM calls, tool calls, agent loop decisions, and research
  session events.
- Backtester traces include job IDs, bundle hashes, validation spans, and
  evidence records.
- Alerts route to the owning repo team first, with cross-repo escalation when the
  symptom crosses a contract boundary.
