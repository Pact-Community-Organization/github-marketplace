#!/usr/bin/env bash
# Stop (session-end) hook — scans modified files for potential secret leakage.
# Configure in .claude/settings.json or ~/.claude/settings.json:
#
#   "hooks": {
#     "Stop": [{"hooks": [{"type": "command",
#       "command": "~/.claude/scripts/session-end-secrets-scan.sh"}]}]
#   }
#
# Set SCAN_MODE=block to fail the session on findings (default: warn).
# Set SKIP_SECRETS_SCAN=true to skip entirely.

set -euo pipefail

if [[ "${SKIP_SECRETS_SCAN:-}" == "true" ]]; then
  exit 0
fi

SCAN_MODE="${SCAN_MODE:-warn}"
SCAN_SCOPE="${SCAN_SCOPE:-diff}"

if [[ "$SCAN_SCOPE" == "staged" ]]; then
  mapfile -t CANDIDATE_FILES < <(git diff --cached --name-only --diff-filter=ACMR 2>/dev/null || true)
else
  mapfile -t CANDIDATE_FILES < <(git diff --name-only --diff-filter=ACMR HEAD 2>/dev/null || true)
fi

if [[ ${#CANDIDATE_FILES[@]} -eq 0 ]]; then
  exit 0
fi

is_text_file() {
  local file="$1"
  [[ -f "$file" ]] || return 1
  file "$file" 2>/dev/null | grep -qiE 'text|json|xml|yaml|script|ascii|utf-8'
}

is_skipped_file() {
  local file="$1"
  [[ "$file" =~ (^|/)pnpm-lock\.yaml$|(^|/)package-lock\.json$|(^|/)yarn\.lock$|(^|/)\.git/ ]]
}

is_placeholder_match() {
  local value="$1"
  printf '%s' "$value" | grep -qiE 'example|changeme|your[_-]|placeholder|dummy|test[_-]?key'
}

PATTERNS=(
  'AWS_ACCESS_KEY|critical|AKIA[0-9A-Z]{16}'
  'GITHUB_PAT|critical|ghp_[A-Za-z0-9_]{20,}'
  'GITHUB_FINE_GRAINED_PAT|critical|github_pat_[A-Za-z0-9_]{20,}'
  'SLACK_TOKEN|high|xox[baprs]-[A-Za-z0-9-]{10,}'
  'STRIPE_SECRET_KEY|critical|sk_(live|test)_[A-Za-z0-9]{16,}'
  'PRIVATE_KEY|critical|-----BEGIN (RSA |EC |OPENSSH |DSA |PGP )?PRIVATE KEY-----'
  "GENERIC_SECRET|high|(api[_-]?key|secret|password|token)[[:space:]]*[:=][[:space:]]*[\"']?[A-Za-z0-9_\-\.]{10,}"
  'JWT_TOKEN|medium|eyJ[A-Za-z0-9_\-]{10,}\.[A-Za-z0-9_\-]{10,}\.[A-Za-z0-9_\-]{10,}'
  'CONNECTION_STRING|high|(postgres(ql)?|mysql|mongodb(\+srv)?|redis)://[^[:space:]]+'
)

FINDINGS=()
SCANNED=0

for path in "${CANDIDATE_FILES[@]}"; do
  is_skipped_file "$path" && continue
  is_text_file "$path" || continue
  ((SCANNED += 1))
  for entry in "${PATTERNS[@]}"; do
    IFS='|' read -r name severity regex <<< "$entry"
    while IFS=: read -r lineno line; do
      [[ -n "$lineno" ]] || continue
      is_placeholder_match "$line" && continue
      redacted="$(printf '%s' "$line" | cut -c1-80)"
      FINDINGS+=("$path|$lineno|$name|$severity|$redacted")
    done < <(grep -nE "$regex" "$path" 2>/dev/null || true)
  done
done

if [[ ${#FINDINGS[@]} -eq 0 ]]; then
  echo "Secrets scan: clean ($SCANNED file(s) checked)."
  exit 0
fi

echo "Potential secrets detected: ${#FINDINGS[@]} finding(s) in $SCANNED file(s)."
echo "FILE|LINE|PATTERN|SEVERITY|SNIPPET"
for item in "${FINDINGS[@]}"; do
  echo "$item"
done

if [[ "$SCAN_MODE" == "block" ]]; then
  echo "Session blocked: set SKIP_SECRETS_SCAN=true to bypass."
  exit 2
fi

exit 0
