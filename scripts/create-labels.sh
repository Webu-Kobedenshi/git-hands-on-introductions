#!/usr/bin/env bash
# 研修用の GitHub ラベルを作成するスクリプト(運営用)
# 既存のラベルはスキップする。
set -euo pipefail

REPO="$(gh repo view --json nameWithOwner --jq .nameWithOwner)"
echo "対象リポジトリ: $REPO"

create_label_if_missing() {
  local name="$1"
  local color="$2"
  local description="$3"

  if gh label list --limit 200 --json name --jq '.[].name' | grep -Fxq "$name"; then
    echo "  - [skip]   $name (既に存在)"
  else
    gh label create "$name" --color "$color" --description "$description" >/dev/null
    echo "  - [create] $name"
  fi
}

echo "ラベルを作成します..."
create_label_if_missing "team1"              "1f6feb" "チーム 1"
create_label_if_missing "team2"              "2da44e" "チーム 2"
create_label_if_missing "team3"              "d29922" "チーム 3"
create_label_if_missing "self-introduction"  "8957e5" "自己紹介タスク"

echo "完了"
