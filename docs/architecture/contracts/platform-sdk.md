# Contract: Platform To SDK

## Purpose

The platform-to-SDK contract defines the public integration surface that consumers
use through `trading-platform-sdk`.

## Owners

- Server behavior: `trading-platform`
- Client contract: `trading-platform-sdk`
- Cross-repo rollout rules: `trading-control-center`

## Change Rules

- Platform MCP/API changes must be reflected in SDK types and methods when they affect consumers.
- SDK examples should be updated with contract changes.
- Version metadata must make compatibility expectations explicit.
- Contract tests should run against real or mock platform surfaces before release.

