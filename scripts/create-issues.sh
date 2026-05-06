#!/usr/bin/env bash
# 受講者ごとに自己紹介タスクの Issue を一括作成するスクリプト(運営用)
#
# 前提:
#   - gh auth login 済み
#   - scripts/create-labels.sh 実行済み
#   - scripts/participants.txt が用意されている
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARTICIPANTS_FILE="$SCRIPT_DIR/participants.txt"

if [[ ! -f "$PARTICIPANTS_FILE" ]]; then
  echo "エラー: $PARTICIPANTS_FILE が存在しません" >&2
  echo "       scripts/participants.example.txt をコピーして作成してください" >&2
  exit 1
fi

REPO="$(gh repo view --json nameWithOwner --jq .nameWithOwner)"
echo "対象リポジトリ: $REPO"
echo

count=0
while IFS= read -r line || [[ -n "$line" ]]; do
  # コメントと空行をスキップ
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${line// }" ]] && continue

  # カラム分解(team_number github_id 表示名(任意))
  read -r team_number github_id display_name <<<"$line"

  if [[ -z "${team_number:-}" || -z "${github_id:-}" ]]; then
    echo "[skip] 不正な行: $line" >&2
    continue
  fi

  if [[ ! "$team_number" =~ ^[1-3]$ ]]; then
    echo "[skip] team_number は 1/2/3 のいずれかにしてください: $line" >&2
    continue
  fi

  # タイトル組み立て
  if [[ -n "${display_name:-}" ]]; then
    title="[自己紹介] @${github_id} (${display_name}) さん"
  else
    title="[自己紹介] @${github_id} さん"
  fi

  # 本文を生成(team_number と github_id を埋め込む)
  body=$(cat <<EOF
## このイシューについて

Git ハンズオン研修で **自己紹介の Markdown ファイル** を作成するタスクです。

担当: @${github_id}
チーム: team${team_number}

## ゴール

- [ ] 自分専用のブランチを切る (例: \`add-self-introduction-${github_id}\`)
- [ ] \`templates/self-introduction.md\` をコピーして \`self-introductions/team${team_number}/${github_id}.md\` を作成する
- [ ] 中身を埋めて commit する
- [ ] push して Pull Request を作る
- [ ] 同じチームのメンバーの PR に最低 1 件コメントする
- [ ] 自分の PR をセルフマージする

## 進め方

詳細な手順は当日配布する **Zenn Book** を参照してください。

## 詰まったら

- まずは Zenn Book の「よく出るエラーと対処」章を確認
- 解決しなければ運営陣 (TA) に声をかけてください
EOF
)

  echo "[create] $title"
  gh issue create \
    --title "$title" \
    --body  "$body" \
    --assignee "$github_id" \
    --label "self-introduction" \
    --label "team${team_number}" \
    >/dev/null

  count=$((count + 1))
done < "$PARTICIPANTS_FILE"

echo
echo "完了: $count 件の Issue を作成しました"
