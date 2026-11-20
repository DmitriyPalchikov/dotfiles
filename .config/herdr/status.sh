#!/bin/sh
# CPU / RAM / git branch для правой части tab bar в herdr.
# Аналог tmux-dracula cpu-usage + ram-usage + git.

cpu=$(top -bn2 -d 0.2 2>/dev/null | awk '/^%Cpu/ { idle=$8 } END { if (idle != "") printf "%.0f", 100-idle }')
[ -z "$cpu" ] && cpu="?"

mem=$(free -m 2>/dev/null | awk '/^Mem:/ { if ($2 > 0) printf "%.0f", $3/$2*100 }')
[ -z "$mem" ] && mem="?"

out="CPU ${cpu}% RAM ${mem}%"

dir="${HERDR_ACTIVE_PANE_CWD:-$PWD}"
branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "$branch" ] && [ "$branch" != "HEAD" ]; then
    out="$out  $branch"
fi

printf '%s\n' "$out"
