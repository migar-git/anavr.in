# Runbook — anavr.in

## Service Overview

- **Site:** https://anavr.in
- **Type:** Static HTML/CSS/JS storefront
- **Hosting:** GitHub Pages (repository: migar-git/anavr.in, branch: main)
- **Domain Registrar:** GoDaddy
- **Payment:** Stripe

---

## Routine Operations

### Deploy a Change

```bash
git add <files>
git commit -m "type: description"
git push origin main
```

GitHub Pages publishes automatically within ~60 seconds.

### Verify the Site is Live

```bash
curl -I https://anavr.in
# Expect: HTTP/2 200
```

Or open https://anavr.in in a private browser window.

---

## Incident Procedures

### Site Not Loading (502/503/Timeout)

1. Check GitHub Status: https://www.githubstatus.com
2. If GitHub Pages is down — wait and monitor status page
3. If GitHub Pages is operational — check the repository's Pages settings at:
   `https://github.com/migar-git/anavr.in/settings/pages`
4. Confirm source branch is set to `main` and root is `/`
5. Check the last commit did not introduce a syntax error in index.html

### Domain Not Resolving

1. Check DNS propagation:
   ```bash
   dig anavr.in A +short
   # Expected: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153
   ```
2. Log into GoDaddy DNS dashboard and verify A records are correct
3. If records were recently changed, allow up to 48 hours for propagation
4. Verify CNAME file in repo root contains exactly `anavr.in` (no trailing spaces or newlines)

### HTTPS Certificate Issue

GitHub Pages automatically provisions Let's Encrypt certificates for custom domains.

1. Go to repository Settings → Pages
2. Check "Enforce HTTPS" is enabled
3. If certificate shows as pending, wait up to 24 hours after DNS propagation completes
4. If expired or errored, toggle "Enforce HTTPS" off and back on to re-trigger provisioning

### Payment Button Not Working

1. Check browser console for JavaScript errors
2. Verify Stripe publishable key in the HTML is the correct environment key (test vs. live)
3. Test with Stripe test card: `4242 4242 4242 4242`, any future expiry, any CVC
4. Check Stripe dashboard (https://dashboard.stripe.com) for failed payment attempts

### Rollback a Bad Deployment

```bash
# Find the last good commit
git log --oneline -10

# Revert to last good state
git revert HEAD
git push origin main

# Or revert a specific commit
git revert <bad-commit-sha>
git push origin main
```

---

## Cache Invalidation

GitHub Pages uses CDN caching. After a push:
- Allow 60–120 seconds for propagation
- Test with `curl -I https://anavr.in` — check `Last-Modified` header
- For immediate testing, use browser hard-refresh (Ctrl+Shift+R) or incognito

There is no manual CDN purge available on GitHub Pages free tier. For forced cache bypass during testing, append a query string: `https://anavr.in?v=2`

---

## Content Updates

### Update Product Pricing

Search all HTML files for the old price string and update consistently:
```bash
grep -r "\$29.99" .
# Update all matching files
```

### Add a New Product Page

1. Copy an existing product page from the site
2. Update all content, pricing, and Stripe payment link
3. Link the new page from `index.html` product grid
4. Add the URL to `sitemap.xml`
5. Push to main and verify page loads

---

## Monitoring

- No automated uptime monitoring is configured by default
- Recommended: set up a free UptimeRobot monitor on https://anavr.in
- Check Google Search Console monthly for crawl errors or indexing issues

---

## Contacts

| Role | Contact |
|---|---|
| Site Owner | migar (GitHub) |
| Domain Registrar | GoDaddy account — anavr.in |
| Payment Processor | Stripe dashboard — dashboard.stripe.com |
