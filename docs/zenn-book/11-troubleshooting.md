---
title: "【参考】よく出るエラーと対処"
free: true
---

> :::message
> この章は **辞書として使ってください**。当日詰まったらここをのぞいて、自分のエラーに近いものを探すと早く解決できます。
> :::

## 環境・認証まわり

### Q. `gh: command not found`

GitHub CLI がインストールされていません。前提環境のインストール手順に戻ってください。

- macOS: `brew install gh`
- Windows: <https://github.com/cli/cli/releases> から `.msi` をダウンロード(または `winget install --id GitHub.cli`)
- Linux: <https://github.com/cli/cli/blob/trunk/docs/install_linux.md> 参照

### Q. `git: command not found`

Git がインストールされていません。

- macOS: `brew install git` または `xcode-select --install`
- Windows: <https://gitforwindows.org/> からインストール(Git Bash も同梱されます)
- Linux: `sudo apt install git` など

### Q. `gh auth login` でブラウザが開かない

ターミナルに表示された URL をコピーして、自分でブラウザのアドレスバーに貼り付けてください。8 桁のコードを入力する画面に飛びます。

### Q. `Authentication failed`

8 桁コードの有効期限が切れています(30 分)。もう一度 `gh auth login` をやり直してください。

### Q. 別のアカウントでログイン中だった

```bash
gh auth logout
gh auth login
```

の順で実行してログインし直してください。

## clone まわり

### Q. `Permission denied`

`gh auth status` で認証されているか確認してください。されていなければ `gh auth login`。

### Q. `repository not found`

リポジトリ名のスペルを確認してください。正しくは:

```
Webu-Kobedenshi/git-hands-on-introductions
```

### Q. clone したフォルダがどこにあるか分からない

```bash
pwd
```

で今の場所を表示できます。clone は **コマンドを実行したフォルダの直下** にできます。`cd ~/workspace` してから clone する、と決めておくと迷いません。

## ブランチまわり

### Q. `fatal: A branch named '...' already exists`

すでに同じ名前のブランチがあります。

```bash
git branch
```

で確認して、既にあれば作らずに `git switch <名前>` で移ってください。

### Q. 間違ったブランチで作業を始めてしまった

まだ commit していなければ、変更を持ったまま正しいブランチに移動できる場合があります。

```bash
git switch -c add-self-introduction-<github-id>
```

すでに main で commit してしまった場合は、TA に相談してください(`git reset` などで取り戻せます)。

## ファイル・コミットまわり

### Q. ファイルを間違って消してしまった

commit 前なら復活できます。

```bash
git restore <ファイル名>
```

### Q. ステージしたものを取り消したい(commit はまだ)

```bash
git restore --staged <ファイル名>
```

### Q. 直前の commit のメッセージを書き直したい

push する前なら直せます。

```bash
git commit --amend -m "新しいメッセージ"
```

### Q. `nothing to commit, working tree clean` と出た

変更がない、またはステージしていない状態です。

- ファイルを編集して保存しましたか?
- `git add <ファイル>` を実行しましたか?
- ファイルパスが正しいですか?

`git status` で状況を確認しましょう。

## push・PR まわり

### Q. `Updates were rejected because the remote contains work`

リモートに自分の知らない変更があるパターンです。今日はこの状況になりにくいですが、もしなったら `git pull` してから `git push` を試してください。

### Q. `gh pr create` で `must be on a branch named differently than "main"`

`main` ブランチで PR を作ろうとしています。

```bash
git branch
```

で `*` がついているブランチを確認。`main` についていたら、自分の作業ブランチに移ってください。

```bash
git switch add-self-introduction-<github-id>
```

### Q. push できたけど PR が作れない

push 直後に表示される URL から Web 上で「Compare & pull request」ボタンを押す方法もあります。`gh pr create` がうまく動かないときの保険として覚えておくと便利です。

## エディタ(Vim)まわり

### Q. 知らないうちに Vim が起動して抜け方が分からない

`gh pr create` の本文入力などで Vim に飛んでしまうことがあります。

1. **`Esc` キー** を押す
2. **`:q!`** とタイプして Enter(変更を破棄して終了)

または **`:wq`** で保存して終了。

> :::message
> 別のエディタにしたければ:
> ```bash
> git config --global core.editor "code --wait"   # VS Code を使う場合
> ```
> :::

## マージまわり

### Q. Merge ボタンが押せない・グレーアウト

考えられる原因:

- コンフリクトしている → 10 章を参照
- ブランチ保護がかかっている → TA に相談
- レビュアーの承認待ちになっている → 今日の研修ではこの設定は無いはず

### Q. マージしたあとに気付いた間違いを直したい

まずは新しいブランチを切って修正することを検討してください。

```bash
git switch main
git pull
git switch -c fix-self-introduction-<github-id>
# 修正・add・commit・push・PR・merge
```

`git revert` で打ち消し commit を作る方法もあります(12 章参照)。

## 困ったときの最終手段

どうにもならないときの **やり直しコマンド** をいくつか紹介します。**実行前に必ず TA に相談** してください(間違えると作業が消えます)。

### ローカルブランチを完全に作り直す

```bash
git switch main
git branch -D add-self-introduction-<github-id>
git switch -c add-self-introduction-<github-id>
```

### 全部捨てて clone からやり直す

```bash
cd ~/workspace
rm -rf git-hands-on-introductions
gh repo clone Webu-Kobedenshi/git-hands-on-introductions
cd git-hands-on-introductions
```

> :::message
> :warning: `rm -rf` は **強制削除コマンド** です。ディレクトリを間違えると取り返しがつかないので、コピペするなら `cd` 先を必ず確認してください。
> :::

## まとめ

エラーは初心者の通る道です。**エラーメッセージを読む癖** がつくと、初見のエラーでも対応できるようになります。

- 困ったら **`git status`** で状況確認
- それでも分からなければ TA に声をかける
- 余裕があれば、エラーメッセージで Web 検索する習慣を

次の章では、今日扱わなかった次の学習トピックを紹介します。
