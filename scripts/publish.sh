#!/bin/sh
set -eu

cd "$(dirname "$0")/.."
repo_root=$(pwd -P)

if [ -n "$(git status --porcelain)" ]; then
	printf '%s\n' '変更をコミットしてから make publish を実行してください。' >&2
	exit 1
fi

command -v rsync >/dev/null 2>&1 || {
	printf '%s\n' '公開には rsync が必要です。' >&2
	exit 1
}

source_commit=$(git rev-parse --short HEAD)
git fetch origin refs/heads/gh-pages:refs/remotes/origin/gh-pages

publish_dir=$(mktemp -d "$repo_root/.cache/gh-pages.XXXXXX")
worktree_created=false
cleanup() {
	if [ "$worktree_created" = true ]; then
		git worktree remove --force "$publish_dir"
	else
		rmdir "$publish_dir"
	fi
}
trap cleanup 0
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

git worktree add --detach "$publish_dir" refs/remotes/origin/gh-pages
worktree_created=true

rsync -a --delete --exclude='.git' "$repo_root/.cache/site/" "$publish_dir/"
touch "$publish_dir/.nojekyll"
git -C "$publish_dir" add --all

if git -C "$publish_dir" diff --cached --quiet; then
	printf '%s\n' '公開内容に変更はありません。'
	exit 0
fi

git -C "$publish_dir" commit -m "Publish Hugo build from $source_commit"
git -C "$publish_dir" push origin HEAD:refs/heads/gh-pages
printf '%s\n' 'gh-pages へ反映しました。GitHub Pages の公開処理が自動で開始されます。'
