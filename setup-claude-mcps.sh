#!/usr/bin/env bash

# Registers the MCP servers of each Claude Code profile at user scope:
#   claude-m -> ~/.claude-majmun      claude-i -> ~/.claude-intelifi
# Safe to run more than once: servers that already exist are skipped.
# Secrets are read from secrets.env (never committed, see secrets.env.example).
# Project-scoped MCPs are not handled here: they live in each repo's .mcp.json.
#
# Usage: setup-claude-mcps.sh [--dry-run] [claude-m|claude-i|all]

set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_BIN="${CLAUDE_BIN:-$(command -v claude || true)}"
DRY_RUN=0
TARGET="all"
SKIPPED=0

for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=1 ;;
        claude-m|claude-i|all) TARGET="$arg" ;;
        *) echo "Usage: $0 [--dry-run] [claude-m|claude-i|all]" >&2; exit 2 ;;
    esac
done

[ -n "$CLAUDE_BIN" ] || { echo "claude not found in PATH. Install Claude Code first." >&2; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "jq not found. Run the Brewfile first." >&2; exit 1; }
command -v uvx >/dev/null 2>&1 || echo "Warning: uvx not found, the Jira MCPs will not start until uv is installed."

# shellcheck disable=SC1091
[ -f "$DOTFILES/secrets.env" ] && . "$DOTFILES/secrets.env"

# _has_mcp <config dir> <name>
_has_mcp() {
    CLAUDE_CONFIG_DIR="$1" "$CLAUDE_BIN" mcp get "$2" >/dev/null 2>&1
}

# _register <config dir> <name> <json>
_register() {
    local dir="$1" name="$2" json="$3"
    if _has_mcp "$dir" "$name"; then
        echo "  = $name: already registered"
    elif [ "$DRY_RUN" = 1 ]; then
        echo "  + $name: would be added"
    elif CLAUDE_CONFIG_DIR="$dir" "$CLAUDE_BIN" mcp add-json --scope user "$name" "$json" >/dev/null; then
        echo "  + $name: added"
    else
        echo "  ! $name: failed to add" >&2
        SKIPPED=1
    fi
}

# _add_http <config dir> <name> <url>
_add_http() {
    _register "$1" "$2" "$(jq -nc --arg url "$3" '{type: "http", url: $url}')"
}

# _add_jira <config dir> <name> <secrets.env prefix, e.g. JIRA_INTELIFI>
_add_jira() {
    local dir="$1" name="$2" prefix="$3" var
    local url_var="${prefix}_URL" user_var="${prefix}_USERNAME" token_var="${prefix}_API_TOKEN"
    local missing=()
    if _has_mcp "$dir" "$name"; then
        echo "  = $name: already registered"
        return
    fi
    for var in "$url_var" "$user_var" "$token_var"; do
        [ -n "${!var:-}" ] || missing+=("$var")
    done
    if [ "${#missing[@]}" -gt 0 ]; then
        echo "  - $name: skipped, missing in secrets.env: ${missing[*]}"
        SKIPPED=1
        return
    fi
    _register "$dir" "$name" "$(jq -nc \
        --arg url "${!url_var}" --arg user "${!user_var}" --arg token "${!token_var}" \
        '{type: "stdio", command: "uvx", args: ["mcp-atlassian"],
          env: {JIRA_URL: $url, JIRA_USERNAME: $user, JIRA_API_TOKEN: $token}}')"
}

setup_claude_m() {
    local dir="${CLAUDE_M_DIR:-$HOME/.claude-majmun}"
    echo "claude-m ($dir)"
    _add_jira "$dir" jira-intelifi JIRA_INTELIFI
    _add_jira "$dir" jira-bratstvo JIRA_BRATSTVO
    _add_http "$dir" meta_social_technologies https://mcp.facebook.com/devtools
}

setup_claude_i() {
    local dir="${CLAUDE_I_DIR:-$HOME/.claude-intelifi}"
    echo "claude-i ($dir)"
    _add_jira "$dir" jira-intelifi JIRA_INTELIFI
    _add_http "$dir" sentry-intelifi https://mcp.sentry.dev/mcp
}

[ "$TARGET" = "all" ] || [ "$TARGET" = "claude-m" ] && setup_claude_m
[ "$TARGET" = "all" ] || [ "$TARGET" = "claude-i" ] && setup_claude_i

echo
[ "$DRY_RUN" = 1 ] && echo "Dry run: nothing was changed."
echo "Remote MCPs (meta_social_technologies, sentry-intelifi) still need a login: open the profile and run /mcp."
[ "$SKIPPED" = 0 ] || echo "Some servers were skipped or failed, see above."
exit 0
