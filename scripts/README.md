# 運営陣用スクリプト

研修開始前に運営陣が実行するスクリプト群です。受講者は触りません。

## ファイル一覧

| ファイル | 用途 |
|---|---|
| `participants.example.txt` | 受講者リストのサンプル |
| `participants.txt` | **(gitignore)** 実際の受講者リスト |
| `create-issues.sh` | 受講者ごとに Issue を一括作成 |
| `create-labels.sh` | チームラベル `team1`/`team2`/`team3` を作成 |

## 事前準備

### 1. GitHub CLI のセットアップ

```bash
# 認証(済みでなければ)
gh auth login
```

### 2. 受講者リストの作成

`participants.example.txt` をコピーして `participants.txt` を作り、実際の受講者を書き込みます。

```bash
cp scripts/participants.example.txt scripts/participants.txt
# 編集
```

書式:

```
# team_number github_id 表示名(任意)
1 octocat オクトキャット
1 hubot ヒューボット
2 ...
```

- `#` で始まる行はコメント
- 空行は無視
- カラム区切りは半角スペースまたはタブ

### 3. ラベルの作成

```bash
bash scripts/create-labels.sh
```

`team1` / `team2` / `team3` / `self-introduction` の 4 つのラベルが作成されます。既存の場合はスキップされます。

### 4. Issue の一括作成

```bash
bash scripts/create-issues.sh
```

受講者の人数分の Issue が作成されます。各 Issue は対応する受講者に **assignee** が設定され、チームラベルが付きます。

### 5. URL の共有

受講者に以下を共有します。

- このリポジトリの URL
- Zenn Book の URL
- SpeakerDeck の URL
- 自分用 Issue へのリンク(各自に DM するか、当日表示)

## 注意

- スクリプトは冪等ではありません。同じ受講者リストで 2 回実行すると Issue が重複します。
- 失敗した場合の Issue 削除は GitHub Web UI から行うか、`gh issue close` を使ってください。
