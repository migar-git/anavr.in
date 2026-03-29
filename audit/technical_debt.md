# Technical Debt — anavr.in

**Audit Date:** 2026-03-29

## What's Missing vs. What Should Exist

| Should Exist | Current State | Priority |
|-------------|---------------|----------|
| Product purchase flow | Absent (no Gumroad/Stripe) | Critical |
| Email capture system | Absent (no form handler) | High |
| Analytics integration | Not visible | High |
| `images/` directory with logo.png | Not confirmed | High |
| Blog content volume | Unknown | High |
| GitHub Actions deploy workflow | Manual push | Medium |
| Product data JSON | Absent | Medium |
| Blog article template | Unknown | Medium |
| CSS minification | Not present | Low |
| `js/` directory documentation | Absent | Low |

## Gap Between Current State and Production-Ready State

**Current state:** Well-structured static site with good SEO foundation and correct legal pages. Missing the business functionality (purchase flow, email capture) that would make it a real product site.

**Production-ready premium course site requires:**
- Payment integration (Gumroad/Lemon Squeezy for digital products).
- Email capture with automation sequences.
- At least 10 substantive blog articles for SEO.
- Course delivery platform (Teachable, Kajabi, or custom) if courses are offered.
- Analytics to measure conversion funnel.
- Social proof elements (testimonials, student count).

**Estimated gap:** 50% of production readiness. Infrastructure is better than other sites but business function is absent.
