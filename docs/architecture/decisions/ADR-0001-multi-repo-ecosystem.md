# ADR-0001: Multi-Repo Ecosystem

## Status

Accepted

## Context

The trading system is split across repositories with different responsibilities,
release cycles, and access patterns.

## Decision

Use a polyrepo ecosystem coordinated by `trading-control-center`.

## Consequences

- Implementation ownership remains with source repositories.
- Cross-repo changes require explicit coordination and validation.
- This repository stores shared context, not product runtime code.

