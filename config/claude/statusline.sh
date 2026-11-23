#!/usr/bin/env bash
payload=$(cat)

reset='\033[0m'; bold='\033[1m'; dim='\033[2m'
red='\033[31m'; green='\033[32m'; yellow='\033[33m'
magenta='\033[35m'; cyan='\033[36m'
sep="${dim} │ ${reset}"

# ── 1. Model ────────────────────────────────────────────────────────────────
model=$(echo "$payload" | jq -r '.model.display_name // .model.id // .model // "Claude"')
part_model="${magenta}${model}${reset}"

# ── 2. Context window ───────────────────────────────────────────────────────
ctx_pct=$(echo "$payload" | jq -r '.context_window.used_percentage // 0')
ctx_int=$(printf "%.0f" "$ctx_pct")
filled=$(( ctx_int * 10 / 100 )); empty=$(( 10 - filled ))
bar=""
for ((i=0;i<filled;i++)); do bar+="█"; done
for ((i=0;i<empty;i++)); do bar+="░"; done
if   (( ctx_int >= 80 )); then ctx_color="$red"
elif (( ctx_int >= 50 )); then ctx_color="$yellow"
else                           ctx_color="$green"; fi
part_ctx="${ctx_color}${bar} ${ctx_int}%${reset}"

# ── 3. Git branch ───────────────────────────────────────────────────────────
cwd=$(echo "$payload" | jq -r '.workspace.current_dir // .cwd // ""')
[[ -z "$cwd" ]] && cwd="$PWD"
part_git=""
if git -C "$cwd" rev-parse --is-inside-work-tree &>/dev/null; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
        || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  part_git="${green} ${branch}${reset}"
fi

# ── 4 & 5. Rate limits ──────────────────────────────────────────────────────
rate_color() {
  local p; p=$(printf "%.0f" "$1")
  if   (( p >= 80 )); then printf "%s" "$red"
  elif (( p >= 50 )); then printf "%s" "$yellow"
  else                     printf "%s" "$green"; fi
}
r5=$(echo "$payload" | jq -r '.rate_limits.five_hour.used_percentage // 0')
r7=$(echo "$payload" | jq -r '.rate_limits.seven_day.used_percentage // 0')
part_r5="$(rate_color $r5)Session:$(printf "%.0f" $r5)%${reset}"
part_r7="$(rate_color $r7)Weekly:$(printf "%.0f" $r7)%${reset}"

# ── 6. Session duration ─────────────────────────────────────────────────────
transcript=$(echo "$payload" | jq -r '.transcript_path // ""')
part_dur=""
if [[ -n "$transcript" && -e "$transcript" ]]; then
  btime=$(stat -f %B "$transcript" 2>/dev/null || stat -c %Z "$transcript" 2>/dev/null)
  if [[ -n "$btime" && "$btime" != "0" ]]; then
    elapsed=$(( $(date +%s) - btime ))
    hrs=$(( elapsed / 3600 )); mins=$(( (elapsed % 3600) / 60 ))
    if (( hrs > 0 )); then
      dur="${hrs}h $(printf "%02d" $mins)m"
    else
      dur="${mins}m"
    fi
    part_dur="${dim}${dur}${reset}"
  fi
fi

# ── 7. Folder ───────────────────────────────────────────────────────────────
folder=$(basename "$cwd")
part_folder="${bold}${cyan}${folder}${reset}"

# ── Assemble and print ──────────────────────────────────────────────────────
line="$part_model${sep}$part_ctx"
[[ -n "$part_git" ]] && line+="${sep}$part_git"
line+="${sep}$part_r5${sep}$part_r7"
[[ -n "$part_dur" ]] && line+="${sep}$part_dur"
line+="${sep}$part_folder"
printf "%b\n" "$line"