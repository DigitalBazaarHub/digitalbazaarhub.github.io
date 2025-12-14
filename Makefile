# Digital Bazaar — Makefile
# Simplifies common development tasks

.PHONY: help install update assets images hero clean serve serve-drafts build setup-hooks prod-build dev-lint dev-install-tools

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
	@echo "  $(CYAN)hero$(RESET)           Generate hero banners (make hero SRC=x OUT=y)"
	@echo "  $(CYAN)clean$(RESET)          Remove generated site and caches"
	@echo ""
	@echo "$(YELLOW)Development:$(RESET)"
	@echo "  $(CYAN)serve$(RESET)          Start dev server (localhost:4000)"
	@echo "  $(CYAN)serve-drafts$(RESET)   Start server with drafts visible"
	@echo "  $(CYAN)build$(RESET)          Build static site to _site/"
	@echo "  $(CYAN)setup-hooks$(RESET)    Enable git pre-commit hooks"
	@echo "  $(CYAN)dev-install-tools$(RESET) Install PurgeCSS for dead code detection"
	@echo "  $(CYAN)dev-lint$(RESET)       Find unused CSS (requires dev-install-tools)"
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
	@echo "  → Logo (128px for header)..."
	sips -z 128 128 assets/gallery/icons/bazaar_2025.jpg --out assets/img/logo-128.jpg
	cwebp -q 80 assets/img/logo-128.jpg -o assets/img/logo-128.webp
	@echo "  → Favicons..."
	sips -z 32 32 assets/gallery/icons/bazaar_2025.png --out assets/img/favicon-32.png
	sips -z 180 180 assets/gallery/icons/bazaar_2025.png --out assets/img/apple-touch-icon.png
	@echo "  → Social share image (OG)..."
	sips -Z 1200 assets/gallery/hero_selections/hero_home_light.png --out /tmp/og_temp.png
	sips -c 630 1200 /tmp/og_temp.png --out /tmp/og_cropped.png
	sips -s format jpeg -s formatOptions 80 /tmp/og_cropped.png --out assets/img/og-image.jpg
	rm /tmp/og_temp.png /tmp/og_cropped.png
	@echo ""
	@echo "✅ Site images generated in assets/img/"

hero: ## Generate responsive hero images from a gallery source
	@# ═══════════════════════════════════════════════════════════════════════════
	@# HERO IMAGE GENERATOR
	@# ═══════════════════════════════════════════════════════════════════════════
	@# 
	@# Usage:
	@#   make hero SRC=bazaar_conversations_1.png OUT=articles_hero_banner
	@#
	@# This generates 3 responsive WebP images with optimized compression:
	@#   - assets/img/$(OUT)-1200.webp  (desktop)
	@#   - assets/img/$(OUT)-800.webp   (tablet)
	@#   - assets/img/$(OUT)-600.webp   (mobile)
	@#
	@# Compression settings: -q 80 -m 6 -sharp_yuv
	@#   - q 80: High quality, good compression balance
	@#   - m 6:  Maximum compression effort
	@#   - sharp_yuv: Better detail preservation
	@#
	@# Examples:
	@#   make hero SRC=bazaar_conversations_dark_5.png OUT=articles_hero_banner_dark
	@#   make hero SRC=bazaar_archives_2.png OUT=archive_hero_banner
	@#   make hero SRC=bazaar_guidelines_2.png OUT=rules_hero_banner
	@#
	@# ═══════════════════════════════════════════════════════════════════════════
ifndef SRC
	@echo "❌ Error: SRC is required"
	@echo ""
	@echo "Usage: make hero SRC=<gallery_image.png> OUT=<output_prefix>"
	@echo ""
	@echo "Example: make hero SRC=bazaar_conversations_1.png OUT=articles_hero_banner"
	@exit 1
endif
ifndef OUT
	@echo "❌ Error: OUT is required"
	@echo ""
	@echo "Usage: make hero SRC=<gallery_image.png> OUT=<output_prefix>"
	@echo ""
	@echo "Example: make hero SRC=bazaar_conversations_1.png OUT=articles_hero_banner"
	@exit 1
endif
	@echo "📷 Generating hero images from $(SRC)..."
	@echo "   Output: assets/img/$(OUT)-{1200,800,600}.webp"
	@echo ""
	@sips -Z 1200 assets/gallery/$(SRC) --out /tmp/hero_1200.png
	@cwebp -q 80 -m 6 -sharp_yuv /tmp/hero_1200.png -o assets/img/$(OUT)-1200.webp
	@sips -Z 800 assets/gallery/$(SRC) --out /tmp/hero_800.png
	@cwebp -q 80 -m 6 -sharp_yuv /tmp/hero_800.png -o assets/img/$(OUT)-800.webp
	@sips -Z 600 assets/gallery/$(SRC) --out /tmp/hero_600.png
	@cwebp -q 80 -m 6 -sharp_yuv /tmp/hero_600.png -o assets/img/$(OUT)-600.webp
	@rm -f /tmp/hero_1200.png /tmp/hero_800.png /tmp/hero_600.png
	@echo ""
	@echo "✅ Done! Generated:"
	@ls -lh assets/img/$(OUT)-*.webp

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

dev-lint: ## Find unused CSS using PurgeCSS (requires: make dev-install-tools)
	@echo "🔍 Analyzing CSS for unused selectors..."
	@echo ""
	@if [ ! -d node_modules/purgecss ]; then \
		echo "❌ PurgeCSS not installed. Run 'make dev-install-tools' first."; \
		exit 1; \
	fi
	@# Build the site first to get all HTML
	@$(BUNDLE) exec jekyll build --quiet
	@mkdir -p _site/purged
	@echo "Scanning _site/ for unused CSS..."
	@echo ""
	@npx purgecss \
		--css _site/assets/css/styles.css \
		--content '_site/**/*.html' \
		--output _site/purged
	@echo ""
	@echo "$(YELLOW)Results:$(RESET)"
	@ORIG=$$(wc -c < _site/assets/css/styles.css | tr -d ' '); \
	PURGED=$$(wc -c < _site/purged/styles.css | tr -d ' '); \
	SAVED=$$((ORIG - PURGED)); \
	echo "  Original:  $$ORIG bytes"; \
	echo "  Purged:    $$PURGED bytes"; \
	echo "  Savings:   $$SAVED bytes ($$(( (SAVED * 100) / ORIG ))%)"
	@echo ""
	@echo "$(YELLOW)Purged CSS saved to:$(RESET) _site/purged/styles.css"
	@echo ""
	@echo "💡 Compare _site/assets/css/styles.css with _site/purged/styles.css"
	@echo "   to identify unused selectors, then manually remove from source."

dev-install-tools: ## Install dead code detection tools (PurgeCSS)
	@echo "📦 Installing dead code detection tools..."
	@if [ ! -f package.json ]; then \
		echo '{"name": "digitalbazaar-dev", "private": true}' > package.json; \
	fi
	npm install --save-dev purgecss
	@echo ""
	@echo "✅ Tools installed. Run 'make dev-lint' to analyze CSS."

# =============================================================================
# PRODUCTION
# =============================================================================

prod-build: ## Build for production (minified, no drafts)
	JEKYLL_ENV=production $(BUNDLE) exec jekyll build
