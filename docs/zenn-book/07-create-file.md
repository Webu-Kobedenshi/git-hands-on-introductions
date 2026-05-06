---
title: "自己紹介ファイルを作って commit する"
free: true
---

## この章のゴール

- テンプレートをコピーして自分用のファイルを作れる
- 編集した変更を `git add` でステージできる
- `git commit` で履歴に確定できる

## ステップ 1: テンプレートをコピー

リポジトリの `templates/self-introduction.md` をひな形として使います。これを自分のチームのディレクトリにコピーしましょう。

書式は次の通りです。

```bash
cp templates/self-introduction.md self-introductions/team<番号>/<github-id>.md
```

例えば、チーム 2 の `octocat` さんの場合:

```bash
cp templates/self-introduction.md self-introductions/team2/octocat.md
```

> :::message
> `cp` は **copy** の略で、ファイルをコピーするコマンドです。Windows の方も Git Bash でこのコマンドが使えます。
> :::

## ステップ 2: 状態を確認

```bash
git status
```

こう表示されているはずです。

```
On branch add-self-introduction-octocat
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        self-introductions/team2/octocat.md

nothing added to commit but untracked files present
```

`Untracked files` に作ったファイルが出ています。「Git は新しいファイルがあることを認識したけど、まだ追跡対象にしていない」という状態です。

## ステップ 3: ファイルを編集

エディタ(VS Code など)で作ったファイルを開いて、中身を埋めましょう。

VS Code を使っているなら:

```bash
code self-introductions/team2/octocat.md
```

エディタが開かない場合は、エクスプローラ/Finder からそのファイルを開いて編集しても OK です。

テンプレに書かれている `<あなたの名前をここに>` などのプレースホルダを実際の内容に置き換え、各セクションを埋めてください。1〜2 行の内容で構いません。

> :::message
> 内容に困ったら、好きな食べ物・最近見たアニメ・触ってみたい言語、何でも構いません。後で他のメンバーが読むので、人柄が伝わると喜ばれます。
> :::

編集が終わったら保存してください。

## ステップ 4: 変更を確認

編集後、もう一度状態を確認します。

```bash
git status
```

ファイル名は `Untracked files` のままですが、エディタで保存したことが Git に伝わっています。中身の差分を見るには:

```bash
git diff self-introductions/team2/octocat.md
```

…と言いたいところですが、**新規ファイルは `git diff` には出てきません**。`git diff` は既存ファイルの差分用です。新規ファイルは中身を見たければ普通に `cat` で確認します。

```bash
cat self-introductions/team2/octocat.md
```

## ステップ 5: ステージする (`git add`)

ファイルを「次の commit に含める」とマークします。これがステージングです。

```bash
git add self-introductions/team2/octocat.md
```

確認しましょう。

```bash
git status
```

```
On branch add-self-introduction-octocat
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   self-introductions/team2/octocat.md
```

`Changes to be committed` のところにファイルが移動したら成功です。

> :::message
> なぜ `git add` が必要か? 「変更したけど、まだ commit したくない実験的なファイル」を除外できるようにするためです。`git add` で **明示的に commit に入れる変更** を選ぶ仕組みになっています。
> :::

## ステップ 6: コミットする (`git commit`)

ステージした変更を履歴に確定します。

```bash
git commit -m "自己紹介ファイルを追加"
```

成功すると:

```
[add-self-introduction-octocat 1a2b3c4] 自己紹介ファイルを追加
 1 file changed, 20 insertions(+)
 create mode 100644 self-introductions/team2/octocat.md
```

> :::message
> `-m` は message の m。コミットメッセージを直接コマンドラインで渡すオプションです。`-m` をつけずに `git commit` を実行するとエディタが開いてメッセージ入力を求められますが、慣れないうちは `-m` で十分です。
> :::

### コミットメッセージの書き方(目安)

| OK 例 | NG 例 |
|---|---|
| `自己紹介ファイルを追加` | `update`(何を?) |
| `octocat の自己紹介を追加` | `aaa`(意味不明) |
| `Add self-introduction for octocat`(英語派) | `修正`(何を?) |

「何を変更したか」が一目で分かるメッセージを心がけましょう。

## ステップ 7: 履歴を確認

`git log` で commit が記録されたか確認します。

```bash
git log --oneline
```

```
1a2b3c4 (HEAD -> add-self-introduction-octocat) 自己紹介ファイルを追加
abcdef0 (origin/main, main) Initial commit
```

一番上にあなたの commit が見えれば成功です。`git log` を抜けるには **q キー** を押します(エディタ的な画面が出ている場合)。

## ありがちなつまずき

### Q. 別のファイルもステージされた

`git add .` のようにドット付きで実行すると、変更されたすべてのファイルがステージされます。今日は **ファイル名を明示的に指定** するのがおすすめです。間違えてステージした場合は:

```bash
git restore --staged <ファイル名>
```

で外せます。

### Q. コミットメッセージを間違えた

直前の commit のメッセージなら直せます。

```bash
git commit --amend -m "新しいメッセージ"
```

push 後に変えるとちょっと面倒なので、push 前に気付ければラッキーです。

### Q. 編集した内容を全部やり直したい(コピー直後の状態に戻したい)

```bash
git restore self-introductions/team2/octocat.md
```

> :::message
> :warning: `git restore` は **保存していない作業を消します**。実行前に「本当に消していいか」を確認してください。
> :::

## まとめ

- `cp templates/... self-introductions/team<番号>/<github-id>.md`
- エディタで編集
- `git add <ファイル>` でステージ
- `git commit -m "メッセージ"` で確定
- `git log --oneline` で確認

次の章では、ローカルの commit を **GitHub にアップロード**(push)し、**Pull Request** を作ります。
