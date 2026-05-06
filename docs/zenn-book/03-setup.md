---
title: "環境準備 — GitHub に認証する"
free: true
---

## この章のゴール

- `gh auth login` で GitHub に認証できる
- `git config` で自分の名前とメールアドレスを設定できる
- 認証状態を確認できる

## なぜ認証が必要か

GitHub は、不特定多数の人がリポジトリを書き換えられたら困るので、操作する人が誰なのかを認証する仕組みになっています。今日はあなたのアカウント(`@<github-id>`)で「私はあなたです」と GitHub に証明する設定をします。

認証方法は主に 3 つあります。

| 方法 | 難易度 | 当日採用 |
|---|---|---|
| **GitHub CLI (`gh auth login`)** | ★ | ✅ こちらを使います |
| Personal Access Token (PAT) | ★★ | 紹介のみ |
| SSH 鍵 | ★★★ | 12 章で参考紹介 |

> :::message
> なぜ `gh auth login` か? 一番ステップが少なく、ブラウザで認証ボタンを押すだけで完了するためです。裏では PAT が発行されてあなたの PC に保存されますが、その手順を `gh` が自動でやってくれる、というイメージです。
> :::

## ステップ 1: ターミナルを開く

- **Windows**: スタートメニューから **Git Bash** を起動
- **macOS**: ターミナル.app を起動
- **Linux**: お使いのターミナルを起動

## ステップ 2: gh auth login を実行

```bash
gh auth login
```

対話形式で質問されるので、矢印キーで以下のように選択して Enter してください。

| 質問 | 選ぶもの |
|---|---|
| `What account do you want to log into?` | **GitHub.com** |
| `What is your preferred protocol for Git operations?` | **HTTPS** |
| `Authenticate Git with your GitHub credentials?` | **Yes** |
| `How would you like to authenticate GitHub CLI?` | **Login with a web browser** |

選び終えると、画面に **8 桁のコード** と URL が表示されます。

```
! First copy your one-time code: ABCD-1234
Press Enter to open github.com in your browser...
```

コードを **メモかコピー** してから Enter を押してください。ブラウザが開きます。

## ステップ 3: ブラウザで認証

ブラウザで:

1. 表示された 8 桁コードを入力
2. GitHub にログイン(まだなら)
3. **Authorize** ボタンを押す

ターミナルに戻ると、こう表示されているはずです。

```
✓ Authentication complete.
✓ Logged in as <あなたの github-id>
```

これで認証完了です。

## ステップ 4: Git の名前・メールアドレス設定

コミットには「誰がやったか」が記録されます。これを設定しましょう。Git Bash かターミナルで実行します。

```bash
git config --global user.name "あなたの名前"
```

```bash
git config --global user.email "あなたのメールアドレス"
```

例:

```bash
git config --global user.name "Octocat"
git config --global user.email "octocat@example.com"
```

> :::message
> メールアドレスは GitHub に登録したものと **同じもの** を推奨します。違っていてもエラーにはなりませんが、GitHub 上であなたのアバターと commit が紐付かなくなります。
> :::

## 確認しよう

設定がちゃんと反映されているか確認します。

```bash
gh auth status
```

```bash
git config --global user.name
```

```bash
git config --global user.email
```

それぞれ、ログイン状態と設定した名前・メールが表示されれば OK です。

## ありがちなつまずき

### Q. `gh: command not found` と出る

GitHub CLI がインストールされていません。前の章「前提環境」を確認して、インストールしてから戻ってきてください。

### Q. 既に別アカウントでログイン済みだった

```bash
gh auth logout
```

を先に実行してから、もう一度 `gh auth login` してください。

### Q. ブラウザが開かない

`gh auth login` のときに表示された URL を、自分でブラウザのアドレスバーにコピペしてください。8 桁コードを入力する画面に飛びます。

### Q. 「`Authentication failed`」と出る

8 桁のコードを **30 分以内に** 入力する必要があります。時間切れになったら、もう一度 `gh auth login` をやり直してください。

## まとめ

- `gh auth login` でブラウザ認証(おすすめ)
- `git config --global user.name` / `user.email` で名前とメールを設定
- `gh auth status` で確認

次の章では、このリポジトリを自分の PC に **clone**(ダウンロード)します。
