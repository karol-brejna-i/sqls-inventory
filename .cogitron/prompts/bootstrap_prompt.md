You are my assistant for setting up an AI-ready project specification.  
I want to build a **web app** for browsing and managing school information.  

## Context
- The app must present information about schools: address, contact info, emails, phone, website.
- Users can **sort, filter, and search** through the data (Iteration 1 priority).
- Schools are organized by governance regions: Voivodeship → Municipality → Locality/Town (English names).
- Iteration 2: users can **manually edit selected contact fields**, with full **change history** (audit trail).
- Iteration 2: **external modules** (e.g. scrapers) may also update certain fields (e.g. secretariat_email, parents_council_email).  
  Each attribute must have its own **provenance** (source: import/manual/external) and flexible **metadata** (JSON: url, phrase, scraped_at, confidence, etc.).
- Provenance and metadata must be stored **per field** independently.
- Audit trail must record field, old_value, new_value, timestamp, source, actor/client_id, meta, idempotency_key.
- Future: authentication (login/password, roles Reader/Editor/Admin), API keys or OAuth for external modules.

## Deliverables
Create a complete **AI-ready project skeleton** with the following files (in `.cogitron/` directory):
- `vision.md` — project vision, goals, personas, scope (iteration 1/2/future).
- `prd.md` — product requirements with epics, features, acceptance criteria (Gherkin examples).
- `system-requirements.md` — system and non-functional requirements, tech stack, API standards, validation, security, ops.
- `api.yaml` — OpenAPI 3.0 spec including:
  - `GET /schools` (list with filters/sorting/paging)
  - `GET /schools/{id}` (detail with ETag)
  - `PATCH /schools/{id}/contact` (future write, per-field `{ value, meta }` updates, provenance, idempotency, optimistic concurrency).
- `data-model.yaml` — entities (School, SchoolContact, ChangeRecord), fields, indexes, validation, and examples aligned with **Option B** (normalized contact fields + per-field provenance).
- `glossary.md` — canonical terms (DAU, MLP, provenance, etc.).
- `user-stories.md` — user stories and use cases (browsing, editing, external write).
- `docs/architecture.md` — architecture context, containers, components, integrations, security, evolution.
- `docs/adr/0001-record-architecture-decisions.md` — ADR template.
- `tests/acceptance.feature` — Gherkin tests for core flows (browse, search, detail, edit, external write).
- `prompts/dev_prompt.md` — instructions for models on how to generate code from the spec.

## AI principles (must apply to all files)
- Clarity: no vague terms; measurable targets.
- Consistency: terminology matches glossary.
- Completeness: every API has examples; edge cases included.
- Testability: acceptance criteria written in Gherkin.
- Explicit limits: no “reasonable”; use numbers.
- NFRs: clear thresholds (latency, availability).
- Security: role/auth definitions, audit retention.
- Traceability: ADRs for major decisions.

Generate all these files with initial, filled-in content as if we’re starting fresh with this project.