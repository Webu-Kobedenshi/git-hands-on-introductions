#!/usr/bin/env bash
# 受講者ごとに自己紹介タスクの Issue を一括作成するスクリプト(運営用)
#
# 前提:
#   - gh auth login 済み
#   - scripts/create-labels.sh 実行済み
#   - scripts/participants.txt が用意されている
#
# participants.txt のフォーマット:
#   <team>  <display_name>
#     team        : 1 / 2 / 3 / -   (- はチーム未割当)
#     display_name: 受講者の表示名 (スペースを含んでもよい)
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

  # カラム分解(team display_name)
  read -r team display_name <<<"$line"

  if [[ -z "${team:-}" || -z "${display_name:-}" ]]; then
    echo "[skip] 不正な行: $line" >&2
    continue
  fi

  if [[ ! "$team" =~ ^([1-3]|-)$ ]]; then
    echo "[skip] team は 1/2/3/- のいずれかにしてください: $line" >&2
    continue
  fi

  # チーム情報からセクション・ファイル配置先・ラベルを組み立て
  if [[ "$team" != "-" ]]; then
    team_section=$'\nチーム: team'"${team}"$'\n'
    file_dir="self-introductions/team${team}"
    team_label="team${team}"
  else
    team_section=""
    file_dir="self-introductions"
    team_label=""
  fi

  title="[自己紹介] ${display_name} さん"

  # 本文テンプレート(issue_number を後で埋め込む)
  render_body() {
    local issue_number="$1"
    cat <<EOF
## このイシューについて

Git ハンズオン研修で **自己紹介の Markdown ファイル** を作成するタスクです。
${team_section}
## ゴール

- [ ] 自分専用のブランチを切る (例: \`feature/${issue_number}\`)
- [ ] \`templates/self-introduction.md\` をコピーして \`${file_dir}/<あなたの名前>.md\` を作成する
- [ ] 中身を埋めて commit する
- [ ] push して Pull Request を作る
- [ ] 他のメンバーの PR に最低 1 件コメントする
- [ ] 自分の PR をセルフマージする

## 進め方

詳細な手順は当日配布する **Zenn Book** を参照してください。

## 詰まったら

- まずは Zenn Book の「よく出るエラーと対処」章を確認
- 解決しなければ運営陣 (TA) に声をかけてください
EOF
  }

  # ラベル引数
  label_args=(--label "self-introduction")
  if [[ -n "$team_label" ]]; then
    label_args+=(--label "$team_label")
  fi

  echo "[create] $title"
  # 先にプレースホルダ付き本文で issue を作成し、URL から番号を取得
  issue_url="$(gh issue create \
    --title "$title" \
    --body  "$(render_body '<issue番号>')" \
    "${label_args[@]}")"
  issue_number="${issue_url##*/}"

  # 取得した番号で本文を上書き
  gh issue edit "$issue_number" --body "$(render_body "$issue_number")" >/dev/null

  count=$((count + 1))
done < "$PARTICIPANTS_FILE"

echo
echo "完了: $count 件の Issue を作成しました"
