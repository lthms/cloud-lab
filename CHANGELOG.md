# Changelog

## 2026-03-08

- `n8n` 0.1.4: Update n8n to v2.11.1, Recreate strategy for lock safety

## 2026-03-06

- `garage` 0.1.3: Fix createBucket permission grant (use allow/deny wrapper per source code)
- `garage` 0.1.2: Fix createBucket permission grant (correct request body format)
- `garage` 0.1.1: Grant createBucket permission to S3 key during bootstrap
- `garage` 0.1.0: Garage S3-compatible object storage with web serving

## 2026-03-01

- `n8n` 0.1.3: Trust reverse proxy headers
- `n8n` 0.1.2: Listen on all interfaces and set public webhook URL
- `conduwuit` 0.1.1: Recreate strategy for RocksDB lock safety
- `conduwuit` 0.1.0: Continuwuity Matrix homeserver (no federation)
- `n8n` 0.1.1: Enable dropOnDelete for operator-managed PostgreSQL database
- `soju` 0.1.2: Enable dropOnDelete for operator-managed PostgreSQL database
- `miniflux` 0.1.2: Enable dropOnDelete for operator-managed PostgreSQL database

## 2026-02-28

- `n8n` 0.1.0: n8n workflow automation with operator-managed PostgreSQL

## 2026-02-24

- `soap-coffee` 0.7.1: Add CPU/memory resource requests
- `miniflux` 0.1.1: Add CPU/memory resource requests
- `postgresql` 0.1.1: Add CPU/memory resource requests
- `soju` 0.1.1: Add CPU/memory resource requests

## 2026-02-22

- `soju` 0.1.0: soju IRC bouncer with operator-managed PostgreSQL

## 2026-02-20

- `soap-coffee` 0.7.0: cert-manager integration (auto TLS via Ingress annotation)
- `postgresql` 0.1.0: Shared PostgreSQL instance with ext-postgres-operator as subchart dependency
- `miniflux` 0.1.0: Miniflux RSS reader with operator-managed database credentials
