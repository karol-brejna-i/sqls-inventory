# .cogitron — Specification and Context Directory

This directory contains the **core specification and context files* used to guide
development with the help of AI models. Each file plays a specific role in making
requirements explicit, unambiguous, and testable.

## Files and Purpose

- `vision.md` — Project vision and context: problem definition, goals, personas,
  scope, assumptions.
- `prd.md` — Product Requirements Document: epics, features, acceptance criteria,
  edge cases, dependencies, Minimum Lovable Product (MLP).
- `system-requirements.md` — System requirements and non-functional requirements
  (performance, security, scalability, compliance, operations).
- `api.yaml` — API specification in OpenAPI 3.0 format, defining endpoints,
  request/response schemas, and examples.
- `data-model.yaml` — Data model in YAML, with entities, fields, constraints,
  and sample instances.
- `glossary.md` — Glossary of terms to remove ambiguity and standardize naming.
- `user-stories.md` — User stories and use cases, including alternate scenarios.

## How to work with this (short version)
1. Start by filling in `vision.md` (context, goals, personas).
2. Define main product features and acceptance criteria in `prd.md`.
3. Capture system constraints and NFR in `system-requirements.md`.
4. Specify interfaces in `api.yaml` and domain entities in `data-model.yaml`.
5. Keep terminology consistent in `glossary.md`.
6. Add user stories and use cases in `user-stories.md`.
7. Whenever something changes, update the relevant file — AI models rely on
   these documents to generate consistent code and tests.

## AI Principles (Zasady AI)
To ensure that AI can generate useful and consistent output, follow these rules:

- Clarity: avoid vague terms; use measurable metrics and examples.
- Consistency: keep terminology aligned with `glossary.md`.
- Completeness: provide full request/response examples and edge cases.
- Testability: write acceptance criteria as Gherkin scenarios.
- Explicit limits: define boundaries (lengths, enums, timeouts) instead of saying "reasonable".
- Non-functional requirements: always specify numeric thresholds (e.g., P95 < 200 ms).
- Security and compliance: describe roles, permissions, and sensitive data handling explicitly.
- Traceability: update relevant documents whenever requirements or decisions change.
