# 東京ラビットハウス

Hugoで生成する静的サイトです。共通レイアウトと記事本文の装飾は `assets/css/site.css` にまとめています。CSSフレームワーク、アイコンフォント、Node.js/npmは使用しません。

## 開発

Hugo **0.167.0** を使用します。バージョンは `.hugo-version` で固定し、`hugo.toml` でも必要なバージョンを指定しています。

macOSではHomebrewでインストールできます。

```sh
brew install hugo
hugo version
make preview
```

プレビューは <http://localhost:1313/> です。別の場所にあるHugoを使う場合は `make preview HUGO=/path/to/hugo` と指定できます。

## ビルド

```sh
make build
```

生成先は `.cache/site/` です。CSSはHugoで圧縮し、ファイル名にハッシュを付けて配信します。既存の公開用 `public` Gitリンクには書き込みません。

`static/CNAME` と各PDF・ZIPも生成先へコピーされます。`make build` 自体は公開やGitへのpushを行いません。

## 公開

ソースの変更をコミットしてから、次のコマンドを実行してください。

```sh
make publish
```

ビルド後、`origin/gh-pages` の一時的な作業コピーへ生成物をコピーし、コミット・pushします。古い生成物は削除し、GitHub Pages用の `.nojekyll` を追加します。公開内容に差分がなければコミット・pushは行いません。作業コピーは終了時に削除します。

`origin` へのpush権限と `rsync` が必要です。push後はGitHub Pagesが自動で公開します。

## 編集箇所

- サイト設定・ナビゲーション: `hugo.toml`
- 共通HTML: `layouts/baseof.html` と `layouts/_partials/`
- ホーム・一覧・記事: `layouts/home.html`、`layouts/list.html`、`layouts/page.html`
- 共通CSS: `assets/css/site.css`
- 記事: `content/`
- 画像・配布ファイル: `static/`

記事本文は `.article` 配下のCSSで整えています。Markdown内の生HTMLは、元の設定と同様に無効です。
