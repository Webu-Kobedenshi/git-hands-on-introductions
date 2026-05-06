# Git ハンズオン研修リポジトリ

神戸電子専門学校 Web コミュニティの Git/GitHub ハンズオン研修用リポジトリです。

このリポジトリでは、各受講者が **自己紹介の Markdown ファイル** を作成し、ブランチ → commit → push → Pull Request → レビュー → マージ という一連の流れを体験します。

## 前提環境(受講者向け・事前にインストール)

| OS | ターミナル | 備考 |
|---|---|---|
| Windows | **Git Bash**(Git for Windows に同梱) | コマンドプロンプトや PowerShell ではなく、必ず **Git Bash** を起動してください |
| macOS | ターミナル.app | OS 標準のもので OK |
| Linux | お使いのターミナル | OS 標準のもので OK |

すべての受講者に共通で必要なもの:

- **Git** (`git --version` で動作確認できればOK)
- **GitHub CLI** (`gh --version` で動作確認できればOK)
- **GitHub アカウント**(事前に作成・運営に GitHub ID を共有済み)
- 任意のテキストエディタ(VS Code 推奨)

> **なぜ Git Bash か?** Windows のコマンドプロンプトや PowerShell は `cp` や `mkdir -p` などの Unix 系コマンドが使えなかったり、挙動が違ったりします。Git Bash を使えば本日の手順を **macOS / Linux と同じコマンドのまま** 進められるためです。

## 受講者向け: 当日の流れ(概要)

詳細な手順は **Zenn Book**(URL は当日共有)に書いてあります。ここではゴールだけ示します。

1. 自分用に立てられた Issue を確認する
2. 自分専用のブランチを切る
3. `templates/self-introduction.md` をコピーして、自分のチームのディレクトリ配下に `<github-id>.md` を作成する
4. 中身を埋めて commit & push する
5. Pull Request を出す
6. 同じチームのメンバーの PR に **最低 1 件以上コメント** をつける
7. 自分の PR をセルフマージする

## ディレクトリ構成

```
.
├── README.md                              ← このファイル
├── templates/
│   └── self-introduction.md               ← 自己紹介のひな形(コピーして使う)
├── self-introductions/
│   ├── team1/                             ← チーム 1 のメンバーはここに
│   ├── team2/                             ← チーム 2 のメンバーはここに
│   └── team3/                             ← チーム 3 のメンバーはここに
├── .github/
│   └── ISSUE_TEMPLATE/
│       └── self-introduction.md           ← Issue のひな形
└── scripts/
    └── create-issues.sh                   ← 運営用: Issue 一括作成スクリプト
```

ファイルの配置先は **`self-introductions/team{1,2,3}/<github-id>.md`** です。

## 認証方式

ハンズオンでは GitHub CLI (`gh`) を使った HTTPS 認証で進めます。Windows の方は **Git Bash** で実行してください。

```bash
gh auth login
```

ブラウザが開くので、画面の指示に従って認証してください。SSH 鍵や Personal Access Token (PAT) を使う方法もありますが、当日はこれを推奨します(理由は Zenn Book の参考章を参照)。

## 運営陣向け

研修開始前に以下を準備します。

1. **受講者リスト** (`scripts/participants.txt`) を作成
2. **Issue 一括作成スクリプト** (`scripts/create-issues.sh`) を実行
3. 受講者に Zenn Book と SpeakerDeck の URL を共有

詳細は [`scripts/README.md`](scripts/README.md) を参照してください。

## 関連資料

- Zenn Book(本編・手順詳細): TBD
- SpeakerDeck(概念パート): TBD

## ライセンス

研修目的で自由に利用してください。
