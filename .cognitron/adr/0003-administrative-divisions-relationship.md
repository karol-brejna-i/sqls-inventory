# 0003 — Administrative Divisions Relationship Strategy

## Status
- Accepted
- Date: 2025-08-25

## Context
The school directory system needs to handle Polish administrative hierarchy (voivodeship → region → city) for filtering and data consistency. We have two main approaches:

1. **Normalized approach**: Create foreign key relationships between SCHOOLS and ADMINISTRATIVE_DIVISIONS tables
2. **Denormalized approach**: Store administrative information as text fields directly in SCHOOLS table

**Current situation:**
- Excel input data contains administrative regions as text strings
- Simple import process is priority for Iteration 1
- Need to support hierarchical filtering by voivodeship → region → city
- Future iterations may require stronger data consistency and validation

**Requirements influencing this decision:**
- Fast implementation for read-only browsing (Iteration 1)
- Excel-based data import workflow
- Performance requirements (sub-300ms for 100k+ records)
- Future extensibility for data quality improvements

## Decision
**For Iteration 1**: Use denormalized approach with no foreign key relationships
- Store voivodeship, region, city as text fields in SCHOOLS table
- Create ADMINISTRATIVE_DIVISIONS as reference table only (no foreign keys)
- Use ADMINISTRATIVE_DIVISIONS for UI dropdown population and validation

**For Future Iterations**: Plan migration to normalized relationships
- Add foreign key constraints between SCHOOLS and ADMINISTRATIVE_DIVISIONS
- Implement data migration process to link existing text data to canonical divisions
- Add referential integrity enforcement

## Consequences

### ✅ Benefits (Iteration 1)
- **Simple data import**: Direct mapping from Excel columns to database fields
- **Fast queries**: No JOINs required for basic filtering operations
- **Quick implementation**: Matches existing Excel data structure
- **Performance**: Reduced query complexity for read operations

### ⚠️ Trade-offs (Iteration 1)
- **Data inconsistency risk**: No enforcement of canonical region names
- **Duplicate data**: Administrative names stored multiple times
- **Manual validation**: Need application-level validation for region hierarchy
- **Future migration complexity**: Will require data transformation later

### 🔍 Follow-ups (Future Iterations)
- **Monitor data quality**: Track inconsistent administrative division names
- **Plan normalization**: Design migration strategy for foreign key relationships
- **Validation enhancement**: Implement stronger validation against ADMINISTRATIVE_DIVISIONS
- **Performance impact**: Measure query performance changes with normalized structure

## Implementation Notes

### Iteration 1 Schema
```sql
-- Denormalized approach
CREATE TABLE schools (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    voivodeship VARCHAR(50) NOT NULL,  -- Text field, no FK
    region VARCHAR(100) NOT NULL,      -- Text field, no FK
    city VARCHAR(100) NOT NULL,        -- Text field, no FK
    -- ... other fields
);

-- Reference table (no relationships)
CREATE TABLE administrative_divisions (
    id UUID PRIMARY KEY,
    teryt_code VARCHAR(10) UNIQUE,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL,  -- voivodeship, powiat, gmina
    parent_teryt_code VARCHAR(10)
);
```

### Future Iterations Schema
```sql
-- Normalized approach (future)
ALTER TABLE schools 
  ADD COLUMN voivodeship_id UUID REFERENCES administrative_divisions(id),
  ADD COLUMN region_id UUID REFERENCES administrative_divisions(id),
  ADD COLUMN city_id UUID REFERENCES administrative_divisions(id);

-- Migrate data and drop text columns
-- DROP COLUMN voivodeship, region, city;
```

### ERD Impact
- **Iteration 1**: ADMINISTRATIVE_DIVISIONS appears as standalone entity in ERD
- **Future**: Add relationships: SCHOOLS many-to-one ADMINISTRATIVE_DIVISIONS (for each geographic level)

## References
- Data model specification: `.cognitron/data-model.yaml`
- Excel input structure: `__wrzutnia.priv/input_data.xlsx`
- System requirements: `.cognitron/system-requirements.md`
- Architecture documentation: `docs/architecture.md`
