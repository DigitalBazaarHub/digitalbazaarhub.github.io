# Digital Bazaar — Makefile
# Simplifies common development tasks

.PHONY: help install update build serve clean fonts

# Default Ruby path (Homebrew on macOS)
RUBY_PATH := /opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.4.0/bin
SHELL := /bin/bash
export PATH := $(RUBY_PATH):$(PATH)

# Colors for help output
CYAN := \033[36m
RESET := \033[0m

help: ## Show this help message
	@echo "Digital Bazaar — Development Commands"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(CYAN)%-15s$(RESET) %s\n", $$1, $$2}'
	@echo ""

install: ## Install Ruby gem dependencies
	bundle install

update: ## Update all gem dependencies to latest versions
	bundle update

build: ## Build the static site (output to _site/)
	bundle exec jekyll build

serve: ## Start local development server at http://localhost:4000
	bundle exec jekyll serve --livereload

serve-drafts: ## Start server with draft posts visible
	bundle exec jekyll serve --livereload --drafts

clean: ## Remove generated site and caches
	bundle exec jekyll clean
	rm -rf _site .jekyll-cache .jekyll-metadata

prod-build: ## Build for production (minified, no drafts)
	JEKYLL_ENV=production bundle exec jekyll build

fonts: ## Download self-hosted fonts (DM Sans + Tajawal)
	@chmod +x scripts/download-fonts.sh
	@./scripts/download-fonts.sh
