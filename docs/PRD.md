---
title: "Anavrin — Product Requirements Document"
version: "1.0"
status: "Active"
owner: "migar"
last-updated: "2026-04-07"
---

# Anavrin — PRD

> **Version 1.0** | Active | Updated 2026-04-07

## 1. Vision & Problem Statement

Anavrin (nirvana backwards) is a premium digital products brand positioned at the intersection of AI education and business automation. The site sells high-ticket courses, templates, and tools to ambitious entrepreneurs who want to build AI-powered income streams. The flagship offering is the "AI CEO Blueprint" — a $2,997 cohort-based course. Supporting products include prompt engineering guides, automation templates, and trading bot setups, starting at lower price points.

**Problem:** Aspiring entrepreneurs lack structured, results-oriented systems for monetizing AI tools. Generic tutorials and scattered free resources don't produce the $10K+/month outcomes serious operators want.

**Audience:** Digitally savvy entrepreneurs and operators (25–45) pursuing location-independent income; existing solopreneurs wanting to automate and scale; side-hustle builders ready to invest in proven systems.

## 2. Goals & Success Metrics

| Goal | KPI | Target | Measurement Method |
|---|---|---|---|
| Drive flagship course applications | Waitlist/application form submits | 50 per cohort | Form submission count |
| Convert product page visitors | Product purchase conversion rate | ≥ 3% | Stripe + analytics |
| Build email list | Newsletter signups | 500/month | Email platform count |
| Establish trust & authority | Avg. time on site | > 2 min | GA4 engagement |
| SEO organic growth | Organic search sessions | +20% MoM | GA4 acquisition |

## 3. User Personas

| Persona | Role | Pain Points | What Success Looks Like |
|---|---|---|---|
| The Hustler | Side-hustle entrepreneur | No system, wasting time on trial-and-error | Purchases a template or guide; implements it in 1 week |
| The Operator | Solopreneur / consultant | Revenue capped by time; can't scale | Enrolls in AI CEO Blueprint; delegates via AI agents |
| The Explorer | Early career professional | Doesn't know where to start with AI | Downloads Module 1 free preview; joins waitlist |

## 4. Functional Requirements

### 4.1 Content

- FR-001: Site MUST present a clear hero section communicating the core value proposition ("Build a $10K/month AI-powered business").
- FR-002: Flagship product section MUST display pricing ($2,997), curriculum overview, cohort size, and application CTA.
- FR-003: Products grid MUST display all SKUs with price, description, trust badges, and payment method icons.
- FR-004: Trust section MUST display social proof stats (students, revenue generated, satisfaction rate, countries).
- FR-005: Blog MUST publish at least 2 articles per month on AI business topics to support SEO.
- FR-006: About page MUST establish brand story and founder credibility.

### 4.2 Conversion

- FR-007: Waitlist/application modal MUST be accessible from hero and flagship section CTAs.
- FR-008: Each product card MUST link directly to a Stripe checkout or landing page.
- FR-009: Free preview download (Module 1) MUST be gated by email capture.
- FR-010: Site MUST display a 30-day money-back guarantee badge on all product purchases.
- FR-011: Privacy policy, refund policy, and terms MUST be accessible from footer.

### 4.3 Navigation & UX

- FR-012: Mobile navigation MUST be fully functional with hamburger toggle.
- FR-013: Particle/animation backgrounds MUST degrade gracefully on low-end devices (reduced motion preference respected).

## 5. Non-Functional Requirements

| Category | Requirement | Target | Priority |
|---|---|---|---|
| Performance | Page load (LCP) | < 2.5s | P0 |
| Performance | Total page weight | < 2 MB | P1 |
| SEO | Core Web Vitals | All green | P0 |
| SEO | Structured data | Organization + Product schema valid | P1 |
| Accessibility | WCAG contrast ratio | AA minimum | P1 |
| Security | All links HTTPS | 100% | P0 |
| Reliability | Uptime (GitHub Pages / CDN) | 99.9% | P0 |

## 6. Constraints

- Static site only — no server-side processing; all checkout via Stripe hosted pages.
- GitHub Pages or equivalent CDN hosting — no database.
- Single developer/owner maintenance model.
- Cohort model limits concurrent students to 50; site must not over-promise availability.

## 7. Out of Scope

- Member portal or LMS (courses hosted externally, e.g., Teachable, Gumroad).
- Live chat / AI chatbot on-site.
- Subscription billing management UI.
- Multi-language support.

## 8. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Stripe test links remain live in production | Medium | High (no revenue) | Audit all buy links before each launch |
| High-ticket course perceived as unproven | Medium | High | Expand testimonials section; add case studies |
| AI market saturation reduces differentiation | High | Medium | Double down on brand voice (premium/cinematic) and community moat |
| Cohort fills slowly | Medium | Medium | Build waitlist via free preview lead magnet |

## 9. Document Index

| Document | Path | Status |
|---|---|---|
| Architecture | /docs/ARCHITECTURE.md | Active |
| PRD (this file) | /docs/PRD.md | Active |
| Sitemap | /sitemap.xml | Active |
| Robots | /robots.txt | Active |
