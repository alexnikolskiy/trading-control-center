# Cross-Repo Change Playbook

Use this playbook when a change affects platform behavior, MCP/API surfaces, SDK
contracts, strategy bundle contracts, telemetry contracts, or dependent consumer
behavior. Each scenario lists the ordered work, owning repository, and validation
gate.

## Common Rules

- Start from the source-of-truth repository.
- Keep implementation in the owning source repo; use this control center for
  coordination notes and durable rollout records.
- Link related PRs across repositories.
- Do not merge consumer PRs that rely on unpublished or unvalidated contracts.
- Record migration notes or changelog entries for behavior changes.

## Scenario A: Add A New Platform Capability Exposed Via MCP

| Step | Owner repo | Action | Validation gate |
| --- | --- | --- | --- |
| 1 | `trading-platform` | Write or update the feature spec in `docs/superpowers/specs/`. Define capability behavior, MCP inputs/outputs, errors, telemetry, and rollout assumptions. | Spec reviewed; non-goals and compatibility expectations are explicit. |
| 2 | `trading-platform` | Implement platform behavior behind the new capability. Keep the platform agent-agnostic. | Platform unit/integration tests pass. |
| 3 | `trading-platform` | Expose the MCP tool or extend the existing MCP surface. Include correlation ID handling and structured errors. | MCP contract tests or surface verification pass. |
| 4 | `trading-platform-sdk` | Add or update SDK types, helpers, examples, and version metadata for the new capability. | `clean-consumer`, `sdk:verify`, SDK tests, and `pnpm check` pass. |
| 5 | `trading-mock-platform` | Add mock behavior, fixtures, or conformance cases for the MCP/SDK contract. | Mock-platform contract and integration tests pass. |
| 6 | `trading-lab` | Update agent workflows only if the capability is used by research loops or agents. | Lab workflow tests pass; MCP client spans are visible in Phoenix when applicable. |
| 7 | `trading-backtester` | Update validation or backtest flows only if the capability affects evidence, strategy execution, or bundle behavior. | Backtester SDK tests and affected evidence runs pass. |
| 8 | `trading-office` | Update operator workflows only if humans need to invoke or inspect the new capability. | Office checks pass; operator action logs include correlation IDs. |
| 9 | Owning release repo | Prepare rollout note and changelog entry. Link all related PRs. | Release checklist complete; rollback path identified. |

## Scenario B: SDK Breaking Change, New Major Version

| Step | Owner repo | Action | Validation gate |
| --- | --- | --- | --- |
| 1 | `trading-platform-sdk` | Write an RFC or ADR describing the breaking change, motivation, migration path, and affected consumers. | RFC/ADR reviewed by platform, lab, backtester, and office owners. |
| 2 | `trading-platform-sdk` | Publish a deprecation notice for the old API when possible. Identify removal timeline and compatibility window. | Deprecation notice appears in SDK docs/changelog. |
| 3 | `trading-platform-sdk` | Create the major-version branch or release branch. Implement new types, helpers, examples, and version metadata. | SDK test suite passes on the branch. |
| 4 | `trading-lab` | Update agent workflows to the new SDK version. Remove deprecated calls. | Lab checks pass; representative agent workflow still reaches platform through MCP. |
| 5 | `trading-backtester` | Update backtester SDK usage and bundle-related types. | Backtester SDK tests, bundle validation tests, and evidence checks pass. |
| 6 | `trading-office` | Update operator UI/server SDK usage. | Office `pnpm check` or equivalent repo check passes. |
| 7 | `trading-mock-platform` | Update mock contracts and fixtures to match the new SDK major version. | Contract conformance tests pass. |
| 8 | `trading-platform-sdk` | Run final validation: `clean-consumer`, `sdk:verify`, backtester SDK tests, and `pnpm check`. | All required SDK gates pass on the release branch. |
| 9 | `trading-platform-sdk` | Release the major version and publish migration notes. | Package published; changelog and migration notes reference consumer PRs. |

## Scenario C: Strategy Bundle Contract Change

`trading-backtester` is the canonical authority for strategy bundle hashes. Bundle
contract changes start there and propagate outward.

| Step | Owner repo | Action | Validation gate |
| --- | --- | --- | --- |
| 1 | `trading-backtester` | Write the bundle contract spec in `docs/superpowers/specs/`. Define bundle shape, hash inputs, compatibility, evidence requirements, and migration behavior. | Spec reviewed by backtester, SDK, and lab owners. |
| 2 | `trading-backtester` | Update canonical bundle hash calculation and validation logic. | Bundle hash tests and validation tests pass. |
| 3 | `trading-platform-sdk` | Align SDK bundle types, helpers, and examples with the canonical backtester contract. | SDK tests, `sdk:verify`, and `pnpm check` pass. |
| 4 | `trading-lab` | Align strategy generation, hypothesis workflows, or agent outputs with the new bundle contract. | Lab tests pass; generated bundles validate against backtester rules. |
| 5 | `trading-platform-sdk` | Confirm platform-SDK compatibility metadata and examples reference the new bundle contract correctly. | Clean consumer check and example compilation pass. |
| 6 | `trading-backtester` | Run evidence validation using representative old and new bundles. | Evidence run records include bundle hash, strategy ID, SDK version, and validation result. |
| 7 | `trading-backtester` | Publish changelog and migration notes. Link SDK and lab PRs. | Changelog includes hash compatibility and migration impact. |

## Scenario D: Add A New Repository To The Ecosystem

| Step | Owner repo | Action | Validation gate |
| --- | --- | --- | --- |
| 1 | New repository | Create the repository with a clear responsibility boundary and initial README. | Repo exists outside `trading-control-center`; ownership is documented. |
| 2 | New repository | Add `AGENTS.md` with repo purpose, boundaries, first files to read, validation commands, and integration rules. | Agent brief reviewed by the repo owner. |
| 3 | `trading-control-center` | Add the repository to `docs/overview/repository-catalog.md`. | Catalog entry names visibility, source-of-truth responsibilities, consumers, and integration points. |
| 4 | `trading-control-center` | Add the repository to `docs/overview/ecosystem-map.md`. | Mermaid diagram and repository table include the new repo. |
| 5 | `trading-control-center` | Add `repos/<name>.md` describing role, ownership, non-ownership, and integration boundaries. | Repo entry links to source-of-truth docs where available. |
| 6 | `trading-control-center` | Update root `AGENTS.md` sibling list. | Agent context includes the new repo and does not duplicate implementation specs. |
| 7 | New repository | Set up branch protection, required checks, and PR template. | Protected default branch; required validation gates enabled. |
| 8 | New repository and control center | Add Gortex tracking or workspace metadata if the repo should be searchable from the control center. | `get_active_project` or equivalent workspace check shows the repo as tracked. |

## Final Cross-Repo Validation Checklist

- Source-of-truth repo updated first.
- SDK updated when consumer contract changed.
- Mock platform updated when MCP/API/SDK behavior changed.
- Lab, office, and backtester checked or explicitly marked unaffected.
- Required validation gates passed in each affected repo.
- Phoenix traces, structured logs, and correlation IDs reviewed for new flows.
- Rollback path and migration notes recorded.
- Changelog links all related PRs.
