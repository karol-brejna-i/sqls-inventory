# 📚 Institution Directory Specification

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](./LICENSE)
![Status](https://img.shields.io/badge/status-in%20progress-yellow)
![Spec](https://img.shields.io/badge/type-specification-lightgrey)

This repository contains the **AI-ready specification and context** for a web application that manages and presents information about institutions (e.g., educational facilities, public organizations).  
It is also an **experiment in specification-driven development with AI** — using structured specs as the source of truth to guide code generation, validation, and evolution.

---

## 🚀 Project Vision
- A **web app** to browse institution information (address, contact, region).  
- **Iteration 1 (priority):** sort, filter, and search through institution data.  
- **Iteration 2:** manual edits of selected fields with **audit trail**.  
- **External modules** can update specific fields (e.g., emails) with provenance metadata.  
- **Future:** authentication, role-based access, rate limits, and integrations.

---

## 📂 Repository Structure
```
.cogitron/       # Specifications & AI context (vision, PRD, data model, API, system reqs)
  vision.md
  prd.md
  system-requirements.md
  api.yaml
  data-model.yaml
  glossary.md
  user-stories.md
  README.md       # Explains .cogitron structure
  prompts/        # Bootstrap & continuation prompts for AI
  adr/            # Architecture Decision Records
docs/            # Architecture docs, diagrams, explanations
tests/           # Acceptance tests in Gherkin
```

---

## 🧩 How to Use

- **For humans:**  
  Read `.cogitron/` files to understand the scope, requirements, and design.  
  Extend docs, add ADRs, evolve specs as the project grows.  

- **For AI models:**  
  Provide the [bootstrap prompt](.cogitron/prompts/bootstrap_prompt.md) to regenerate the project structure from scratch.  
  Use the [continuation prompt](.cogitron/prompts/continuation_prompt.md) to refine individual files.  

---

## 🛠️ Status
- Scope and specs under active development.  
- Technology assumptions: Python/FastAPI backend, PostgreSQL DB, React frontend (to be confirmed in ADRs).  
- Current focus: defining data model, API, and non-functional requirements.  
- Experimental goal: validate a workflow where **AI consumes and evolves specifications** rather than raw code.

---

## 📜 License
This project is licensed under the [Apache License 2.0](./LICENSE).
