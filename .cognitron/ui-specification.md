# UI Specification - School Directory Frontend

## Project Overview
**Target**: Iteration 1 - Read-only school directory browsing interface
**Framework**: Nuxt.js (Vue 3) in SPA mode
**Target Users**: Marketing professionals preparing communication campaigns with schools
**Delivery**: Optimized for quick delivery

## Core Requirements

### User Experience
- **Primary Flow**: Browse by administrative hierarchy (Voivodeship → Municipality → Locality)
- **Platform**: Desktop web application (mobile responsive not required for Iteration 1)
- **Performance**: <300ms response time target

### Key Features
1. **Location-based Browsing**
   - Cascading dropdowns for administrative divisions
   - Persistent filters across page navigation
   - Administrative data fetched once from API on app load

2. **School Listing & Search**
   - Full-text search functionality
   - Filterable school list with pagination
   - Individual school detail pages

3. **Data Confidence Indicators**
   - Standard color scheme (Green/Yellow/Red) for confidence levels
   - Badges/icons on main list view
   - Detailed metadata on hover/detail pages
   - Provenance information (source URL, last updated, confidence score)

4. **Export Functionality** (Future iteration)
   - CSV export of filtered results
   - Client-side generation preferred for quick implementation

### Technical Architecture

#### Nuxt.js Configuration
- **Mode**: SPA (ssr: false)
- **Styling**: Tailwind CSS
- **State Management**: Pinia for persistent filters
- **No caching**: Simple implementation for Iteration 1

#### API Integration
- **Backend**: FastAPI at `http://localhost:8000`
- **Key Endpoints**:
  - `GET /api/v1/schools` - List/search schools
  - `GET /api/v1/schools/{id}` - School details
  - `GET /api/v1/administrative-divisions` - Location hierarchy

#### Project Structure
```
sqls-inventory-ui/
├── components/
│   ├── SchoolCard.vue           # School list item with confidence badges
│   ├── SchoolDetails.vue        # Detailed view with metadata
│   ├── LocationFilters.vue      # Cascading dropdowns
│   ├── SearchBar.vue           # Full-text search
│   └── ConfidenceBadge.vue     # Reusable confidence indicator
├── composables/
│   ├── useSchools.ts           # API calls and data fetching
│   └── useLocationFilters.ts   # Cascading dropdown logic
├── stores/
│   ├── schools.ts              # School data and filters
│   └── locations.ts            # Administrative divisions (cached)
├── pages/
│   ├── index.vue               # Main school list page
│   └── schools/[id].vue        # School detail page
├── types/
│   ├── school.ts               # TypeScript interfaces
│   └── api.ts                  # API response types
└── utils/
    └── api.ts                  # API client configuration
```

### Data Confidence Display
- **High Confidence**: Green badge/checkmark (✓)
- **Medium Confidence**: Yellow warning (⚠)
- **Low Confidence**: Red alert (❌)
- **Hover/Detail**: Source URL, scraped date, confidence percentage

### State Management
- **Location Filters**: Persistent across navigation (localStorage)
- **Search State**: Session-based
- **Administrative Data**: Cached on app initialization
- **No complex caching**: Simple fetch-and-display pattern

## Success Criteria
1. User can browse schools by administrative hierarchy
2. Effective search and filtering capabilities
3. Clear data confidence indicators
4. Responsive and performant interface
5. Ready for future export functionality integration

## Future Considerations (Iteration 2)
- Manual editing capabilities
- User authentication
- Change history and audit trails
- Real-time data updates
- Mobile responsive design
