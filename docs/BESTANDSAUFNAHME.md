# Bestandsaufnahme

Da die Wände geschlossen sind, entscheidet der **Bestand** darüber, welche
Smarthome-Lösung pro Raum möglich ist. Diese Liste beim nächsten Besuch in der
Wohnung durchgehen und ausfüllen – daraus entsteht anschließend der konkrete
Geräteplan und später die Konfiguration in diesem Repo.

> **Sicherheitshinweis:** Punkte, die das Öffnen von Schaltern, Dosen oder dem
> Verteilerkasten erfordern, gehören zu einer Elektrofachkraft. Am einfachsten
> und billigsten: die Fachkraft fragen, die den Umbau gemacht hat – sie weiß
> ohne Nachmessen, was sie verlegt hat.

## 1. Elektrik (wichtigster Block)

- [ ] **Liegt in den Schalterdosen ein Neutralleiter (N, blau)?**
      Entscheidet über Variante A (Unterputz-Aktoren) vs. Variante B (smarte
      Leuchtmittel + Funktaster). Ggf. unterschiedlich je Raum – in den neu
      gemachten Kreisen wahrscheinlicher als im Rest.
- [ ] Wie tief sind die Gerätedosen (ca. 40 mm flach / 60 mm tief)?
      Bestimmt, ob ein Aktor hinter den Schalter passt.
- [ ] Welche Räume/Kreise wurden beim Umbau **neu** gemacht?
- [ ] Gibt es im Verteilerkasten freie Plätze (TE) für spätere Hutschienengeräte?
- [ ] Sind irgendwo **Leerrohre** vorhanden, durch die nachträglich gezogen
      werden könnte?

## 2. Beleuchtung (pro Raum)

| Raum | Lichtpunkte | Schaltertyp (Schalter/Wechsel/Kreuz/Dimmer) | N vorhanden? | Geplante Variante |
|---|---|---|---|---|
| Flur | | | | |
| Wohnzimmer | | | | |
| Schlafzimmer | | | | |
| Küche | | | | |
| Bad | | | | |
| | | | | |

- [ ] Wo sind **Wechselschaltungen** (zwei Schalter für eine Leuchte)? Die
      brauchen bei Aktor-Lösungen besondere Beachtung.
- [ ] Wo hängen feste Deckenleuchten, wo Steh-/Tischlampen? Für Letztere reicht
      oft ein smarter Zwischenstecker.

## 3. Beschattung (pro Fenster)

- [ ] Elektrische Rolläden mit Wandschalter, manuelle Gurtwickler, oder nichts?
- [ ] Falls elektrisch: Ist der Schalter ein **Taster** oder ein rastender
      Schalter? (Beeinflusst die Aktorwahl.)
- [ ] Falls Gurtwickler: Ist in der Nähe eine Steckdose für den elektrischen
      Wickler?
- [ ] Anzahl und Größe der Fenster (für Materialbedarf).

## 4. Sicherheit & Zugang

- [ ] Anzahl Fenster und Außentüren → Bedarf an Tür-/Fensterkontakten.
- [ ] Welcher Schließzylinder ist in der Wohnungstür verbaut? Ist innen ein
      **Knaufzylinder** (Voraussetzung für aufsetzbare Schlösser wie Nuki)?
- [ ] Gehört der Zylinder zu einer **Schließanlage** des Hauses? (Dann Tausch
      nur mit Zustimmung des Vermieters.)
- [ ] Gibt es eine Gegensprechanlage/Klingel und welchen Typ?

## 5. Netzwerk & Zentrale

- [ ] Wo steht der Router / wo kommt das Internet in die Wohnung?
- [ ] Gibt es Netzwerkdosen? In welchen Räumen?
- [ ] Wo könnte die HA-Zentrale stehen (Strom + möglichst LAN, belüftet,
      geräuschunkritisch)?
- [ ] Grundriss/Wohnungsgröße – wichtig für die Zigbee-Reichweite und die Frage,
      wie viele netzbetriebene Repeater-Geräte nötig sind.

## 6. Heizung

- [ ] Wo sitzt der **Heizkreisverteiler** der Fußbodenheizung?
- [ ] Ist dort oder in unmittelbarer Nähe eine **Steckdose**?
- [ ] Sind bereits Stellantriebe montiert? Welche Spannung (24 V / 230 V)?
- [ ] Wie wird aktuell geregelt (Raumthermostate an der Wand? Welche?)

## 7. Vermieter

- [ ] Ansprechpartner und Weg für schriftliche Zustimmungen geklärt?
- [ ] Welche Maßnahmen brauchen Zustimmung? (Zylindertausch, Außenkameras,
      zusätzliche Bohrungen)

---

Sobald die Punkte aus Block 1–3 stehen, kann der konkrete Geräteplan erstellt
werden. Ergebnisse gern direkt hier eintragen und committen – dann ist der
Stand versioniert und wir bauen die Konfiguration darauf auf.
