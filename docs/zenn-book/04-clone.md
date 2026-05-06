---
title: "リポジトリを clone する"
free: true
---

## この章のゴール

- リポジトリを自分の PC に clone できる
- ターミナルで clone したフォルダに移動できる
- 中身を確認できる

## clone って何?

GitHub 上にあるリポジトリを、**履歴ごとそのまま自分の PC にコピー**してくる操作のことです。

```
GitHub (リモート) ──→ clone ──→ あなたの PC (ローカル)
```

clone した後、あなたの PC のフォルダはただのフォルダではなく、**Git で管理された立派なリポジトリ** になります。

## ステップ 1: 作業用フォルダに移動

clone するとカレントディレクトリ(今いるフォルダ)の下にリポジトリのフォルダが作られます。**散らからない場所**に移動してから clone するのがコツです。

おすすめは「ホームディレクトリ直下に作業用フォルダを作る」方法です。

```bash
cd ~
```

```bash
mkdir -p workspace
```

```bash
cd workspace
```

> :::message
> なぜホーム直下か? Windows のデスクトップに置くと、フォルダ名が日本語の場合に Git Bash で文字化けすることがあります。半角英数字のフォルダの中で作業するのが安全です。
> :::

## ステップ 2: clone する

リポジトリを clone するコマンドはこれです。

```bash
gh repo clone Webu-Kobedenshi/git-hands-on-introductions
```

実行すると、インターネットからダウンロードが始まります。

```
Cloning into 'git-hands-on-introductions'...
remote: Enumerating objects: ...
Receiving objects: 100% ...
```

> :::message
> `gh repo clone` は内部で `git clone` を実行します。違いは、`gh` が自動で認証情報を渡してくれる点です。`git clone https://github.com/Webu-Kobedenshi/git-hands-on-introductions.git` でも同じことができます。
> :::

## ステップ 3: clone したフォルダに移動

```bash
cd git-hands-on-introductions
```

これ以降の章のコマンドは、すべてこのフォルダの中で実行します。**もしターミナルを閉じてしまったら、開き直したあとにここに `cd` で戻ってきてください**。

## ステップ 4: 中身を確認

```bash
ls
```

こんな出力になるはずです。

```
README.md  scripts  self-introductions  templates
```

`.github` などの隠しフォルダも見たい場合は `-a` をつけます。

```bash
ls -a
```

```
.  ..  .git  .github  .gitignore  README.md  scripts  self-introductions  templates
```

`.git` フォルダがあれば、ここが Git で管理されたリポジトリだという証拠です。

## ステップ 5: 状態確認

最後に、Git の状態を確認するおまじないを実行しておきましょう。

```bash
git status
```

```
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

「`main` ブランチにいて、リモートと同期済みで、変更ファイルはなし」という意味です。clone 直後はいつもこの状態になります。

> :::message
> `git status` は **これから何度も使います**。「今どうなっているんだっけ?」と思ったら反射的に打つクセをつけてください。
> :::

## ありがちなつまずき

### Q. `Permission denied` と出た

`gh auth login` がうまくいっていない可能性があります。前の章に戻って `gh auth status` で認証状態を確認してください。

### Q. `repository not found` と出た

リポジトリ名のスペルが間違っているかもしれません。正しくは:

```
Webu-Kobedenshi/git-hands-on-introductions
```

`Webu` の `u` を忘れたり、ハイフンを消したりしがちです。

### Q. clone はできたが `cd` でフォルダに入れない

タイプミスかもしれません。Tab キーを使って補完すると確実です。

```bash
cd git-hands-<Tab キー>
```

## まとめ

- `gh repo clone <owner>/<repo>` でリポジトリを PC にコピー
- `cd <フォルダ>` で中に入る
- `ls` で中身を、`git status` で Git の状態を確認

次の章では、自分にアサインされた **Issue** を確認します。
