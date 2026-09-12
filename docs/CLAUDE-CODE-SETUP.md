# Claude Code mit Home Assistant verbinden

Anleitung für später – **setzt eine laufende Home-Assistant-Instanz voraus**, die
es aktuell noch nicht gibt (siehe `PLANUNG.md`). Hier festgehalten, damit sie
nach dem Einzug direkt einsatzbereit ist.

## Zuerst: Warum das aus dem Browser nicht geht

Claude Code gibt es in zwei Ausprägungen:

- **Claude Code im Web** (claude.ai/code) – läuft in einer isolierten
  Cloud-Umgebung. **Kein Zugriff auf dein Heimnetz.** Damit lässt sich dieses
  Repo bearbeiten, aber keine HA-Instanz erreichen.
- **Claude Code lokal** (CLI auf Mac/Windows/Linux, oder als VS-Code-Erweiterung)
  – läuft auf deinem Rechner, also im selben Netz wie Home Assistant. **Das ist
  die Variante, die du brauchst.**

Alles Folgende bezieht sich auf die lokale Installation.

## Die drei Ebenen – und was jede wirklich kann

Ein verbreitetes Missverständnis: MCP allein reicht nicht zum Programmieren.
Man braucht die Kombination.

| Ebene | Womit | Was sie kann | Was sie **nicht** kann |
|---|---|---|---|
| **A. Dateizugriff** | Claude Code editiert die YAML-Dateien | **Automationen, Skripte, Szenen, Dashboards schreiben** – das eigentliche Programmieren | Nichts über den Live-Zustand wissen |
| **B. MCP** | HA-Integration „Model Context Protocol Server" | Echte Entity-IDs und Zustände sehen, Geräte testweise schalten | Automationen schreiben; sieht nur für Assist freigegebene Entitäten |
| **C. REST-API** | `curl` aus Claude Code heraus | Konfiguration **prüfen** und **neu laden** | Ersetzt A und B nicht |

**Ebene A ist die wichtigste.** Ebene B liefert den Live-Kontext, damit keine
Platzhalter-Entity-IDs mehr geraten werden müssen. Ebene C schließt den Kreis:
schreiben → prüfen → neu laden, ohne die Weboberfläche anzufassen.

---

## Ebene A: Dateizugriff auf das HA-Konfigurationsverzeichnis

Je nach HA-Installationsart:

### Home Assistant OS (die typische Appliance-Installation)

Das Dateisystem ist abgeschottet, deshalb über eine Freigabe:

1. Add-on **„Samba Share"** installieren und starten
   (Einstellungen → Add-ons; je nach HA-Version unter „Apps" zu finden).
2. Die Freigabe `config` am eigenen Rechner als Netzlaufwerk einbinden.
3. Claude Code in diesem Verzeichnis starten – es sieht dann `configuration.yaml`
   & Co. wie ein normales Projekt.

Alternative ohne Netzlaufwerk: Add-on **„Studio Code Server"** (bringt Git mit)
oder das **„Git pull"**-Add-on, das dieses Repo direkt auf dem HA-Host zieht.

### Home Assistant in Docker oder auf einem eigenen Linux-Rechner

Einfacher: Claude Code direkt auf diesem Rechner installieren (oder per SSH
darauf arbeiten). Dann liegt das Konfigurationsverzeichnis lokal vor, ohne
Umweg.

### In jedem Fall: Git als Sicherheitsnetz

Dieses Repo bleibt die Quelle der Wahrheit. Änderungen also committen, bevor
neu gestartet wird – dann ist jeder kaputte Zustand ein `git revert` entfernt.

---

## Ebene B: MCP-Verbindung einrichten

### Schritt 1 – In Home Assistant

1. **Entitäten für Assist freigeben**: Einstellungen → Sprachassistenten →
   Tab „Entitäten". **Wichtig:** MCP sieht ausschließlich Entitäten, die hier
   freigegeben sind. Ohne diesen Schritt ist die Verbindung leer.
2. **Integration hinzufügen**: Einstellungen → Geräte & Dienste → Integration
   hinzufügen → **„Model Context Protocol Server"**.
3. **Long-Lived Access Token erzeugen**: unten links auf den Benutzernamen →
   Tab „Sicherheit" → „Long-Lived Access Tokens" → Token erstellen. Wird nur
   einmal angezeigt, sofort kopieren.

Der Endpunkt ist danach `/api/mcp` (die eingebaute Assist-API liegt fest auf
`/api/mcp/assist`).

### Schritt 2 – In Claude Code

```bash
claude mcp add --transport http homeassistant \
  http://homeassistant.local:8123/api/mcp \
  --header "Authorization: Bearer DEIN_LONG_LIVED_TOKEN"
```

Von außerhalb des Heimnetzes stattdessen die Nabu-Casa-URL verwenden:
`https://xxxxx.ui.nabu.casa/api/mcp`.

Prüfen und verwalten:

```bash
claude mcp list              # alle konfigurierten Server
claude mcp get homeassistant # Details zu diesem Server
claude mcp remove homeassistant
```

In einer laufenden Sitzung zeigt `/mcp` den Verbindungsstatus.

### Wichtig: den richtigen Scope wählen

`claude mcp add` legt die Konfiguration standardmäßig im **lokalen** Scope ab –
außerhalb des Repos. **Dabei bleiben.**

> ⚠️ **Nicht `--scope project` verwenden.** Das schreibt die Konfiguration in
> eine `.mcp.json` im Projektverzeichnis – und damit landet dein Token im Git.
> `.mcp.json` und `.env` stehen deshalb vorsorglich in der `.gitignore`.

---

## Ebene C: Prüfen und neu laden per REST-API

Damit kann Claude Code nach einer Änderung selbst kontrollieren, ob die
Konfiguration gültig ist – statt blind neu zu starten.

```bash
export HA_URL="http://homeassistant.local:8123"
export HA_TOKEN="dein_long_lived_token"

# Konfiguration prüfen
curl -s -X POST "$HA_URL/api/config/core/check_config" \
  -H "Authorization: Bearer $HA_TOKEN" -H "Content-Type: application/json"

# Alles neu laden (ohne Neustart)
curl -s -X POST "$HA_URL/api/services/homeassistant/reload_all" \
  -H "Authorization: Bearer $HA_TOKEN" -H "Content-Type: application/json"
```

Dafür liegt `scripts/ha-check.sh` im Repo – prüft und lädt in einem Schritt.

Hinweise:

- `check_config` braucht die `config`-Integration, die über `default_config` in
  `configuration.yaml` bereits aktiv ist. Ein 404 deutet darauf hin, dass sie
  fehlt.
- Die REST-API braucht für Konfigurationsänderungen **Admin-Rechte**. Ein Token
  eines eingeschränkten Benutzers reicht zum Steuern und Auslesen, nicht zum
  Prüfen/Neuladen.
- `reload_all` deckt die meisten Änderungen ab. Änderungen an `configuration.yaml`
  selbst oder an Integrationen brauchen weiterhin einen Neustart.

---

## Sicherheit

- **Token niemals committen.** `secrets.yaml`, `.env` und `.mcp.json` sind in der
  `.gitignore`.
- Token lassen sich in HA jederzeit widerrufen (Profil → Sicherheit) – bei
  Verdacht sofort tun, das Erzeugen eines neuen dauert 20 Sekunden.
- Für den Alltag reicht ein Token eines **eingeschränkten Benutzers**
  (Steuern + Auslesen). Ein Admin-Token nur dort einsetzen, wo Ebene C wirklich
  gebraucht wird.
- Solange alles im Heimnetz läuft (`homeassistant.local`), verlässt der Token
  dein Netz nicht. Bei der Nabu-Casa-URL geht der Zugriff über das Internet –
  dann besonders sorgsam mit dem Token umgehen.

## Empfohlene Reihenfolge nach dem Einzug

1. Home Assistant installieren, Geräte einbinden.
2. Repo ins Konfigurationsverzeichnis bringen (Ebene A) – ab hier kann Claude
   Code Automationen schreiben.
3. Entitäten für Assist freigeben und MCP verbinden (Ebene B) – ab hier kennt
   Claude Code deine echten Entity-IDs und die Platzhalter in `packages/`
   können ersetzt werden.
4. `scripts/ha-check.sh` einrichten (Ebene C) – ab hier läuft der Zyklus
   schreiben → prüfen → laden ohne Handgriffe in der Weboberfläche.

## Quellen

- [Model Context Protocol Server – Home Assistant](https://www.home-assistant.io/integrations/mcp_server/)
- [Model Context Protocol (Client) – Home Assistant](https://www.home-assistant.io/integrations/mcp/)
- [REST API – Home Assistant Developer Docs](https://developers.home-assistant.io/docs/api/rest/)
- [MCP in Claude Code](https://code.claude.com/docs/en/mcp)
