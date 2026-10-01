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

本番公開時は生成したファイルを `gh-pages` ブランチへ反映します。`static/CNAME` と各PDF・ZIPも生成先へコピーされます。`make build` 自体は公開やGitへのpushを行いません。

## 編集箇所

- サイト設定・ナビゲーション: `hugo.toml`
- 共通HTML: `layouts/baseof.html` と `layouts/_partials/`
- ホーム・一覧・記事: `layouts/home.html`、`layouts/list.html`、`layouts/page.html`
- 共通CSS: `assets/css/site.css`
- 記事: `content/`
- 画像・配布ファイル: `static/`

記事本文は `.article` 配下のCSSで整えています。Markdown内の生HTMLは、元の設定と同様に無効です。
