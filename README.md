# AI‑Ready Project Starter

Ten szablon pomaga zorganizować wymagania i kontekst projektu tak,
aby modele AI mogły generować kod i testy na podstawie jednoznacznej specyfikacji.

## Struktura
- `spec/vision.md` — kontekst biznesowy i cele.
- `spec/prd.md` — wymagania produktowe z kryteriami akceptacji.
- `spec/system-requirements.md` — wymagania systemowe i niefunkcjonalne.
- `spec/api.yaml` — specyfikacja API (OpenAPI 3.0).
- `spec/data-model.yaml` — model danych (YAML + przykłady).
- `spec/glossary.md` — słownik pojęć i nazewnictwo.
- `spec/user-stories.md` — user stories i przypadki użycia.
- `tests/acceptance.feature` — testy akceptacyjne (Gherkin).
- `docs/architecture.md` — architektura logiczna/techniczna.
- `docs/adr/0001-record-architecture-decisions.md` — decyzje architektoniczne.
- `prompts/dev_prompt.md` — gotowy prompt do generowania kodu ze specyfikacji.

## Jak używać
1) Uzupełnij pliki w katalogu `spec/` i `docs/`.
2) Uruchamiaj modele AI z użyciem promptu z `prompts/dev_prompt.md`.
3) Automatyzuj walidację: lint OpenAPI, testy Gherkin, schematy JSON.

