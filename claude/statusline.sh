#!/usr/bin/env bash
# Claude Code status line: shares the session state with Neovim (lualine)
# and prints a short status for Claude Code itself, with remaining usage bars.
input=$(cat)

cache="${XDG_CACHE_HOME:-$HOME/.cache}/claude-code"
mkdir -p "$cache"
printf '%s' "$input" > "$cache/status.json.tmp" && mv "$cache/status.json.tmp" "$cache/status.json"

echo "$input" | jq -r '
  # Remaining-usage bar: green, then yellow below 50%, red below 20%
  def bar($label; $used):
    (100 - $used | if . < 0 then 0 else . end) as $left
    | ($left / 10 | round) as $n
    | (if $left < 20 then "31" elif $left < 50 then "33" else "32" end) as $col
    | "\($label) \u001b[\($col)m\("█" * $n)\u001b[90m\("░" * (10 - $n))\u001b[0m \($left | round)%";
  [ .model.display_name,
    (.context_window.remaining_percentage // empty | "ctx \(round)%"),
    (.rate_limits.five_hour.used_percentage // empty | bar("5h"; .)),
    (.rate_limits.seven_day.used_percentage // empty | bar("7j"; .))
  ] | join(" · ")'
