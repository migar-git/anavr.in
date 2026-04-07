# Security — anavr.in

## Payment Security

- Payment processing must go through a PCI-compliant provider (Stripe, Gumroad, etc.).
- Never store card numbers, CVVs, or raw payment data in this repo or on the static site.
- Stripe publishable keys (pk_live_*) are safe to include in client HTML — secret keys are not.

## Content Security Policy

Apply CSP via `<meta http-equiv="Content-Security-Policy">` in each HTML file.

Recommended directives:
- `default-src 'self'`
- `script-src 'self' https://js.stripe.com` (add payment provider domains)
- `frame-src https://js.stripe.com` (for Stripe Elements)
- `connect-src 'self' https://api.stripe.com`
- `object-src 'none'`

## Secrets Management

Do not commit to this repo:
- Stripe secret keys (`sk_live_*` or `sk_test_*`)
- Webhook signing secrets
- Email service API keys

Store these in the CI/CD environment or a secrets manager.

## Legal Pages

- `privacy.html` — must reflect actual data collection (Stripe, email provider)
- `refund.html` — must match actual refund policy
- `terms.html` — must match actual terms of sale

## External Dependencies

Use Subresource Integrity (SRI) hashes for any CDN-loaded scripts:
```html
<script src="https://cdn.example.com/lib.js"
        integrity="sha384-..." crossorigin="anonymous"></script>
```

## Reporting Issues

Contact the repo owner privately. Do not post security vulnerabilities in public issues.
