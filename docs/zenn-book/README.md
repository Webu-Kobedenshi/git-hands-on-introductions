# Zenn Book 下書き

このディレクトリには Zenn Book の下書き原稿を置きます。完成後は Zenn 連携リポジトリにコピーして公開する想定です。

## ファイル構成

```
docs/zenn-book/
├── README.md                       ← このファイル
├── config.yaml                     ← Zenn Book のメタ情報
├── 00-toc.md                       ← 章立てメモ(Zenn には公開しない)
├── 01-introduction.md
├── 02-concepts.md
├── 03-setup.md
├── 04-clone.md
├── 05-issue.md
├── 06-create-branch.md
├── 07-create-file.md
├── 08-push-pr.md
├── 09-review-merge.md
├── 10-conflict-reference.md        ← (参考)
├── 11-troubleshooting.md           ← (参考)
└── 12-next-steps.md                ← (参考)
```

## Zenn に公開する手順(将来作業)

1. Zenn 連携用のリポジトリを別途用意(`npx zenn-cli init` 済みのもの)
2. `books/git-hands-on/` に `config.yaml` と各章の `.md` をコピー
3. `npx zenn preview` でローカル確認
4. `published: true` に変更してコミット → Zenn に自動反映

## 注意

- `00-toc.md` は運営陣向けのメモなので、Zenn 公開時は `chapters` から外しています。
- 各章の冒頭の `---` で囲まれた frontmatter は Zenn のメタデータです。書き換える必要はありません。
