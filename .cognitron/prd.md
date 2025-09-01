# Product Requirements (PRD)
- **F8: Change history (audit) for key attributes**
  - For each changed field store: field name, old value, new value, timestamp, source (manual/import), and actor (if authenticated).
  - Display per‑record history in UI.
- **F9: Provenance badge in list/detail**
  - Indicate if a field was edited manually or comes from import (latest source).

### E3 — External consumption (Read API) (Iteration 1 minimal, extended later)
- **F10: Read‑only access for other modules**pics and features

### E1 — School data browsing (Iteration 1, Priority)
- **F1: List view of schools**
  - Columns include: Name, Address (street, postal code), City, Region, Voivodeship, Phone, Parent Council Email, Website, Facebook (optional).
  - Pagination or incremental loading.
- **F2: Sorting**
  - Sort by: Name, City, Region, Voivodeship, Email (presence), Phone (presence).
  - Stable sort; default sort by Name (A→Z).
- **F3: Filtering**
  - By Voivodeship → Region → City (hierarchical narrowing).
  - By presence of email/phone.
- **F4: Full‑text search**
  - Search by school name, part of address, email domain (case‑insensitive, diacritic‑insensitive if feasible).
- **F5: Detail view (read‑only)**
  - Open a single record to see all stored fields.
  - Show field provenance if available (source and last updated).
- **F6: Data export**
  - Export filtered/searched results to Excel (.xlsx) or CSV (.csv) format.
  - Include all visible fields with proper formatting and UTF-8 encoding.
  - Limit exports to 10,000 records maximum for performance.
  - Auto-generate timestamped filenames or allow custom naming.

### E2 — Manual editing with change history (Iteration 2)
- **F7: Edit selected fields by hand**
  - Editable fields: contact info (pc_email, phone), website, school_url, facebook_url, address corrections.
  - Validation rules for email, phone formats.
- **F8: Change history (audit) for key attributes**
  - For each changed field store: field name, old value, new value, timestamp, source (manual/import), and actor (if authenticated).
  - Display per‑record history in UI.
- **F8: Provenance badge in list/detail**
  - Indicate if a field was edited manually or comes from import (latest source).

### E3 — External consumption (Read API) (Iteration 1 minimal, extended later)
- **F10: Read‑only access for other modules**
  - Provide a stable way to read filtered/sorted/search results (exact interface defined in System Requirements/API spec).
  - Out of scope: sending emails/mailing campaigns.

### E4 — Authentication and authorization (Future)
- **F11: Login/password**
  - Protect editing features; readers may remain public or require login depending on policy (to be decided later).
  - Roles: Reader, Editor, Admin (draft).

## 2. Acceptance criteria (Gherkin examples)

### F1/F2/F3: Browse, sort, filter
```
Feature: Browse schools
  Scenario: Filter by region and sort by name
    Given the dataset contains schools across multiple voivodeships
    And I select Voivodeship "łódzkie"
    And I select Region "wieruszowski"
    And I select City "Bolesławiec"
    When I sort by "Name" ascending
    Then the list shows only schools within the selected region hierarchy
    And results are ordered alphabetically by Name (A to Z)
```

### F4: Search by name/email
```
Feature: Search schools
  Scenario: Case-insensitive search by name fragment
    Given there exists a school named "Primary School No. 5"
    When I search for "primary 5"
    Then I see "Primary School No. 5" in results

  Scenario: Search by email domain
    Given there exists a school with email "office@schoolA.edu"
    When I search for "schoola.edu"
    Then that school appears in results
```

### F5: Detail view
```
Feature: View school details
  Scenario: Open a record
    Given I am on the list view
    When I open a school's details
    Then I can see Name, Address, Locality, Municipality, Voivodeship, Phone, Email(s)
```

### F6: Data export
```
Feature: Export school data
  Scenario: Export filtered schools to Excel
    Given I have applied filters for "łódzkie" voivodeship
    And the filtered results contain 150 schools
    When I click "Export to Excel"
    Then I receive an Excel file download
    And the filename contains the current date and time
    And the file contains 150 school records with all fields
    And the file uses UTF-8 encoding

  Scenario: Export limit exceeded
    Given my current filters match 15,000 schools
    When I attempt to export to CSV
    Then I see an error message "Export limited to 10,000 records"
    And I am suggested to refine my filters

  Scenario: Export with custom filename
    Given I have filtered schools by "Warszawa" city
    When I export to CSV with filename "warszawa_schools"
    Then I receive a file named "warszawa_schools_2025-08-25_14-30-15.csv"
```

### F7/F8: Edit with change history (iteration 2)
```
Feature: Edit contact info with audit
  Scenario: Update email and record provenance
    Given I open the details of a school
    And I have edit permission
    When I change the email from "old@school.edu" to "info@school.edu"
    Then the change is saved
    And the change history shows field "email" changed from "old@school.edu" to "info@school.edu"
    And it records source "manual", a timestamp, and my user id
```

## 3. Minimum Lovable Product (Iteration 1)
- List view with paging, hierarchical regional filters (Voivodeship → Region → City).
- Sort by Name; search across Name/address/email.
- Detail view (read-only).
- Export functionality (Excel/CSV) with filtered results.
- (Optional) Indication of data freshness if source timestamps exist.

## 4. Edge cases and validation
- Empty search returns filtered set without error.
- Very long names/addresses truncate gracefully with tooltip.
- Missing contact fields show as "—" (not "null").
- Unicode/diacritics handled safely in UI and search (best effort).

## 5. Dependencies and data
- Input dataset provided externally; format and import pipeline defined outside this project (assumption).
- Read access for other modules required; concrete API shape to be defined in `api.yaml` (read-only endpoints).

## 6. Out of scope (now)
- Bulk mailing creation and sending.
- Complex role management, SSO; covered in a future iteration.
