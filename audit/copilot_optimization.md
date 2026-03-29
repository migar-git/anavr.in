# Copilot Optimization — anavr.in

**Audit Date:** 2026-03-29

## Current Copilot Usefulness Rating: 4 / 10

Better structure than aresmaxs.com (separated CSS/JS) gives Copilot more surface area. JavaScript files are available for Copilot completion. Main limitations: no build system, sparse JS codebase.

## Opportunities for AI Assistance

| Task | Opportunity |
|------|-------------|
| Email capture form JS | Copilot can write form submission handlers for ConvertKit/Mailchimp API |
| Blog article generation | Agent generates HTML from Markdown using a template |
| Product page generation | Agent creates product HTML from a product data JSON |
| Analytics integration | Copilot can insert Plausible script tag consistently |
| SEO audit script | Copilot can write a script checking meta tags across all pages |
| Sitemap.xml maintenance | Copilot can write a generator that reads all .html files |

## What Needs to Be Built for Copilot to Help More

1. **Article template** — Copilot needs a consistent `blog/_template.html` to generate blog articles.
2. **Product data JSON** — a `products/data.json` file that Copilot can read to generate product pages programmatically.
3. **`publish_article.py`** — same pattern as aresmax-blog; agent converts arescore drafts to HTML.
4. **`.github/copilot-instructions.md`** — describe Anavrin brand, target audience (ambitious entrepreneurs), and product categories.
