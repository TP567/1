# Smarthome-Planung

## Ausgangslage

| Punkt | Stand |
|---|---|
| Wohnsituation | **Miete** – alles muss beim Auszug rückbaubar sein |
| Bauphase | Umbau läuft, Elektrik teilweise erneuert, **Wände bereits geschlossen** |
| Heizung | **Fußbodenheizung** |
| Prioritäten | Licht & Szenen, Beschattung, Sicherheit & Zugang |
| Home Assistant | Läuft noch nicht – Installation erst nach Einzug |

Da die Wände zu sind, fällt alles weg, was neue Leitungen bräuchte. Das ist
weniger schlimm, als es klingt: **Licht, Beschattung und Sicherheit sind
vollständig ohne Stemmarbeiten machbar.** Es verschiebt nur die Gerätewahl.

Was jetzt zählt, ist nicht mehr, was noch verlegt wird, sondern **was
tatsächlich in der Wand liegt** – siehe
[BESTANDSAUFNAHME.md](BESTANDSAUFNAHME.md).

## Grundsatzentscheidung: Funk, lokal, rückbaubar

Ein Bussystem (KNX) ist hier ausgeschlossen: bräuchte neue Leitungen, ist
teuer und in einer Mietwohnung nicht rückbaubar.

| Ebene | Wahl | Begründung |
|---|---|---|
| Funkstandard (Basis) | **Zigbee** | Herstellerübergreifend, batteriesparend, läuft vollständig lokal, größte Geräteauswahl, sehr gute HA-Integration |
| Perspektivisch | **Matter/Thread** | Wächst als Standard, HA unterstützt es. Nicht erzwingen, aber bei Neukauf mitnehmen, wenn Preis und Funktion stimmen |
| Unterputz-Aktoren | **Shelly (WLAN) oder Zigbee-Aktoren** | Kommen hinter den vorhandenen Schalter, ohne Eingriff in die Leitung. **Setzen einen Neutralleiter in der Dose voraus** |
| Zentrale | **Home Assistant, lokal** | Kein Cloud-Zwang, keine Abhängigkeit von Herstellerservern, alles versioniert in diesem Repo |

Grundregel bei jedem Kauf: **lokal steuerbar** (Zigbee, Matter, Shelly mit
lokaler API). Geräte, die zwingend über eine Hersteller-Cloud laufen, sind tot,
sobald der Hersteller den Dienst abschaltet.

## Die eine entscheidende Unbekannte: Neutralleiter

Fast alles beim Thema Licht hängt daran, ob in den Schalterdosen ein
**Neutralleiter (N, blau)** liegt. In neu verlegten Kreisen ist das heute
üblich, in Altbestand oft nicht.

> **Nicht selbst in der Dose nachsehen**, wenn du keine Elektro-Fachkenntnis
> hast. Entweder die Elektrofachkraft fragen, die den Umbau gemacht hat (die
> weiß es ohne Nachmessen), oder prüfen lassen.

Beide Fälle sind lösbar:

### Variante A – Neutralleiter vorhanden

**Unterputz-Aktor hinter dem vorhandenen Schalter.** Die Leuchte bleibt
„dumm", der Wandschalter funktioniert weiter wie gewohnt, zusätzlich ist
alles über HA schaltbar/dimmbar.

- Vorteil: Schalter bleibt bedienbar (wichtig für Gäste und für dich, wenn HA
  mal streikt), günstig pro Lichtpunkt, unauffällig.
- Voraussetzung neben N: **ausreichend tiefe Gerätedose** (ca. 60 mm). In
  flachen 40-mm-Dosen wird es eng – es gibt aber sehr kleine Aktoren.
- Rückbau: Modul raus, Originalschalter wieder rein. Keine Spur.

### Variante B – kein Neutralleiter

**Smarte Leuchtmittel plus Funktaster.** Der vorhandene Schalter wird dauerhaft
auf „ein" gestellt und mit einem batteriebetriebenen Zigbee-Funktaster
überdeckt oder daneben geklebt.

- Vorteil: keinerlei Eingriff in die Elektrik, sofort machbar, Farbe und
  Farbtemperatur inklusive.
- Nachteil: Leuchtmittel dürfen nicht hart stromlos geschaltet werden – der
  Wandschalter darf also nicht mehr benutzt werden. Deshalb der Funktaster
  darüber.
- Teurer pro Leuchte, wenn viele Lichtpunkte betroffen sind.

Praktisch wird es meist eine **Mischung**: Aktoren dort, wo N vorhanden ist
(vermutlich die neu gemachten Kreise), smarte Leuchtmittel im Rest und dort,
wo du ohnehin Farbe willst (Wohnzimmer, Schlafzimmer).

## Beschattung

Je nachdem, was verbaut ist:

- **Elektrische Rolläden mit Wandschalter** → Rollladenaktor in die
  Schalterdose. Braucht N und eine ausreichend tiefe Dose. Voll rückbaubar,
  Originalschalter kommt beim Auszug wieder rein.
- **Manuelle Gurtwickler** → elektrischer Gurtwickler zum Nachrüsten. Kein
  Eingriff in die Elektrik, nur eine Steckdose in der Nähe nötig. Sichtbar und
  hörbar, dafür mietfreundlich und in einer Stunde montiert.
- **Keine Rolläden** → Funk-Vorhangschienen oder smarte Innenjalousien,
  batteriebetrieben oder mit Steckernetzteil.

Automationen später: Hitzeschutz im Sommer (Sonnenstand + Innentemperatur),
Sonnenauf-/-untergang, Anwesenheit, Nachtabsenkung.

## Sicherheit & Zugang

- **Tür-/Fensterkontakte**: Zigbee, batteriebetrieben, geklebt. Ideal für
  Miete – null Eingriff in die Bausubstanz. Basis für Alarm, Heizungslogik
  („Fenster offen") und Anwesenheitssimulation.
- **Türschloss**: aufsetzbare Lösung (z. B. Nuki), die von innen auf den
  vorhandenen Zylinder geschraubt wird. Voraussetzung ist meist ein
  **Knaufzylinder** innen. Der Zylindertausch ist günstig und rückbaubar,
  **muss aber mit dem Vermieter abgestimmt werden** – der Zylinder kann Teil
  einer Schließanlage sein.
- **Kameras**: innen unkritisch. Außen nur nach Absprache mit dem Vermieter und
  ohne Erfassung öffentlicher Wege, Nachbargrundstücke oder gemeinsam genutzter
  Bereiche (Treppenhaus, Hof). Lokale Aufzeichnung bevorzugen, keine
  Cloud-Kameras.
- **Anwesenheitssimulation**: braucht keine eigene Hardware, nutzt die
  vorhandenen Licht- und Rollladenaktoren.
- **Rauchmelder**: Pflichtgeräte bleiben unangetastet. Vernetzte Melder können
  ergänzend Alarme an HA melden – nicht als Ersatz.

## Heizung (nachrangig)

Bei Fußbodenheizung läuft die Einzelraumregelung über **Stellantriebe am
Heizkreisverteiler**, nicht über Thermostatköpfe wie beim Heizkörper. Der
Verteiler sitzt meist in einem Wandschrank im Flur oder Bad.

Wichtig für die Erwartungshaltung: Eine Fußbodenheizung reagiert **träge** –
Stunden, nicht Minuten. Kurzfristiges Absenken beim Verlassen der Wohnung spart
deshalb kaum Energie, sondern sorgt vor allem fürs Auskühlen und teures
Wiederaufheizen. Sinnvoll sind nur lange Abwesenheiten und sanfte
Sollwertverschiebungen (max. 1–2 K) – so ist es in
`packages/energie_optimierung.yaml` umgesetzt und kommentiert.

Praktische Hürde: Am Heizkreisverteiler wird **Strom für die Aktorik**
gebraucht. Ist dort keine Steckdose (und die Wand ist zu), bleiben
Aufputz-Zuleitung, eine Steckdose in der Nähe des Schranks oder
batteriebetriebene Funk-Stellantriebe. Das ist der Grund, dieses Thema nach
hinten zu schieben – es ist der einzige Punkt deiner Liste, der durch die
geschlossenen Wände wirklich unbequemer wird.

## Zentrale (Home Assistant)

Erst nach Einzug zu beschaffen, Standort aber jetzt schon mitdenken:

- Braucht **Strom + Netzwerk** (LAN stabiler als WLAN).
- Sinnvoller Ort: beim Router, belüftet, geräuschunkritisch.
- Der **Zigbee-Koordinator** sollte möglichst zentral in der Wohnung sitzen,
  nicht im Metallschrank neben dem Router – sonst leidet die Funkreichweite.
  Lösungen: USB-Verlängerung oder ein Koordinator mit Netzwerkanschluss, der
  frei platziert werden kann.
- Netzbetriebene Zigbee-Geräte (Aktoren, Zwischenstecker) wirken als Repeater
  und verbessern das Mesh. Batteriegeräte tun das nicht. Deshalb ein paar
  netzbetriebene Geräte über die Wohnung verteilen.

## Miete: Spielregeln

- Alles, was in die Substanz eingreift (Zylindertausch, Außenkameras,
  zusätzliche Bohrungen), **vorher schriftlich mit dem Vermieter abstimmen**.
- Ausgebaute Originalteile (Schalter, Zylinder, Thermostate) **aufheben und
  beschriften** – sie müssen beim Auszug wieder rein.
- Arbeiten an der festen Elektrik gehören in die Hand einer Elektrofachkraft.
  Das Einsetzen eines Unterputz-Aktors ist kein Laienjob.

## Empfohlene Reihenfolge

1. **Bestandsaufnahme** ([BESTANDSAUFNAHME.md](BESTANDSAUFNAHME.md)) – vor
   allem die Frage nach dem Neutralleiter. Solange die Elektrofachkraft vom
   Umbau noch erreichbar ist, kostet die Auskunft nichts.
2. **Zentrale aufsetzen** (nach Einzug): HA installieren, Zigbee-Koordinator,
   Netzwerk. Ohne Zentrale bringt jedes Gerät nur seine eigene App.
3. **Licht** in ein bis zwei Räumen als Pilot – erst Erfahrung sammeln, dann
   ausrollen. Nicht die ganze Wohnung auf einmal kaufen.
4. **Beschattung** – der größte Komfortgewinn pro Euro, wenn elektrische
   Rolläden vorhanden sind.
5. **Sicherheit** – Kontakte sind billig und sofort nützlich, Türschloss nach
   Absprache mit dem Vermieter.
6. **Heizung** – zuletzt, siehe oben.

## Was bewusst offen bleibt

- Konkrete Gerätemodelle (Preise und Verfügbarkeit ändern sich; Entscheidung
  kurz vor dem Kauf).
- Server-Hardware.
- Die eigentlichen Automationen. Die entstehen, sobald die Geräte da sind und
  echte Entity-IDs existieren – vorher wären es nur Platzhalter.
