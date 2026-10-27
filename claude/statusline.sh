#!/usr/bin/env bash
# Claude Code status line: shares the session state with Neovim (lualine)
# and prints a short status for Claude Code itself, with usage bars.
input=$(cat)

cache="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code"
mkdir -p "$cache"

# Usage limits are account-wide but only sent once a session got an API
# response: remember the last ones and reuse them until their window resets.
limits="$cache/rate_limits.json"
if echo "$input" | jq -e '.rate_limits | type == "object"' >/dev/null 2>&1; then
  echo "$input" | jq '.rate_limits' > "$limits.tmp" && mv "$limits.tmp" "$limits"
elif [ -f "$limits" ]; then
  input=$(echo "$input" | jq --slurpfile rl "$limits" '
    # Drop windows that already reset (resets_at: epoch seconds or ISO date)
    def live: (.resets_at | if type == "number" then .
      elif type == "string" then (try (sub("\\.[0-9]+"; "") | fromdateiso8601) catch null)
      else null end) as $t
      | $t == null or $t > now;
    .rate_limits = ($rl[0] | with_entries(select(.value | live)))')
fi

printf '%s' "$input" > "$cache/status.json.tmp" && mv "$cache/status.json.tmp" "$cache/status.json"

echo "$input" | jq -r '
  # Used-usage bar (like /usage): green, then yellow from 50%, red from 80%
  def bar($label; $used):
    ($used | if . > 100 then 100 elif . < 0 then 0 else . end) as $u
    | ($u / 10 | round) as $n
    | (if $u >= 80 then "31" elif $u >= 50 then "33" else "32" end) as $col
    | "\($label) \u001b[\($col)m\("█" * $n)\u001b[90m\("░" * (10 - $n))\u001b[0m \($u | round)%";
  [ .model.display_name,
    (.context_window.remaining_percentage // empty | "ctx \(round)%"),
    (.rate_limits.five_hour.used_percentage // empty | bar("5h"; .)),
    (.rate_limits.seven_day.used_percentage // empty | bar("7j"; .))
  ] | join(" · ")'
