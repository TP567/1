# Roadmap & Optimierungs-Backlog

Laufende Liste für die Smarthome-Umsetzung. Wird bei jeder Session ergänzt und
abgehakt, damit die Entwicklung nachvollziehbar bleibt.

**Aktuelle Phase: Planung.** Die Wohnung wird umgebaut, Home Assistant läuft
noch nicht. Der Schwerpunkt liegt deshalb auf Bestandsaufnahme und
Geräteentscheidungen, nicht auf Code.

## Erledigt

- [x] Repo-Grundgerüst: Home-Assistant-Konfiguration mit Paketstruktur,
      Dashboard, .gitignore für Secrets.
- [x] Rahmenbedingungen geklärt: Miete, Elektrik teilweise erneuert (Wände
      bereits geschlossen), Fußbodenheizung, Prioritäten Licht/Beschattung/
      Sicherheit.
- [x] Technologieentscheidung dokumentiert: Zigbee als Funkbasis, lokal, ohne
      Cloud-Zwang, alles rückbaubar (`docs/PLANUNG.md`).
- [x] Heizungslogik auf Fußbodenheizung angepasst (träges System: lange
      Abwesenheit, sanfte Absenkung).

## Als Nächstes (vor dem Einzug)

- [ ] **Bestandsaufnahme durchführen** (`docs/BESTANDSAUFNAHME.md`), vor allem:
      Liegt in den Schalterdosen ein Neutralleiter? Solange die Elektrofachkraft
      vom Umbau erreichbar ist, kostet die Auskunft nichts.
- [ ] Rollladen-Situation klären (elektrisch / Gurtwickler / keine).
- [ ] Standort für die HA-Zentrale festlegen (Strom + Netzwerk).
- [ ] Klären, welche Maßnahmen die Zustimmung des Vermieters brauchen
      (Zylindertausch fürs smarte Türschloss, ggf. Kameras).

## Nach dem Einzug

- [ ] Home Assistant installieren, Zigbee-Koordinator einrichten, Netzwerk.
- [ ] Pilot: Licht in ein bis zwei Räumen umsetzen, Erfahrung sammeln, dann
      ausrollen.
- [ ] Echte Entity-IDs einpflegen und die Platzhalter in `packages/*.yaml` und
      `dashboards/uebersicht.yaml` ersetzen.
- [ ] Beschattung umsetzen (Hitzeschutz, Sonnenauf-/-untergang, Anwesenheit).
- [ ] Sicherheitspaket: Tür-/Fensterkontakte, Anwesenheitssimulation,
      Benachrichtigungen.
- [ ] Benachrichtigungskanal (`notify.notify`) auf den tatsächlich genutzten
      Dienst festlegen (Mobile App, Telegram o. ä.).
- [ ] Einzelraumregelung der Fußbodenheizung – zuletzt, siehe Hinweis zur
      Stromversorgung am Heizkreisverteiler in `docs/PLANUNG.md`.

## Später / Ideen

- [ ] Urlaubsmodus mit stärkerer Absenkung (bei Fußbodenheizung erst ab
      mehrtägiger Abwesenheit sinnvoll).
- [ ] Verbrauchs-Dashboard mit Langzeitstatistiken.
- [ ] Live-Zugriff über die Home-Assistant-API einrichten, damit Änderungen
      direkt statt über `git pull` ausgerollt werden können (setzt laufende
      Instanz und Fernzugriff voraus).
- [ ] Backup-Strategie für die HA-Konfiguration.

> Neue Punkte einfach ergänzen; erledigte nach "Erledigt" verschieben statt
> löschen, damit die Historie sichtbar bleibt.
