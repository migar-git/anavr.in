# Test Strategy — anavr.in

## Overview

Anavrin is a static HTML/CSS/JS site with no backend or build pipeline. Testing focuses on frontend quality, performance, accessibility, and content integrity.

## Test Categories

### 1. Lighthouse Audits (Primary Quality Gate)

Run Google Lighthouse on every significant change before pushing to `main`.

**Targets:**

| Category | Minimum Score |
|---|---|
| Performance | ≥ 90 |
| Accessibility | ≥ 90 |
| Best Practices | ≥ 90 |
| SEO | ≥ 95 |

**How to run:**

```bash
# In Chrome DevTools: Lighthouse tab → Analyze page load
# Or via CLI:
npx lighthouse https://anavr.in --output html --output-path ./lighthouse-report.html
```

Run on both desktop and mobile presets.

### 2. Accessibility Testing

- Use the axe DevTools browser extension to scan for WCAG 2.1 AA violations
- Verify all images have meaningful `alt` text
- Confirm keyboard navigation works for all interactive elements (buttons, links, forms)
- Check color contrast ratios — minimum 4.5:1 for normal text, 3:1 for large text
- Test with a screen reader (NVDA/VoiceOver) on the checkout flow

### 3. Link Checking

Verify no broken links before deployment:

```bash
npx linkinator https://anavr.in --recurse --skip "^(?!https://anavr.in)"
```

Or manually check:
- All product CTAs link to correct Stripe payment pages
- Internal navigation links (nav, footer, breadcrumbs) resolve correctly
- Blog article cross-links work

### 4. Cross-Browser Testing

Test on:
- Chrome (latest)
- Firefox (latest)
- Safari (latest — macOS or iOS)
- Edge (latest)

Focus areas: CSS animations, custom properties, grid/flexbox layouts, payment button interactions.

### 5. Mobile/Responsive Testing

Viewport breakpoints to verify:

| Breakpoint | Device |
|---|---|
| 375px | iPhone SE / small phones |
| 390px | iPhone 14 |
| 768px | iPad portrait |
| 1024px | iPad landscape / small laptop |
| 1280px | Standard desktop |
| 1920px | Large desktop |

Use Chrome DevTools Device Toolbar or BrowserStack for real-device testing.

### 6. Visual Regression

For significant redesigns, capture screenshots before and after:

```bash
npx playwright screenshot https://anavr.in --full-page --output before.png
# Make changes
npx playwright screenshot https://anavr.in --full-page --output after.png
# Compare visually
```

### 7. Payment Flow Testing

Before any payment-related change reaches production:
- Test Stripe checkout with test card `4242 4242 4242 4242`
- Verify success redirect URL works
- Confirm no secret keys are exposed in page source or network requests

### 8. SEO Checks

- `<title>` and `<meta name="description">` present on all pages
- Schema.org Product markup valid (test at https://search.google.com/test/rich-results)
- Open Graph tags correct for social sharing
- sitemap.xml lists all pages with correct URLs
- robots.txt does not block indexable pages

## Test Execution Schedule

| Trigger | Tests to Run |
|---|---|
| Before every push to `main` | Lighthouse (manual), browser smoke test |
| New product page added | Full link check, SEO check, mobile layout |
| Payment flow change | Stripe test-mode checkout flow |
| Major redesign | Visual regression, cross-browser, accessibility |
| Monthly | Full Lighthouse audit, link check, Schema.org validation |
