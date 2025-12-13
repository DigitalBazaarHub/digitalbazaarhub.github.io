# Digital Bazaar — Makefile
# Simplifies common development tasks

.PHONY: help install update assets images images-hero clean serve serve-drafts build setup-hooks prod-build

# Homebrew Ruby paths (macOS)
RUBY_BIN := /opt/homebrew/opt/ruby/bin
GEM_BIN := /opt/homebrew/lib/ruby/gems/3.4.0/bin
BUNDLE := PATH="$(RUBY_BIN):$(GEM_BIN):$$PATH" bundle

# Colors for help output
CYAN := \033[36m
YELLOW := \033[33m
RESET := \033[0m

# =============================================================================
# HELP
# =============================================================================

help: ## Show this help message
	@echo "Digital Bazaar — Development Commands"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "$(YELLOW)Setup:$(RESET)"
	@echo "  $(CYAN)install$(RESET)        Install Ruby gem dependencies"
	@echo "  $(CYAN)update$(RESET)         Update all gem dependencies"
	@echo "  $(CYAN)assets$(RESET)         Download fonts + mermaid.js"
	@echo "  $(CYAN)images$(RESET)         Generate logos, favicons, icons"
	@echo "  $(CYAN)images-hero$(RESET)    Show hero banner generation guide"
	@echo "  $(CYAN)clean$(RESET)          Remove generated site and caches"
	@echo ""
	@echo "$(YELLOW)Development:$(RESET)"
	@echo "  $(CYAN)serve$(RESET)          Start dev server (localhost:4000)"
	@echo "  $(CYAN)serve-drafts$(RESET)   Start server with drafts visible"
	@echo "  $(CYAN)build$(RESET)          Build static site to _site/"
	@echo "  $(CYAN)setup-hooks$(RESET)    Enable git pre-commit hooks"
	@echo ""
	@echo "$(YELLOW)Production:$(RESET)"
	@echo "  $(CYAN)prod-build$(RESET)     Build for production (minified)"
	@echo ""

# =============================================================================
# SETUP
# =============================================================================

install: ## Install Ruby gem dependencies
	$(BUNDLE) install

update: ## Update all gem dependencies to latest versions
	$(BUNDLE) update

assets: ## Download self-hosted assets (fonts + mermaid.js)
	@chmod +x scripts/download-assets.sh
	@./scripts/download-assets.sh

images: ## Generate all site images from gallery sources
	@echo "📷 Generating site images from assets/gallery/..."
	@echo ""
	@echo "  → Logo sizes..."
	sips -z 128 128 assets/gallery/bazaar_2025.jpg --out assets/img/logo-128.jpg
	sips -z 256 256 assets/gallery/bazaar_2025.jpg --out assets/img/logo-256.jpg
	sips -z 512 512 assets/gallery/bazaar_2025.jpg --out assets/img/logo-512.jpg
	@echo "  → Favicons and icons..."
	sips -z 16 16 assets/gallery/bazaar_2025.png --out assets/img/favicon-16.png
	sips -z 32 32 assets/gallery/bazaar_2025.png --out assets/img/favicon-32.png
	sips -z 180 180 assets/gallery/bazaar_2025.png --out assets/img/apple-touch-icon.png
	sips -z 192 192 assets/gallery/bazaar_2025.png --out assets/img/icon-192.png
	@echo "  → Converting to WebP..."
	cwebp -q 80 assets/img/logo-128.jpg -o assets/img/logo-128.webp
	cwebp -q 80 assets/img/logo-256.jpg -o assets/img/logo-256.webp
	cwebp -q 90 assets/img/logo-512.jpg -o assets/img/logo-512-hq.webp
	@echo ""
	@echo "✅ Site images generated in assets/img/"

images-hero: ## Show hero banner generation guide
	@echo "📷 Hero Banner Generator"
	@echo ""
	@echo "Run these commands to generate responsive hero images:"
	@echo ""
	@echo "  # Replace SOURCE.png with your gallery image name"
	@echo "  # Replace PREFIX with: home_hero, articles_hero, or archive_hero"
	@echo ""
	@echo "  sips -Z 1200 assets/gallery/SOURCE.png --out /tmp/hero.png"
	@echo "  cwebp -q 82 /tmp/hero.png -o assets/img/PREFIX_banner-1200.webp"
	@echo ""
	@echo "  sips -Z 800 assets/gallery/SOURCE.png --out /tmp/hero.png"
	@echo "  cwebp -q 82 /tmp/hero.png -o assets/img/PREFIX_banner-800.webp"
	@echo ""
	@echo "  sips -Z 600 assets/gallery/SOURCE.png --out /tmp/hero.png"
	@echo "  cwebp -q 82 /tmp/hero.png -o assets/img/PREFIX_banner-600.webp"
	@echo ""
	@echo "  rm /tmp/hero.png"

clean: ## Remove generated site and caches
	$(BUNDLE) exec jekyll clean
	rm -rf _site .jekyll-cache .jekyll-metadata

# =============================================================================
# DEVELOPMENT
# =============================================================================

setup-hooks: ## Enable git pre-commit hooks
	@echo "Setting up git hooks..."
	@git config core.hooksPath .githooks
	@echo "✓ Git hooks enabled"

build: ## Build the static site (output to _site/)
	$(BUNDLE) exec jekyll build

serve: ## Start local development server at http://localhost:4000
	$(BUNDLE) exec jekyll serve --livereload --watch

serve-drafts: ## Start server with draft posts visible
	$(BUNDLE) exec jekyll serve --livereload --drafts

# =============================================================================
# PRODUCTION
# =============================================================================

prod-build: ## Build for production (minified, no drafts)
	JEKYLL_ENV=production $(BUNDLE) exec jekyll build
