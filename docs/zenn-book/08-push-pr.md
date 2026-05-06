---
title: "push して Pull Request を出す"
free: true
---

## この章のゴール

- ローカルの commit を GitHub に **push** できる
- ターミナルから **Pull Request (PR)** を作成できる
- GitHub の Web 上で自分の PR を確認できる

## push って何?

push は「**ローカルリポジトリの履歴を、リモートリポジトリにアップロード**」する操作です。

```
あなたの PC (ローカル) ──→ push ──→ GitHub (リモート)
```

ここまでで作った commit はあなたの PC の中だけにあり、まだ GitHub には届いていません。push して初めて他の人にも見えるようになります。

## ステップ 1: 初回 push

新しいブランチの初回 push は、ちょっとだけ書き方が違います。

```bash
git push -u origin add-self-introduction-<あなたの github-id>
```

例:

```bash
git push -u origin add-self-introduction-octocat
```

成功するとこんな表示になります。

```
Enumerating objects: 5, done.
...
remote: Create a pull request for 'add-self-introduction-octocat' on GitHub by visiting:
remote:      https://github.com/Webu-Kobedenshi/git-hands-on-introductions/pull/new/add-self-introduction-octocat
To github.com:Webu-Kobedenshi/git-hands-on-introductions.git
 * [new branch]      add-self-introduction-octocat -> add-self-introduction-octocat
branch 'add-self-introduction-octocat' set up to track 'origin/add-self-introduction-octocat'.
```

### コマンドの意味

| 部分 | 意味 |
|---|---|
| `git push` | 履歴をリモートに送る |
| `-u` | upstream の u。「このローカルブランチがどのリモートブランチに対応するか」を覚える |
| `origin` | リモートのデフォルト名(GitHub のリポジトリを指す) |
| `add-self-introduction-octocat` | push したいブランチの名前 |

> :::message
> なぜ `-u` をつけるのか? 一度つけておくと、次回以降は `git push` だけでこのブランチを push できるようになるからです。`-u` なしでも push はできますが、毎回ブランチ名を書く必要があります。**初回だけ `-u`** と覚えてください。
> :::

## ステップ 2: PR を作成する

push できたら、次はその変更を `main` に取り込んでもらう **依頼書(PR)** を出します。

```bash
gh pr create
```

対話式で質問されます。

| 質問 | どう答えるか |
|---|---|
| `Where should we push the branch?` | (出てこない場合もあります。出たら現在のリポジトリを選ぶ) |
| `Title for your pull request` | 例: `自己紹介を追加 (octocat)` |
| `Body` | 例: `team2 に自己紹介ファイルを追加しました` (空でも OK) |
| `What's next?` | **Submit** を選ぶ |

> :::message
> `Body` の記入で **エディタが起動** することがあります。エディタが Vim だった場合は、`i` キーで挿入モードに入って文字を打ち、`Esc` → `:wq` で保存して閉じます。難しければエディタの外で先に文章を考えて、貼り付けるとスムーズです。
> :::

成功すると、作成された PR の URL が表示されます。

```
https://github.com/Webu-Kobedenshi/git-hands-on-introductions/pull/15
```

## ステップ 3: ブラウザで PR を確認

`gh pr view --web` でブラウザで開けます。

```bash
gh pr view --web
```

ブラウザに切り替わって、自分の PR が表示されます。確認してほしいポイント:

- ✅ タイトルが書かれている
- ✅ **Files changed** タブをクリックすると、追加した自己紹介ファイルの差分が見える
- ✅ 差分の右上の **... (3点メニュー)** から **View file** を選ぶと、Markdown のプレビューで自己紹介を読める

> :::message
> Markdown ファイルは GitHub 上で **見出しがちゃんと大きく表示される、リストが箇条書きになる** といった具合に整形されて見えます。差分タブだと文字列としてしか見えませんが、プレビューに切り替えるとぐっと読みやすくなります。
> :::

## ステップ 4: Issue とリンクさせる(任意・小ワザ)

PR の本文に `Closes #<Issue 番号>` と書いておくと、PR がマージされたときに対応する Issue が自動で閉じます。今日はやらなくても良いですが、知っていると便利です。

例: PR の本文に

```
Closes #5
```

と書いておくと、マージ時に Issue #5 が自動で閉じます。

## ありがちなつまずき

### Q. `Updates were rejected because the remote contains work` と出た

ブランチ名が他の人とぶつかっている可能性があります。ブランチ名に **必ず自分の GitHub ID** を入れているか確認してください。

### Q. `gh pr create` でエラー: `must be on a branch named differently than "main"`

`main` ブランチで PR を作ろうとしています。前の章の `git switch -c` で作業ブランチを作ってから戻ってきてください。

```bash
git branch
```

で `*` がブランチについているか確認しましょう。

### Q. 認証エラーが出る

`gh auth status` で認証状態を確認してください。再ログインが必要なら:

```bash
gh auth login
```

## まとめ

- `git push -u origin <ブランチ名>` で初回 push(以降は `git push` だけで OK)
- `gh pr create` で Pull Request を作成
- `gh pr view --web` で PR をブラウザで確認

次の章では、**他のメンバーの PR にコメントを残し**、最後に **自分の PR をマージ** します。
