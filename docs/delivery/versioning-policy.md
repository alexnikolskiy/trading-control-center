# Versioning Policy

## Platform

Platform capability versions should be recorded when they affect public behavior,
execution semantics, or telemetry expectations.

## SDK

SDK versions should communicate compatibility with platform contracts.

## Consumers

Consumers should pin or declare compatible SDK versions when contract behavior matters.

## Migration Notes

Breaking or behaviorally significant changes require entries in `docs/history/migrations/`
or `docs/history/changelogs/`.

