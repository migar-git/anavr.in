# Agent Readiness — anavr.in

**Audit Date:** 2026-03-29

## Current Agent Readiness: Low-Medium (28 / 100)

Better than aresmaxs.com due to modular structure, but still lacks automation infrastructure.

## What's Working

- AGENT.md schema v1.0 present.
- Separated CSS/JS enables safer agent edits than aresmaxs.com.
- `blog/` and `products/` directories provide clear namespaces for agent-generated content.
- sitemap.xml and robots.txt present — agents can maintain these.

## What Needs to Be Built for Agent Automation

| Component | Priority | Description |
|-----------|----------|-------------|
| `publish_article.py` | High | Agent converts arescore drafts → HTML → blog/ |
| `generate_sitemap.py` | High | Agent regenerates sitemap.xml after new content |
| Product data JSON | High | `products/data.json` for agent-driven product page generation |
| GitHub Actions deploy workflow | High | Agent pushes, CI deploys and validates |
| Email capture form handler | Medium | Agent can trigger welcome sequences |
| Analytics API reader | Medium | Agent reads traffic data for arescore KPIs |

## For Static Site Agents — Recommended Next Steps

1. Create `products/data.json` with product catalog — agents can use this to generate product pages without touching HTML directly.
2. Implement `publish_article.py` (same as aresmax-blog recommendation) — this enables the arescore content pipeline to publish to both blogs.
3. Add GitHub Actions workflow that validates HTML and deploys on push — agents need confidence that their pushes won't break the site.
4. Anavrin and aresmax-blog should share the same content pipeline tooling — build it once, configure twice.
