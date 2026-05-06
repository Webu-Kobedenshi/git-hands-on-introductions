---
title: "【参考】次に学ぶと良いこと"
free: true
---

> :::message
> 今日のハンズオンお疲れさまでした! この章では「次のステップ」として、今日扱わなかった Git の便利機能を **名前と一行説明** だけ紹介します。気になったものを Web で調べてみてください。
> :::

## 今日触れなかった重要トピック

### `git stash` — 作業を一時退避

「ブランチ切り替えたいけど、まだ commit したくない作業がある」というときに使います。

```bash
git stash               # 退避
git switch other-branch # 別ブランチへ
git stash pop           # 戻して再開
```

実務では「急いでバグ修正の別ブランチに移らないといけない」みたいな場面でよく使います。

### `git rebase` — 履歴を整える

ブランチの履歴を別の場所に **付け替え** て、commit の流れをきれいにします。`git merge` と似ていますが、結果の見え方が違います。

```bash
git switch your-branch
git rebase main
```

> :::message
> rebase は便利ですが「履歴を書き換える」性質があるので、**push 済みのブランチには使わない** のが鉄則です。チーム開発で使うときは事前にルールを確認してください。
> :::

### `git tag` — バージョンに名前をつける

リリースバージョンなどに名前をつけて、特定の commit を呼び出しやすくします。

```bash
git tag v1.0.0
git push origin v1.0.0
```

「`v1.0.0` の状態に戻したい」が一発でできます。

### `git revert` — commit を打ち消す

過去の commit を **打ち消す commit を新しく作る** ことで、過去を変えずに変更を取り消せます。マージ済みの変更を取り消すときの安全策です。

```bash
git revert <commit-hash>
```

### `.gitignore` — Git に追跡させないファイルを指定

`node_modules/` のような巨大な依存ファイル群や、`.env` のような秘密情報は Git に含めるべきではありません。`.gitignore` ファイルにパターンを書いておくと無視されます。

```
# .gitignore の例
node_modules/
.env
*.log
.DS_Store
```

## マージのスタイル(復習)

第 9 章で「Create a merge commit」を使いましたが、GitHub には他の選択肢もあります。

| 方式 | 特徴 |
|---|---|
| **Create a merge commit** | マージ専用の commit を作って合流。今日使ったやり方 |
| **Squash and merge** | ブランチの commit 群を **1 つにまとめて** 合流。履歴がスッキリ |
| **Rebase and merge** | ブランチの commit を **そのまま並べて** 合流。中間の commit が残る |

実務では「`main` の履歴をきれいにしたい」という理由で **Squash and merge** を採用するチームが多いです。

## 認証方式(復習)

第 3 章では `gh auth login` を使いました。他にも認証方式があります。

### SSH 鍵

公開鍵暗号を使った認証方式。

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
cat ~/.ssh/id_ed25519.pub
# 表示された公開鍵を GitHub の Settings > SSH and GPG keys に登録
```

利点: パスワードを聞かれない、強い認証
注意: 秘密鍵 (`~/.ssh/id_ed25519`) は **絶対に他人に渡さない**

### Personal Access Token (PAT)

GitHub のパスワードの代わりにトークンを使う方式。`gh auth login` の裏で実は PAT が発行されています。手動で発行する場合は GitHub の **Settings → Developer settings → Personal access tokens** から。

## チーム開発で出てくる用語

実務に出ると以下の用語をよく聞きます。今日はやらないので名前だけ。

| 用語 | 一行説明 |
|---|---|
| **fork** | 他人のリポジトリを自分の GitHub にコピーすること。OSS 貢献の起点 |
| **upstream** | fork 元のリポジトリ |
| **CI/CD** | PR を出すと自動でテストが走り、main にマージされると自動でデプロイされる仕組み |
| **GitHub Actions** | GitHub 標準の CI/CD ツール |
| **Code Owner** | 特定のディレクトリの変更には自動でレビュアーを割り当てる仕組み |
| **Draft PR** | まだレビュー依頼前の下書き状態の PR |

## おすすめの学習リソース

### 書籍・サイト

- [Pro Git](https://git-scm.com/book/ja/v2)(公式の教科書、無料)
- [サル先生の Git 入門](https://backlog.com/ja/git-tutorial/)(図が豊富で読みやすい)
- [Learn Git Branching](https://learngitbranching.js.org/?locale=ja)(ブラウザでブランチ操作を体験)

### コマンド集

- `git help <コマンド>` で詳細マニュアルが開けます

```bash
git help commit
git help branch
```

## 最後に

今日体験したのは Git/GitHub の **氷山の一角** ですが、ここまでができれば「個人開発のプロジェクトを GitHub で管理する」「OSS の Issue を見て小さい修正 PR を出す」といったことは十分始められます。

> :::message
> 一番のおすすめは、**自分の好きなプロジェクト(学校の課題、個人の Web サイト、習作のゲームなど何でも)を GitHub に置いてみる** ことです。今日学んだ操作を「自分のもののために使う」と一気に身につきます。
> :::

このリポジトリ自体も、いつでも見返せるように残してあります。「あれどうやるんだっけ?」と思ったら、戻ってきて該当章を読み直してください。

楽しい Git ライフを!
