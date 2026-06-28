# ADR-0003: SDK Is A Separate Repository

## Status

Accepted

## Context

The SDK is a public and internal integration layer with its own release cadence.

## Decision

Keep `trading-platform-sdk` as a standalone sibling repository.

## Consequences

- SDK contracts, types, helpers, and examples have a single owner.
- Platform changes that affect consumers must update SDK artifacts.

