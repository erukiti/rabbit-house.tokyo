HUGO ?= $(if $(wildcard .cache/hugo/hugo),.cache/hugo/hugo,hugo)

.PHONY: check-hugo build preview publish

check-hugo:
	@command -v "$(HUGO)" >/dev/null 2>&1 || { printf '%s\n' 'Hugoをインストールしてください。手順はREADME.mdをご覧ください。'; exit 1; }
	@required_version=$$(cat .hugo-version); \
	actual_version=$$("$(HUGO)" version | awk '{sub(/^v/, "", $$2); sub(/[+-].*/, "", $$2); print $$2}'); \
	if [ "$$actual_version" != "$$required_version" ]; then \
		printf 'Hugo %sが必要です（現在: %s）。\n' "$$required_version" "$$actual_version"; exit 1; \
	fi

build: check-hugo
	"$(HUGO)" --gc --minify --panicOnWarning --cleanDestinationDir

preview: check-hugo
	"$(HUGO)" server --disableFastRender --bind 127.0.0.1 --destination .cache/preview --cleanDestinationDir

publish: build
	sh scripts/publish.sh
