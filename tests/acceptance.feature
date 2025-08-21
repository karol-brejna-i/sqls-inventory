Feature: Kluczowe wymagania produktu
  As a user, I want bazowa ścieżka działania, so that osiągam wartość.

  Scenario: Happy path
    Given istnieją poprawne dane wejściowe
    When wywołam funkcję/endpoint
    Then otrzymam wynik 200 OK z poprawnym payloadem

  Scenario: Walidacja błędów
    Given brak wymaganych pól
    When wywołam funkcję/endpoint
    Then otrzymam wynik 400 oraz komunikaty walidacji
