# 0005 — Technology Choice: UI Architecture and State Management

## Status
- **Accepted**
- Date: 2025-08-29

## Context
- **Requirement**: State management for school directory browsing with persistent location filters
- **Constraints**:
  - Iteration 1: Read-only interface with filtering and search
  - Location filters must persist across page navigation
  - Administrative division data should be cached (fetched once)
  - Optimize for simple implementation and quick delivery

- **Alternatives considered**:
  - **No state management**: Use component props and localStorage directly
  - **Pinia**: Vue's recommended state management, built into Nuxt
  - **Vuex**: Older Vue state management (still supported)
  - **React-style**: useContext + useReducer pattern in Vue
  - **External**: Zustand, Jotai (overkill for Vue ecosystem)

- **Non-functional requirements**:
  - Simple learning curve and implementation
  - TypeScript support
  - Persistence for user filter preferences
  - Minimal boilerplate for read-only operations
  - Future extensibility for Iteration 2 editing

## Decision
- **Technology chosen**: **Pinia** with localStorage persistence
- **Scope**: 
  - Location filters state (voivodeship, municipality, locality)
  - Administrative divisions cache
  - Search and pagination state
  - School data fetching state
- **Key rationale**:
  - **Native Nuxt integration**: Auto-imported, zero configuration
  - **TypeScript first**: Excellent TS support with type inference
  - **Simple API**: Composition API style, intuitive for Vue 3
  - **Built-in devtools**: Good debugging experience
  - **Persistence plugins**: Easy localStorage integration

## Consequences
- ✅ **Benefits**: 
  - Minimal boilerplate compared to Vuex
  - Excellent TypeScript inference and autocomplete
  - Built-in Nuxt integration with SSR/SPA support
  - Modular stores (locations, schools, search)
  - Easy testing with store mocking

- ⚠️ **Trade-offs**: 
  - Additional dependency (though minimal in Nuxt)
  - Overkill for simple read-only operations
  - LocalStorage persistence needs manual implementation

- 📌 **Migration considerations**: 
  - Can easily remove Pinia and use Vue refs/composables if needed
  - Store logic can be extracted to plain composables
  - Compatible with future backend state synchronization

- 🔍 **Monitoring points**: 
  - Bundle size impact (should be minimal)
  - Performance of reactive state updates
  - localStorage quota usage
  - State hydration performance on app load

## Implementation Details

### Store Structure
```typescript
// stores/locations.ts - Administrative divisions
// stores/schools.ts - School data and filters  
// stores/search.ts - Search state and history
```

### Persistence Strategy
- Location filters: localStorage with JSON serialization
- Administrative divisions: In-memory cache with initial API fetch
- Search history: sessionStorage (optional)

### Performance Considerations
- Lazy loading of administrative divisions
- Debounced search input
- Pagination state management
- Optimistic UI updates where applicable

## References
- [Pinia Documentation](https://pinia.vuejs.org/)
- [Nuxt Pinia Module](https://nuxt.com/modules/pinia)
- [Vue 3 State Management Guide](https://vuejs.org/guide/scaling-up/state-management.html)
