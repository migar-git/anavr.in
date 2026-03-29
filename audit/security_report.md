# Security Report — anavr.in

**Audit Date:** 2026-03-29

## Security Concerns

| Issue | Severity | Detail |
|-------|----------|--------|
| Legal pages present | Positive | Privacy policy, refund policy, terms exist — required for product sales |
| `js/` directory not audited | Medium | Unknown JavaScript could contain hardcoded API keys (e.g., Mailchimp API key in form handler) |
| No CSP header | Medium | External font/script loads without CSP; risky if JS is added |
| Payment flow security | High | If payment is ever added to static HTML, PCI compliance is the responsibility of the payment provider (Gumroad/Stripe handles this) — do not implement custom payment forms |
| `refund.html` policy accuracy | Low | Refund policy must match actual business practices; legal exposure if they diverge |
| Twitter/social account security | Low | Accounts referenced in JSON-LD should all have 2FA enabled |

### Secrets Audit

No secrets found in scanned files. `js/` directory was not fully inspected — audit manually for hardcoded API keys in form handlers.

## Security Baseline

1. **Audit `js/` directory** for any hardcoded API keys (newsletter forms commonly embed API keys in client-side JS — use server-side proxies instead).
2. **Use Gumroad/Lemon Squeezy** for payments — never handle payment data in static HTML.
3. **Add CSP meta tag** once JS is fully inventoried.
4. **Verify legal pages** (privacy, refund, terms) are accurate for current business state.
5. **Confirm HTTPS enforcement** in GitHub Pages repo settings.
