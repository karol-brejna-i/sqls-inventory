# Prompt dla modelu AI — generowanie kodu

Kontekst: projekt zorganizowany według plików w /spec i /docs.

Instrukcja:
1) Przeczytaj `spec/vision.md`, `spec/prd.md`, `spec/system-requirements.md`,
   `spec/api.yaml`, `spec/data-model.yaml`, `docs/architecture.md`, `spec/glossary.md`.
2) Generuj kod tylko w ramach uzgodnionych technologii i ograniczeń.
3) Dla każdego pliku kodu dodawaj testy jednostkowe i aktualizuj `tests/acceptance.feature` jeśli zmienia się zachowanie.
4) Pilnuj NFR i logowania/telemetrii.
5) Każdy endpoint/opcja musi mieć przykładowe wejście/wyjście.

Żądanie:
- Wygeneruj szkielet usługi (backend) zgodny z `spec/api.yaml` oraz modelami z `spec/data-model.yaml`.
- Dodaj skrypty uruchomieniowe i instrukcję w README.
- Przygotuj testy oraz fixture’y.
