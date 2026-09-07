# Optimierungs-Backlog

Laufende Liste von Ideen und Verbesserungen für die Smarthome-Konfiguration.
Wird bei jeder Session ergänzt/abgehakt, damit die Optimierung nachvollziehbar
bleibt.

## Umgesetzt

- [x] Grundgerüst: Home-Assistant-Config mit Paketstruktur, Dashboard,
      Beispiel-Automationen für Heizung (Abwesenheit) und Beleuchtung
      (Präsenz).

## Offen / Ideen

- [ ] Echte Geräte/Entity-IDs einpflegen (Platzhalter in `packages/*.yaml`
      und `dashboards/uebersicht.yaml` ersetzen).
- [ ] PV-Erzeugung und Batteriespeicher einbinden, Lasten (Waschmaschine,
      Wallbox) auf Überschusszeiten verschieben.
- [ ] Dynamische Stromtarife (z. B. Tibber/aWATTar-Integration) für
      lastverschiebbare Geräte nutzen.
- [ ] Weitere Räume/Zonen nach demselben Paketmuster ergänzen.
- [ ] Sicherheits-Paket: Fenster-/Tür-Kontakte, Abwesenheitssimulation,
      Benachrichtigungen bei ungewöhnlichen Ereignissen.
- [ ] Verbrauchs-Dashboard (Strom/Gas/Wasser) mit Langzeitstatistiken
      ergänzen.
- [ ] Benachrichtigungskanal (`notify.notify`) auf tatsächlich genutzten
      Dienst (z. B. Mobile App, Telegram) festlegen.

> Neue Punkte einfach ergänzen; erledigte nach "Umgesetzt" verschieben statt
> löschen, damit die Historie sichtbar bleibt.
