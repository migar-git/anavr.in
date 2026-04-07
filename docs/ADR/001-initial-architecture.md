# ADR-001: Initial Architecture — Static HTML/CSS/JS on GitHub Pages

**Date:** 2026-02-14
**Status:** Accepted
**Author:** migar

---

## Context

Anavrin is a digital products storefront selling downloadable/access-based products (courses, templates, guides). The site needs to be fast, reliable, SEO-friendly, and inexpensive to operate while accepting payments.

Several architecture options were evaluated:

1. **Static HTML/CSS/JS on GitHub Pages** — zero hosting cost, instant global CDN, no maintenance overhead
2. **Next.js on Vercel** — more dynamic capability, but introduces build pipeline and dependency management
3. **Shopify** — purpose-built e-commerce, but high monthly cost and limited customization
4. **WordPress + WooCommerce** — flexible but heavy, requires server maintenance and plugin updates

## Decision

**Static HTML/CSS/JS hosted on GitHub Pages with Stripe for payments.**

Payments are handled client-side via Stripe Payment Links or Stripe Checkout — no server-side payment processing code required, eliminating PCI scope beyond SAQ A level.

## Rationale

### Why static HTML (not a framework)?

- **Zero build complexity:** No npm, no node_modules, no CI build step. Any contributor can edit and deploy without toolchain setup.
- **Performance:** Sub-1-second FCP achievable without framework overhead. No JavaScript hydration, no bundle splitting needed.
- **Reliability:** No runtime server to fail. GitHub Pages has a 99.9%+ uptime SLA backed by Fastly CDN.
- **Cost:** Free on GitHub Pages for public repositories.

### Why GitHub Pages (not Vercel/Netlify)?

- Already using GitHub for version control — Pages is zero additional configuration
- Custom domain support with automatic HTTPS via Let's Encrypt
- Sufficient for static sites without server-side rendering requirements

### Why Stripe (not Gumroad/Paddle)?

- Stripe publishable keys are safe in client-side HTML
- Payment Links require no backend — redirect model is appropriate for digital goods
- Lower transaction fees than alternatives at this volume
- Trusted brand recognition reduces buyer hesitation

## Consequences

### Positive
- Deployment is a single `git push`
- No dependency updates, no server patches, no infrastructure management
- Excellent Core Web Vitals by default
- Full HTML/CSS control for brand differentiation

### Negative / Trade-offs
- No server-side logic — all dynamic behavior (email capture, order fulfillment) requires third-party services
- No native A/B testing or personalization without client-side tools
- Adding a server-rendered feature would require migrating to a different platform

## Future Considerations

If the product catalog grows significantly or server-side features (user accounts, access management) become necessary, the natural migration path is to Next.js on Vercel with a headless CMS. The current static architecture does not preclude this migration — HTML pages can be incrementally replaced with Next.js routes.
