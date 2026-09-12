#!/usr/bin/env bash
#
# Prüft die Home-Assistant-Konfiguration und lädt sie bei Erfolg neu.
# Braucht ein Token mit Admin-Rechten (siehe docs/CLAUDE-CODE-SETUP.md).
#
# Verwendung:
#   export HA_URL="http://homeassistant.local:8123"
#   export HA_TOKEN="..."
#   scripts/ha-check.sh            # nur prüfen
#   scripts/ha-check.sh --reload   # prüfen und bei Erfolg neu laden

set -euo pipefail

: "${HA_URL:?HA_URL ist nicht gesetzt (z. B. http://homeassistant.local:8123)}"
: "${HA_TOKEN:?HA_TOKEN ist nicht gesetzt (Long-Lived Access Token)}"

api() {
  curl -sS -X POST "${HA_URL}$1" \
    -H "Authorization: Bearer ${HA_TOKEN}" \
    -H "Content-Type: application/json"
}

echo "Prüfe Konfiguration auf ${HA_URL} ..."
result="$(api /api/config/core/check_config)"
echo "$result"

if ! grep -q '"result"[[:space:]]*:[[:space:]]*"valid"' <<<"$result"; then
  echo "Konfiguration ist NICHT gültig – es wird nichts neu geladen." >&2
  exit 1
fi

echo "Konfiguration ist gültig."

if [[ "${1:-}" == "--reload" ]]; then
  echo "Lade Konfiguration neu ..."
  api /api/services/homeassistant/reload_all >/dev/null
  echo "Neu geladen."
  echo "Hinweis: Änderungen an configuration.yaml oder an Integrationen"
  echo "brauchen weiterhin einen Neustart von Home Assistant."
fi
