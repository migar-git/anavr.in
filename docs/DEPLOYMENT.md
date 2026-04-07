# Deployment — anavr.in

## Platform

Hosted on **GitHub Pages** with custom domain **anavr.in** configured via GoDaddy DNS.

## DNS Configuration

| Record Type | Host | Value |
|---|---|---|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | migar-git.github.io |

DNS propagation can take up to 48 hours after changes. Verify with:
```bash
dig anavr.in A +short
nslookup anavr.in
```

## Deploy Process

```bash
# Make changes locally, test in browser
git add <changed-files>
git commit -m "feat: describe your change"
git push origin main
```

GitHub Pages rebuilds automatically within ~60 seconds after push to `main`.

## Verifying Deployment

1. Open https://anavr.in in a private/incognito browser window
2. Hard-refresh (Ctrl+Shift+R) to bypass cache
3. Confirm the changed content appears
4. Check HTTPS padlock — certificate is managed by GitHub Pages

## Rollback

```bash
# Option 1: Revert the last commit
git revert HEAD
git push origin main

# Option 2: Revert a specific commit
git revert <commit-sha>
git push origin main

# Option 3: Hard reset (use only if revert is not possible)
git reset --hard <previous-good-sha>
git push --force origin main  # requires branch protection off
```

Prefer `git revert` over force-push to preserve history.

## Environment Variables

No server-side environment variables required. This is a fully static site.

- **Stripe publishable key** (`pk_live_*`) is safe to embed in client HTML
- **Stripe secret key** (`sk_live_*`) must never be in this repo — use a server-side proxy for any operations requiring it

## Pre-Deploy Checklist

- [ ] Pages open and render correctly in Chrome, Firefox, Safari
- [ ] Mobile layout verified at 375px width
- [ ] All product links and payment CTAs functional
- [ ] sitemap.xml updated if pages added or removed
- [ ] robots.txt reflects correct domain (anavr.in)
- [ ] No console errors in browser DevTools
- [ ] Lighthouse Performance score ≥ 90

## Post-Deploy Checklist

- [ ] Confirm custom domain resolves (anavr.in and www.anavr.in)
- [ ] HTTPS enforced (HTTP redirects to HTTPS)
- [ ] Payment buttons open Stripe checkout correctly
- [ ] Analytics (if configured) recording sessions
