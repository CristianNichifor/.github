#!/usr/bin/env bash
# Apply the branch rulesets in rulesets/ to the CristianNichifor repositories. Idempotent: a ruleset
# is created, or updated in place when one with the same name exists. Also makes sure each
# dev -> main repository allows merge commits (main accepts only those) and defaults to dev.
#   DRY_RUN=1 (default) prints what it would do; DRY_RUN=0 applies.
#   scripts/apply-rulesets.sh
set -euo pipefail
cd "$(dirname "$0")/.."
OWNER=CristianNichifor
DRY=${DRY_RUN:-1}
ACTIONS_APP=15368   # the GitHub Actions app

list() { grep -vE '^\s*(#|$)' "$1"; }
bypass() { list rulesets/actions-bypass.txt | grep -qx "$1"; }

apply() {  # apply <repo> <ruleset file> [with-actions-bypass]
  local repo=$1 file=$2 body name id
  body=$(jq -c . "$file")
  [ "${3:-}" = actions ] && body=$(jq -c --argjson app "$ACTIONS_APP" \
    '.bypass_actors = [{"actor_id": $app, "actor_type": "Integration", "bypass_mode": "always"}]' <<<"$body")
  name=$(jq -r .name <<<"$body")
  id=$(gh api "repos/$OWNER/$repo/rulesets" --jq ".[] | select(.name == \"$name\") | .id" | head -1)
  if [ "$DRY" = 1 ]; then echo "DRY_RUN $repo: ${id:+update}${id:-create} ruleset $name$([ "${3:-}" = actions ] && echo ' (Actions bypass)')"; return; fi
  if [ -n "$id" ]; then gh api -X PUT "repos/$OWNER/$repo/rulesets/$id" --input - <<<"$body" >/dev/null
  else gh api -X POST "repos/$OWNER/$repo/rulesets" --input - <<<"$body" >/dev/null; fi
  echo "PASS $repo: ruleset $name $([ -n "$id" ] && echo updated || echo created)"
}

for repo in $(list rulesets/repos.txt); do
  settings=$(gh api "repos/$OWNER/$repo" --jq '"\(.default_branch) \(.allow_merge_commit)"')
  read -r default merge <<<"$settings"
  if [ "$default" != dev ] || [ "$merge" != true ]; then
    if [ "$DRY" = 1 ]; then echo "DRY_RUN $repo: set default_branch=dev, allow_merge_commit=true (now $default, $merge)"
    else gh api -X PATCH "repos/$OWNER/$repo" -f default_branch=dev -F allow_merge_commit=true >/dev/null; echo "PASS $repo: default dev, merge commits allowed"; fi
  fi
  extra=; bypass "$repo" && extra=actions
  apply "$repo" rulesets/dev.json "$extra"
  apply "$repo" rulesets/main.json "$extra"
done
apply .github rulesets/main-only.json
