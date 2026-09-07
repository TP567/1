# Smarthome-Konfiguration (Home Assistant)

Dieses Repo enthält die versionierte Home-Assistant-Konfiguration für mein
Smarthome. Ziel: Automationen als Code pflegen, neue Geräte/Szenen sauber
einrichten und die Anlage über die Zeit hinweg schrittweise optimieren
(Energieverbrauch, Komfort, Sicherheit).

## Struktur

```
configuration.yaml   Basiskonfiguration, lädt alles andere per include
secrets.yaml.example Vorlage für secrets.yaml (Standort, Namen, Keys – niemals committen)
automations.yaml      UI-verwaltete Automationen (leer, siehe packages/ für Code-Automationen)
scripts.yaml          Skripte/Routinen (z. B. "Gute Nacht")
scenes.yaml           Szenen
packages/              Ein Paket pro Themenbereich: Helper + Automationen zusammen
  energie_optimierung.yaml     Heizungsabsenkung bei Abwesenheit, Wohlfühltemperatur bei Rückkehr
  praesenz_beleuchtung.yaml    Bewegungsgesteuertes Licht mit Nachtabschaltung, manuell deaktivierbar
dashboards/
  uebersicht.yaml         Lovelace-Dashboard (YAML-Modus) für Klima, Licht, Anwesenheit
```

Warum Pakete? Jedes `packages/*.yaml` bündelt Helper (`input_boolean`,
`input_number`, ...) und die zugehörigen Automationen an einem Ort, statt sie
über `automations.yaml`, `input_boolean.yaml` usw. zu verteilen. Neue
Funktionsbereiche (z. B. Sicherheit, Bewässerung, Rollläden) bekommen einfach
eine neue Datei unter `packages/`.

## Wichtig: Platzhalter-Entity-IDs anpassen

Da noch keine konkreten Geräte hinterlegt sind, verwenden die Beispiel-Pakete
Platzhalter wie `climate.wohnzimmer`, `light.wohnzimmer`,
`binary_sensor.bewegung_wohnzimmer` und `zone.home`. Vor dem produktiven
Einsatz:

1. In Home Assistant unter **Entwicklerwerkzeuge → Zustände** die echten
   Entity-IDs der eigenen Geräte nachschauen.
2. Platzhalter in `packages/*.yaml` und `dashboards/uebersicht.yaml` ersetzen.
3. Konfiguration validieren (**Entwicklerwerkzeuge → YAML → Konfiguration
   prüfen**, oder `hass --script check_config`) und neu laden.

## Setup

1. `secrets.yaml.example` nach `secrets.yaml` kopieren und mit echten Werten
   (Standort, Name) befüllen. `secrets.yaml` wird nicht eingecheckt.
2. Repo-Inhalt in das Home-Assistant-Konfigurationsverzeichnis legen (bzw.
   symlinken), sodass `configuration.yaml` dort liegt, wo Home Assistant sie
   erwartet.
3. Konfiguration prüfen und Home Assistant neu starten.

## Workflow für laufende Optimierung

- Änderungen an Automationen/Paketen über Branches + Commits nachvollziehbar
  machen (kein direktes Bearbeiten nur über die UI, wenn es dauerhaft sein
  soll).
- Vor dem Neustart immer die Konfiguration prüfen lassen.
- Ideen, offene Optimierungen und Priorisierung stehen in
  [`docs/OPTIMIERUNGEN.md`](docs/OPTIMIERUNGEN.md) – dort wird laufend
  ergänzt, was als Nächstes sinnvoll ist (z. B. PV-Einbindung,
  Strompreis-gesteuerte Lasten, weitere Räume).
