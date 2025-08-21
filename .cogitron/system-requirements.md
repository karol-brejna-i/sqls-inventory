# System Requirements

## 0. Iterations and scope alignment
- **Iteration 1 (read-first):**
  - Web app for browsing school data with search, filters (Voivodeship → Municipality → Locality/Town), sorting, and paging.
  - Public read API (`GET /schools`, `GET /schools/{id}`) as defined in `api.yaml`.
  - No authentication required for reads (may be toggled later).
- **Iteration 2 (editing + audit + limited external writes):**
  - Manual edits for selected fields (contact info, website, address corrections).
  - Change history (audit) with field, old/new values, timestamp, source (manual/import/external), actor/client id.
  - Limited external write API: `PATCH /schools/{id}/contact` (contact fields only), idempotency, validation, provenance.
- **Future (security & ops hardening):**
  - Authentication (login/password, minimal roles: Reader/Editor/Admin), API keys or OAuth client credentials.
  - Rate limiting, quotas, and improved observability/alerting.
  - Availability SLO and disaster recovery posture.

## 1. Technology decisions (proposed; adjust as needed)
- **Backend:** Python 3.12 + FastAPI (async), Uvicorn.
- **DB:** PostgreSQL 16.
- **Search:** Postgres GIN indexes with trigram or full‑text for name/address/email (pg_trgm + tsvector).
- **Frontend:** React + TypeScript + Vite (or Next.js if SSR desired).
- **API schema:** OpenAPI 3.0 (`.cogitron/api.yaml`) as source of truth; generate server/client stubs.
- **Containerization:** Docker, multi‑stage build; image < 200MB.
- **Infra:** Any container runtime; one Postgres instance; optionally Redis for caching (later).
- **Time & locale:** All timestamps in UTC (ISO 8601). UI localized to English initially.

## 2. Data model (high‑level)
- **Entity:** `School`
  - `id` (UUID v7 or ULID; stable, sortable), `name`, `region` (voivodeship, municipality, locality), `address` (street, postal_code), `contact` (emails[], phone, website), `provenance`, `created_at`, `updated_at`.
- **Provenance:** last update source (`import|manual|external`), `updated_at`, optional `actor_id`, `client_id`.
- **History (iteration 2):** `change_records` table with immutable append‑only rows: `school_id`, `field`, `old_value`, `new_value`, `source`, `actor_id`, `client_id`, `timestamp`, `idempotency_key`.

## 3. Non‑functional requirements (targets)
- **Performance (Iteration 1):**
  - P95 latency for `GET /schools` with common filters/search: **≤ 300 ms** at 100k rows; **≤ 600 ms** at 500k rows.
  - First meaningful render in UI list view **≤ 1.5 s** on 3G‑fast profile for 50 results.
- **Throughput & scale:**
  - Baseline 50 RPS sustained on reads; burst to 200 RPS, with graceful degradation (e.g., circuit breaker for heavy queries).
- **Availability:**
  - Target **99.9%** monthly for read endpoints in Iteration 1 (best‑effort). Formal SLOs to be adopted in Future.
- **Consistency:**
  - Strong consistency for single‑record reads/updates. External writes use optimistic concurrency (ETag/If‑Match) where applicable.
- **Security (Future):**
  - OWASP ASVS Level 2 for the app. Password storage with Argon2id; TLS everywhere.
- **Privacy & compliance:**
  - No sensitive personal data expected. Emails/phones relate to institutions.
- **Accessibility:**
  - WCAG 2.1 AA for UI (keyboard nav, focus order, contrast, ARIA for tables/filters).
- **Internationalization:**
  - Region names stored canonically; UI uses English labels; support diacritics in search (folding where feasible).
- **Observability:**
  - Structured logs (JSON), request IDs, OpenTelemetry traces, RED metrics (rate, errors, duration).

## 4. API standards
- **Pagination:** `page` (1‑based), `page_size` (default 50, max 200). Response returns `total_items`, `total_pages`.
- **Sorting:** `sort` + `order=asc|desc`; stable sort; default `name` asc.
- **Filtering:** `voivodeship`, `municipality`, `locality`, `has_email`, `has_phone`, and `q` (full‑text).
- **Idempotency (Iteration 2):** `Idempotency-Key` header required for write endpoints. Store key → status/result for 24h.
- **Concurrency:** Support `ETag` on `GET /schools/{id}` and `If‑Match` on `PATCH /schools/{id}/contact` (409 on mismatch).
- **Errors:** Problem‑style JSON (code, message, optional details[field, issue]); 4xx for client errors, 5xx for server.
- **Rate limits (Future):** Default 60 write ops/min per client; reads may have soft caps.

## 5. Storage and indexing
- **Tables:** `schools`, `change_records` (iteration 2).
- **Primary key:** `schools.id` (UUID/ULID). Unique index on (name, locality, municipality, voivodeship) optional for dedupe tools.
- **Indexes for reads:**
  - B‑tree on `region.voivodeship`, `region.municipality`, `region.locality` (or separated columns).
  - GIN on `contact.emails` (array) for `has_email` and domain queries.
  - GIN `tsvector` over (name, address fields) for `q` search; `pg_trgm` on `name` for LIKE/ILIKE.
- **History indices:** b‑tree on (`school_id`, `timestamp`), b‑tree on `idempotency_key` (unique where not null).

## 6. Validation
- **Emails:** RFC 5322‑compatible validator; lower‑cased for comparison; optional domain allow‑list.
- **Phone:** E.164 format preferred; normalize spaces/dashes.
- **Website:** Valid URI; http/https only.
- **Region values:** Constrained to known canonical sets for voivodeships; municipality/locality free‑text with canonical IDs when available.

## 7. Security model (Future)
- **AuthN:** Username/password (session or token). External API clients: API keys initially; OAuth2 Client Credentials later.
- **AuthZ:** Roles: Reader (read), Editor (manual edits), Admin (schema/config). External clients limited to contact‑write scope.
- **Secrets:** Managed via environment variables or secret store; never in code or images.
- **Audit:** All edits append to `change_records`; immutable; retention **≥ 365 days** (configurable).

## 8. Operations
- **Deploy:** CI builds Docker image, runs unit tests + lint + OpenAPI validation; CD to staging then prod.
- **Migrations:** Alembic (or Prisma/Knex if not Python). Backwards‑compatible, with feature flags when needed.
- **Backups:** Daily Postgres backups; RPO ≤ 24h, RTO ≤ 4h (initial targets).
- **Monitoring & alerts:** Error rate, p95 latency, DB slow query count, 5xx rate. On‑call alerting thresholds TBD.
- **Logging:** PII‑safe logs; redact emails by default in logs if necessary.

## 9. Frontend requirements
- **Table UX:** Virtualized rows for large lists; sticky header; column sort indicators.
- **Filters:** Dependent dropdowns (Voivodeship → Municipality → Locality/Town).
- **Search:** Debounced text input; highlights matches (optional).
- **Empty states & errors:** Clear messages; retry affordances.
- **Performance:** Bundle < 250KB gz (iteration 1 target).

## 10. Open questions / decisions to confirm
- Canonical identifiers for municipalities/localities (official registry source?).
- Public vs authenticated READs in iteration 1.
- Export features (CSV/JSON) — in scope for iteration 1 or deferred?
- Exact choice between trigram vs full‑text for search; can be hybrid.
