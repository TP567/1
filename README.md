# Smarthome (Home Assistant)

Planung und Konfiguration für mein Smarthome. Ziel: Automationen als Code
pflegen, Geräte und Szenen sauber einrichten und die Anlage über die Zeit
schrittweise optimieren.

## Status

**Phase: Planung.** Die Wohnung wird gerade umgebaut (Miete, Elektrik teilweise
erneuert, Wände bereits geschlossen), eingezogen ist noch niemand und Home
Assistant läuft noch nicht. Der Schwerpunkt liegt deshalb aktuell auf den
Dokumenten unter `docs/`, nicht auf dem YAML-Code – der Code ist ein Gerüst mit
Platzhalter-Entities und wird scharf geschaltet, sobald die Geräte da sind.

Einstiegspunkte:

| Datei | Inhalt |
|---|---|
| [`docs/PLANUNG.md`](docs/PLANUNG.md) | Technologieentscheidung und Geräteplan je Gewerk (Licht, Beschattung, Sicherheit, Heizung) |
| [`docs/BESTANDSAUFNAHME.md`](docs/BESTANDSAUFNAHME.md) | Checkliste: was in der Wohnung geprüft werden muss, bevor gekauft wird |
| [`docs/OPTIMIERUNGEN.md`](docs/OPTIMIERUNGEN.md) | Roadmap und laufendes Backlog |

## Struktur der Konfiguration

```
configuration.yaml    Basiskonfiguration, lädt alles andere per include
secrets.yaml.example  Vorlage für secrets.yaml (Standort, Keys – niemals committen)
automations.yaml      UI-verwaltete Automationen (leer; Code-Automationen liegen in packages/)
scripts.yaml          Skripte/Routinen
scenes.yaml           Szenen
packages/             Ein Paket pro Themenbereich: Helper + Automationen zusammen
  energie_optimierung.yaml    Sanfte Absenkung bei langer Abwesenheit (auf Fußbodenheizung ausgelegt)
  praesenz_beleuchtung.yaml   Bewegungsgesteuertes Licht, manuell deaktivierbar
dashboards/
  uebersicht.yaml       Lovelace-Dashboard (YAML-Modus)
```

Warum Pakete? Jedes `packages/*.yaml` bündelt Helper (`input_boolean`,
`input_number`, …) und die zugehörigen Automationen an einem Ort. Neue
Funktionsbereiche (Beschattung, Sicherheit, …) bekommen einfach eine neue Datei.

## Platzhalter-Entities

Da noch keine Geräte existieren, nutzen die Pakete Platzhalter wie
`climate.wohnzimmer`, `light.wohnzimmer` und `binary_sensor.bewegung_wohnzimmer`.
Vor dem produktiven Einsatz:

1. In Home Assistant unter **Entwicklerwerkzeuge → Zustände** die echten
   Entity-IDs nachschlagen.
2. Platzhalter in `packages/*.yaml` und `dashboards/uebersicht.yaml` ersetzen.
3. Konfiguration prüfen (**Entwicklerwerkzeuge → YAML → Konfiguration prüfen**)
   und neu laden.

## Inbetriebnahme (später)

1. `secrets.yaml.example` nach `secrets.yaml` kopieren und ausfüllen.
   `secrets.yaml` wird nicht eingecheckt.
2. Repo-Inhalt ins Home-Assistant-Konfigurationsverzeichnis legen bzw.
   dorthin klonen, sodass `configuration.yaml` am erwarteten Ort liegt.
3. Konfiguration prüfen, dann Home Assistant neu starten.

## Arbeitsweise

- Änderungen an Automationen laufen über dieses Repo (Commit + `git pull` auf
  dem HA-Host), nicht nur über die UI – so bleibt alles versioniert und
  nachvollziehbar.
- Vor jedem Neustart die Konfiguration prüfen lassen.
- Offene Punkte und Ideen wandern nach `docs/OPTIMIERUNGEN.md`.
