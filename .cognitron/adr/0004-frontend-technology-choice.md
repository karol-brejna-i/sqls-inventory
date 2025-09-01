# 0004 — Technology Choice: Frontend Framework for School Directory UI

## Status
- **Accepted**
- Date: 2025-08-29

## Context
- **Requirement**: Build a desktop web application for marketing professionals to browse and search school directory data
- **Constraints**: 
  - Iteration 1 scope: Read-only browsing interface
  - Optimize for quick delivery
  - Integration with existing FastAPI backend
  - Target users: Marketing professionals (internal tool, no SEO requirements)

- **Alternatives considered**:
  - **React + Vite**: Popular, large ecosystem, team might have experience
  - **Vue 3 + Vite**: Simpler learning curve, good performance
  - **Nuxt.js**: Vue-based with SSR capabilities and conventions
  - **Angular**: Full framework but heavier for simple browsing interface
  - **Vanilla JS + Web Components**: Lightweight but slower development

- **Non-functional requirements**:
  - Quick development time (optimize for delivery speed)
  - Good developer experience and productivity
  - TypeScript support
  - Modern tooling and build system
  - Future extensibility for Iteration 2 (editing capabilities)

## Decision
- **Technology chosen**: **Nuxt.js 3.x** in SPA mode
- **Scope**: Complete frontend application for school directory browsing
- **Key rationale**:
  - **High productivity**: Convention over configuration, auto-imports, file-based routing
  - **Vue ecosystem**: Simpler than React for rapid prototyping, excellent TypeScript support
  - **SPA mode**: No SSR overhead needed for internal tool, simpler deployment
  - **Future-ready**: Can enable SSR later if needed, good foundation for Iteration 2 editing features
  - **Integrated tooling**: Built-in Vite, auto-imports, module system

## Consequences
- ✅ **Benefits**: 
  - Rapid development with Nuxt conventions and auto-imports
  - Excellent TypeScript support out of the box
  - Built-in state management (Pinia) and routing
  - Good performance with Vue 3 Composition API
  - Strong ecosystem for UI components (Nuxt UI, Tailwind CSS)

- ⚠️ **Trade-offs**: 
  - Smaller ecosystem compared to React
  - Team learning curve if unfamiliar with Vue/Nuxt
  - SPA mode loses some Nuxt SSR benefits
  - Framework lock-in (though Vue knowledge is transferable)

- 📌 **Migration considerations**: 
  - Can migrate to pure Vue 3 + Vite if Nuxt becomes unnecessary
  - Component-based architecture makes migration to other Vue frameworks feasible
  - API integration layer can be reused with different frontend frameworks

- 🔍 **Monitoring points**: 
  - Development velocity and developer satisfaction
  - Bundle size and load performance (<250KB target)
  - Build time and hot reload performance
  - TypeScript compilation speed

## References
- [Nuxt 3 Documentation](https://nuxt.com/)
- [Vue 3 Performance Benchmarks](https://vue-next-performance-tests.netlify.app/)
- [Nuxt vs Next.js Comparison](https://nuxt.com/docs/guide/concepts/nuxt-app)
