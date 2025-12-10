# Digital Bazaar — Makefile
# Simplifies common development tasks

.PHONY: help install update build serve clean fonts prod-build serve-drafts images images-webp setup-hooks

# Homebrew Ruby paths (macOS)
RUBY_BIN := /opt/homebrew/opt/ruby/bin
GEM_BIN := /opt/homebrew/lib/ruby/gems/3.4.0/bin
BUNDLE := PATH="$(RUBY_BIN):$(GEM_BIN):$$PATH" bundle

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
	$(BUNDLE) install

update: ## Update all gem dependencies to latest versions
	$(BUNDLE) update

build: ## Build the static site (output to _site/)
	$(BUNDLE) exec jekyll build

serve: ## Start local development server at http://localhost:4000
	$(BUNDLE) exec jekyll serve --livereload

serve-drafts: ## Start server with draft posts visible
	$(BUNDLE) exec jekyll serve --livereload --drafts

clean: ## Remove generated site and caches
	$(BUNDLE) exec jekyll clean
	rm -rf _site .jekyll-cache .jekyll-metadata

prod-build: ## Build for production (minified, no drafts)
	JEKYLL_ENV=production $(BUNDLE) exec jekyll build

fonts: ## Download self-hosted fonts (DM Sans + Tajawal)
	@chmod +x scripts/download-fonts.sh
	@./scripts/download-fonts.sh

images: ## Optimize images (creates web-ready PNG/JPG copies)
	@echo "Optimizing images..."
	@cd assets/img && \
	sips -z 128 128 digital_bazaar_2025.jpg --out logo-128.jpg 2>/dev/null && \
	sips -z 256 256 digital_bazaar_2025.jpg --out logo-256.jpg 2>/dev/null && \
	sips -z 512 512 digital_bazaar_2025.jpg --out logo-512.jpg 2>/dev/null && \
	sips -z 16 16 digital_bazaar_2025.png --out favicon-16.png 2>/dev/null && \
	sips -z 32 32 digital_bazaar_2025.png --out favicon-32.png 2>/dev/null && \
	sips -z 180 180 digital_bazaar_2025.png --out apple-touch-icon.png 2>/dev/null && \
	sips -z 192 192 digital_bazaar_2025.png --out icon-192.png 2>/dev/null
	@echo "✓ Optimized images created in assets/img/"

images-webp: ## Convert images to WebP (requires: brew install webp)
	@echo "Converting to WebP..."
	@cd assets/img && \
	cwebp -q 80 logo-128.jpg -o logo-128.webp 2>/dev/null && \
	cwebp -q 80 logo-256.jpg -o logo-256.webp 2>/dev/null && \
	cwebp -q 90 logo-512.jpg -o logo-512-hq.webp 2>/dev/null && \
	echo "✓ WebP images created:" && \
	ls -lh logo-*.webp

setup-hooks: ## Enable git pre-commit hooks
	@echo "Setting up git hooks..."
	@git config core.hooksPath .githooks
	@echo "✓ Git hooks enabled. Pre-commit will run: images, images-webp, prod-build"
