# Vision and Context

## 1. Problem to solve
Stakeholders need a single, fast way to browse reliable, up‑to‑date information about schools (address, contact details, emails). Today this data is scattered or hard to query quickly, which slows down everyday workflows like outreach or reporting.

## 2. Goals and KPIs (SMART)
- **Rapid discovery:** Find a target school through search/filter/sort in **≤ 30 seconds** for 90% of cases by end of iteration 1.
- **Query experience:** P95 response time for list and search views **≤ 300 ms** on a dataset of up to **100k schools** (target; tune in System Requirements).
- **Data reliability:** Visible provenance for key fields (source and last change) present for **100%** of edited attributes by iteration 2.
- **Adoption:** At least **3 internal users** use the app weekly by end of iteration 1 (baseline for future KPIs).

## 3. Users and personas
- **Data browser (primary):** Needs to quickly search, filter, and sort school records to build shortlists.
- **Data steward (secondary, iteration 2):** Needs to correct or enrich records manually and see change history.
- **Integrator (external module):** Other services read the data and (from iteration 2) can write **selected contact fields** with full audit.

## 4. Scope
**In scope (iteration 1 / priority):**
- Web app to **present** school information with **sort, filter, and search**.
- Organization by governance regions: **Voivodeship**, **Municipality (gmina)**, **Locality/Town** to narrow results.

**Next iteration (iteration 2):**
- Manual editing of selected attributes.
- **Change history** for key attributes: source of change (manual/import/external module), timestamp, actor.
- **Limited external write**: allow trusted modules to update **contact info fields** (e.g., emails, phone) via API; enforce validation and audit.

**Future (not part of current scope):**
- Authentication (login/password) and role-based permissions.
- Mailing/communication workflows (handled by separate modules).

## 5. Constraints and assumptions
- Data is provided/seeded by an external process or import (the app is **read-first** in iteration 1).
- English UI labels for governance regions: **Voivodeship**, **Municipality**, **Locality/Town**.
- The system exposes data for other modules to consume (read-only in iteration 1; limited write in iteration 2).

## 6. Risks
- **Data freshness:** If upstream feeds are infrequent, users may expect edits; addressed by iteration 2 manual edits + history + limited external writes.
- **Ambiguous region names:** Need canonical IDs to avoid collisions; enforced in data model.
- **Scale uncertainty:** Dataset size may grow; plan efficient indexing and pagination.

## 7. Success criteria (narrative)
A user can open the app, filter by Voivodeship→Municipality→Locality, type part of a school name or email, sort by name, and export or copy results for downstream work. In iteration 2, the user can fix a wrong email and see a clear audit trail. External modules can correct a school’s contact email through a controlled API with validation and provenance.
