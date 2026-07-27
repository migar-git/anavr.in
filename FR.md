# anavr.in Feature Requests

## Review Metadata

- **Review date:** 2026-07-03 (repository last commit observed: 2026-07-03, per `.git/logs/HEAD`)
- **Repo root path:** `C:\Users\mcgac\Python\anavr.in`
- **Languages/frameworks detected:** Pure HTML5, CSS3, vanilla JavaScript (ES6+). No frontend framework (no React/Vue/Next/Astro/Hugo). No package.json, no `node_modules`, no build tool, no bundler, no transpiler.
- **App type determined:** **Static marketing/storefront website** (digital-products landing site). Evidence: (1) no `package.json`/`requirements.txt`/`pyproject.toml`/`Cargo.toml`/`go.mod` anywhere in the tree; (2) `AGENT.md` explicitly declares `type: static-site` and `commands: {test: "", lint: "", format: "", build: "", deploy: ""}` (all empty); (3) `CLAUDE.md` states "No build system — static content and configuration files"; (4) 15 hand-authored `.html` files reference `css/style.css` and `js/{main,script}.js` directly with no bundler output paths; (5) hosting is GitHub Pages via `CNAME` file (domain `anavr.in`) with DNS docs pointing at GitHub Pages IPs.
- **Review mode:** Blitz — single-session, sampled evidence.
- **Commands/tools actually run:** No shell/build commands were run (per task rules, no code execution). All findings derived from `Read`/`Glob`/`Grep` against the working tree and `.git/logs/HEAD`, `.git/config`, `.git/packed-refs` (git CLI was not invoked; log/config/refs were read directly as flat files per fallback instructions).
- **Tests/CI discovered:** No test framework, test directory, or test files found (`**/test*/**` glob returned nothing). CI present but narrow: `.github/workflows/swarm-gate.yml` (validates presence/schema of `AGENT.md`/`AGENTS.md` governance files only — not app functionality), `.github/workflows/doc-lint.yml` (markdownlint + frontmatter validation for `docs/**`), `.github/workflows/ai-review.yml` (optional AI-assisted doc review, gated behind a repo variable). `.github/dependabot.yml` configures updates for a `pip` ecosystem and `github-actions` ecosystem, despite no Python dependency manifest existing in this repo (likely a copy-pasted template from a sibling repo in the fleet — see FR-013).
- **Overall confidence:** High for structural/presence claims (file existence, CSP content, absence of directories) since these were directly read. Medium for a11y/performance claims that would normally require a live browser/Lighthouse run (not performed, per no-code-execution rule) — these are marked accordingly and derived from static markup inspection only.

## Existing Capabilities Found

- 15 static HTML pages: homepage, about, blog index + 3 blog articles, privacy/terms/refund legal pages, 6 product landing pages — all present and internally linked correctly (blog-link and sitemap staleness issues were already found and fixed by a prior `/remediate-repo` pass per `CODE_REVIEW_REPORT.md` and `.claude/session-notes/2026-05-12-09-58-session.md`).
- **Content-Security-Policy** meta tag present on all 15 HTML pages (`default-src 'self'; script-src 'self' 'unsafe-inline'; ...; object-src 'none'; base-uri 'self'`) — added in commit `3b98ee8` ("fix(security): add .gitignore and CSP meta tags").
- `.gitignore` present, correctly excludes `.env*`, `*.key`, `*.pem`, `*.p12`, `node_modules/`, build/log artifacts.
- SEO fundamentals: `sitemap.xml` (15 URLs, `lastmod=2026-05-12`), `robots.txt` referencing the sitemap, per-page `<meta name="description">`, Open Graph tags, Twitter Card tags, Schema.org `Organization` and `Product` JSON-LD/microdata markup.
- Legal pages present and reasonably complete: `privacy.html`, `terms.html`, `refund.html` (30-day money-back guarantee), all referencing Stripe as payment processor.
- Mobile-responsive design with a working hamburger menu (`js/main.js` / `js/script.js`), smooth-scroll anchor navigation, and `IntersectionObserver`-based scroll/lazy-load animations.
- Stripe **test-mode** checkout links (`buy.stripe.com/test_...`) wired on all 6 sellable product cards — no secret keys present in any scanned file (verified: no `sk_live_`/`sk_test_` strings found anywhere in the tree).
- Extensive prior self-audit trail already exists in-repo: `audit/org_audit_2026-03-29.md`, `audit/security_report.md`, `audit/technical_debt.md`, `audit/review_overview.md`, `audit/agent_readiness.md`, `audit/architecture_analysis.md`, `audit/copilot_optimization.md`, `docs/PRD.md`, `docs/SECURITY.md`, `CODE_REVIEW_REPORT.md`, `findings.json` — these independently corroborate several of the gaps below (treated as corroborating evidence only, not primary proof, per hard rules).
- Governance/agent-fleet scaffolding present: `AGENT.md`, `AGENTS.md`, `codex.md`, `MEMORY.md`, `PORTFOLIO.md`, `docs/ARCHITECTURE.md`, `.notebooklm/sources.json`, `CLAUDE.md`, `.github/copilot-instructions.md` — these are fleet-standard documentation artifacts, not application features.
- `.markdownlint.json` config present and enforced via `doc-lint.yml` CI.
- `.github/dependabot.yml` configured for weekly updates (though ecosystem mismatch noted above).

## Evidence Ledger

| Evidence ID | Area | Evidence Type | File/Path/Command | Finding | Confidence |
|---|---|---|---|---|---|
| E-001 | App type | Manifest | `AGENT.md` | `type: static-site`; all build/test/lint/deploy commands empty strings | High |
| E-002 | App type | File structure | Glob `**/*` (123-ish files) | No package.json/requirements.txt/pyproject.toml/Cargo.toml/go.mod anywhere | High |
| E-003 | Security | Grep | `CSP\|Content-Security-Policy` across repo | CSP meta tag present in all 15 `.html` files | High |
| E-004 | Security | Grep | `X-Frame-Options\|X-Content-Type-Options\|Referrer-Policy\|Permissions-Policy\|Strict-Transport-Security` | Zero matches in entire tree | High |
| E-005 | Security | git log | `.git/logs/HEAD` line 4 | Commit `3b98ee8`: "fix(security): add .gitignore and CSP meta tags -- 2026-04-07" | High |
| E-006 | Secrets | Grep | `sk_live\|sk_test\|pk_live\|pk_test\|stripe` (case-insensitive) | Only `buy.stripe.com/test_...` checkout URLs found; no secret key patterns | High |
| E-007 | Secrets | Glob | `**/*.pem`, `**/*.key`, `**/*credential*`, `**/*secret*` (filename-only) | Zero secret-like filenames except `rules/rule_009_secrets.md` (a governance doc, not a secret) | High |
| E-008 | Testing | Glob | `**/test*/**` | Zero matches — no test directory or test files exist | High |
| E-009 | CI | File read | `.github/workflows/swarm-gate.yml` | CI validates only presence/schema of `AGENT.md`/`AGENTS.md`; no HTML/link/lint validation of site content | High |
| E-010 | CI | File read | `.github/dependabot.yml` | Configured for `pip` ecosystem despite no Python manifest in repo | High |
| E-011 | Assets | Glob | `images/**` | Zero results — directory does not exist | High |
| E-012 | Assets | Grep in `index.html` | `og:image` references `https://anavr.in/images/og-image.jpg`; JSON-LD references `https://anavr.in/images/logo.png` | Both referenced assets are missing from repo (confirmed by E-011) | High |
| E-013 | Analytics | Grep | `google-analytics\|gtag\|GA_MEASUREMENT\|analytics` (case-insensitive) | Zero matches in any `.html`/`.js` file (only doc mentions in audit/PRD files) | High |
| E-014 | Accessibility | Grep | `aria-\|role=\|alt=\|lang=` in `index.html` | Only 2 occurrences total — both `aria-label="Toggle menu"` on the same hamburger button pattern repeated per page; no `alt=` attributes found (page uses emoji glyphs, not `<img>`, for icons) | Medium (static markup only, no live AT/screen-reader test performed) |
| E-015 | Accessibility | Grep | `prefers-reduced-motion` | Zero matches anywhere in CSS/JS | High |
| E-016 | Product functionality | File read | `js/main.js` lines 26-43; `js/script.js` lines 250-278 | Newsletter and waitlist forms only `console.log`/`alert()` the submitted data client-side; no fetch/XHR to any backend or third-party email API | High |
| E-017 | Governance docs (self-audit) | File read | `audit/technical_debt.md` | Repo's own prior audit lists "Product purchase flow: Absent," "Email capture system: Absent," "Analytics integration: Not visible" as Critical/High priority gaps | Medium (corroborating, not primary — used only to confirm code-level findings above) |
| E-018 | Cross-reference integrity | File read | `codex.md` lines 58-63; `.github/copilot-instructions.md` line 20 | Both reference `agents/`, `commands/`, `skills/`, `rules/` as existing directories | High |
| E-019 | Cross-reference integrity | Glob | `agents/**`, `commands/**`, `skills/**` | Zero results for all three — directories referenced in E-018 do not exist in this repo | High |
| E-020 | Cross-reference integrity | Glob | `rules/*` | Returns `rules/rule_009_secrets.md` only via direct Grep hit, but a fresh `Glob rules/*` in a later pass returned no files (transient/caching inconsistency); at least the one file was independently confirmed to exist via its Grep match path | Medium |
| E-021 | PRD conformance | File read | `docs/PRD.md` FR-013 | "Particle/animation backgrounds MUST degrade gracefully... reduced motion preference respected" — contradicted by E-015 | High |
| E-022 | PRD conformance | File read | `docs/PRD.md` §2 goals row 4 | "SEO organic growth... Organic search sessions +20% MoM... GA4 acquisition" as measurement method — contradicted by E-013 (no GA4 present) | High |
| E-023 | robots.txt/sitemap | File read | `robots.txt`, `sitemap.xml` | Both present, sitemap has 15 correctly-dated URLs; no `Disallow` rules present (fully open crawl, appropriate for a marketing site) | High |
| E-024 | Deploy pipeline | File read | `docs/DEPLOYMENT.md` §Deploy Process | Deploy = manual `git push origin main`; no GitHub Actions deploy/validation workflow triggers on push to main for site content (swarm-gate only checks governance files) | High |
| E-025 | Licensing | Glob | `LICENSE*` | Zero results; `README.md` states "All rights reserved © 2026 Anavrin" as sole licensing statement | High |
| E-026 | Contact/security reporting | Glob + Read | `SECURITY.md` (root) | Not found at root; `docs/SECURITY.md` exists instead with a "Reporting Issues" section but no formalized `security@` contact, no `.well-known/security.txt` | High |
| E-027 | Domain verification | File read | `CNAME` | Contains only `anavr.in` — matches README/DNS docs | High |
| E-028 | Payment/PCI scope | File read | `docs/SECURITY.md` lines 1-8 | Explicitly documents Stripe as PCI-scope owner; no custom payment form code found anywhere (confirmed safe pattern, not a gap) | High |

## Threat Model Summary

STRIDE-brief, scoped to what this repo's evidence actually supports (static site, no backend, no auth, no user data storage in-repo):

- **Spoofing:** Low residual risk — no authentication system exists (E-002), so there is no login surface to spoof. Primary spoofing vector is off-repo (DNS/domain hijack at GoDaddy, or GitHub Pages account takeover) — outside this repo's code but relevant to `DEPLOYMENT.md`'s DNS instructions.
- **Tampering:** CSP (E-003) meaningfully restricts injected-script execution, but `script-src 'self' 'unsafe-inline'` still permits inline `<script>` tampering if an attacker can modify HTML at rest (e.g., compromised GitHub account) — the CSP does not defend against a compromised repo, only against reflected/DOM-based injection from third parties. No Subresource Integrity (SRI) is used for the Google Fonts CDN load, though `docs/SECURITY.md` itself recommends SRI for CDN scripts.
- **Repudiation:** No server-side logging/audit trail exists because there is no server (fully static site) — not a meaningful gap for this app type, but the email-capture forms (E-016) don't record submissions anywhere, so there is no record of who requested the waitlist/newsletter (a business risk, not strictly a security one).
- **Information Disclosure:** No secrets found in tracked files (E-006, E-007). Missing security headers (E-004) — specifically no `Referrer-Policy` — mean referrer information may leak to the Google Fonts CDN and any future third-party embeds; low severity given current minimal third-party surface.
- **Denial of Service:** Static site on GitHub Pages/CDN has inherent DoS resilience; no rate limiting is needed or present because there are no server-side endpoints to exhaust. Not a gap for this app type.
- **Elevation of Privilege:** No privilege levels exist in the app itself (E-002). The only elevation surface is repo/CI write access — `swarm-gate.yml` validates governance file presence but does not gate on any security scanning (no secret scanning, no SAST/DAST step) before merge to `main`, meaning a compromised contributor credential could push directly to production without an automated security check.

## AI Governance Summary

Not applicable — no AI/LLM features found in this repo. (The repo's `.github/workflows/ai-review.yml` invokes an *external* AI documentation reviewer as a CI convenience for doc-quality gating, and `AGENT.md`/`codex.md`/`AGENTS.md` describe how *other* agents in Michael's fleet are authorized to modify this repo — but the anavr.in website itself has no runtime AI/LLM feature, no prompt registry, no model routing, and no AI-facing user functionality of its own.)

## Competitive Benchmark Matrix

This repo is a static marketing/storefront site, not an agentic platform or dev tool — so the standard fleet-wide competitive set (GitHub Copilot coding agent, Claude Code, Cursor, LangGraph/LangSmith, Langfuse, Sentry, Datadog, Backstage, Temporal) is not meaningfully comparable. Benchmarked instead against typical static-site/creator-storefront best practice (Gumroad/Lemon Squeezy storefronts, Webflow/Framer sites, standard Jamstack baselines):

| Capability | anavr.in (this repo) | Typical creator-storefront baseline (Gumroad/Lemon Squeezy/Webflow) | Gap? |
|---|---|---|---|
| CSP / security headers | CSP meta tag only; no other headers | Platform-managed headers typically include HSTS, X-Frame-Options, Referrer-Policy by default | Yes — see FR-001 |
| Payment processing | Stripe test-mode links only, no live checkout | Live checkout integrated, PCI scope fully delegated to platform | Yes — see FR-002 |
| Email capture backend | Client-side only, `alert()`/`console.log()`, no persistence | Integrated ESP (Mailchimp/ConvertKit) capturing to a real list | Yes — see FR-003 |
| Analytics | None | GA4/Plausible/platform-native analytics dashboard | Yes — see FR-004 |
| Automated deploy validation (broken links, HTML lint) | None (manual push only) | Most static-site platforms run build-time link/HTML checks | Yes — see FR-005 |
| Sitemap/robots/SEO meta | Present and current | Present (platform-generated) | No gap |
| Legal pages (privacy/terms/refund) | Present, reasonably complete | Present | No gap |
| Mobile responsiveness | Present | Present | No gap |
| Accessibility (reduced motion, ARIA coverage) | Partial (2 aria-labels only, no reduced-motion) | Platform themes generally WCAG AA-audited | Yes — see FR-006, FR-007 |
| Automated secret scanning in CI | Not present | Common in platform-managed or template-based pipelines | Yes — see FR-008 |
| Image asset pipeline (OG image, logo) | Referenced but missing | Present | Yes — see FR-009 |

## Gap Analysis Summary

anavr.in is a well-organized, security-conscious static storefront for its size — CSP is deployed fleet-wide across every page, no secrets are exposed, `.gitignore` is correctly scoped, and legal/SEO fundamentals are in place. The verified gaps cluster into three groups: (1) **incomplete/missing business functionality** that the site's own PRD (`docs/PRD.md`) requires but the code does not yet deliver — no live payment processing (Stripe is in test mode only), no functioning email-capture backend, no analytics, and two referenced image assets (`og-image.jpg`, `logo.png`) that don't exist in the repo; (2) **security-hardening deltas** beyond the CSP that's already shipped — no additional HTTP security headers, no CI-side secret scanning, no SRI on the Google Fonts CDN load; and (3) **documentation/tooling drift** — `codex.md` and `.github/copilot-instructions.md` reference `agents/`, `commands/`, and `skills/` directories that do not exist in this repo, and `.github/dependabot.yml` is configured for a `pip` ecosystem that has no corresponding Python manifest, both suggesting templates copied from sibling repos in the fleet without being adapted to this repo's actual (HTML-only) stack. None of these gaps are severe for a pre-revenue marketing site, but several (payment activation, email capture, analytics) directly block the monetization goals stated in the site's own PRD, and are appropriately prioritized P0/P1 below.

## Feature Requests

### FR-001: Add HTTP security headers beyond the existing CSP meta tag
- **Description:** All 15 HTML pages carry only a `Content-Security-Policy` meta tag (E-003). No `Referrer-Policy`, `X-Content-Type-Options`, `Permissions-Policy`, or `Strict-Transport-Security` headers are present anywhere in the repo (E-004). Because this is GitHub Pages, true HTTP response headers cannot be set via a server config file, but a `_headers`-equivalent is not available on GitHub Pages either — so this requires either migrating hosting to a platform that supports custom headers (Cloudflare Pages, Netlify) or adding the remaining safe headers as `<meta http-equiv>` tags where browser support allows (e.g., `Referrer-Policy` via meta is supported; `X-Frame-Options` and HSTS are not settable via meta and require a hosting change).
- **Why It Matters:** `docs/SECURITY.md` itself recommends a fuller header set and SRI; leaving referrer data and framing unprotected is a low-but-free-to-fix hardening gap, especially before the site starts handling live payments.
- **Verification Evidence:** Confirmed via direct Grep for header name strings across the entire tree (E-004), cross-referenced against the CSP-only pattern found in every HTML file (E-003).
- **Evidence IDs:** E-003, E-004
- **Priority:** P1
- **Category:** Security
- **ROI Score:** 4/10 — low direct revenue/adoption impact, but cheap trust/UX and risk reduction; weighted mostly on risk (20%) and trust (15%) categories rather than revenue.
- **Risk Score:** 3/10 — low complexity, no migration needed for the meta-tag-settable subset, no blast radius since headers are additive-only.
- **Dependencies:** None for the meta-tag subset; a hosting migration (Netlify/Cloudflare Pages) would be needed for HSTS/X-Frame-Options, which is a larger separate decision.
- **Competitive Reference:** Typical creator-storefront platforms set these headers by default (see Competitive Benchmark Matrix).
- **Security/Privacy Impact:** Reduces referrer leakage and clickjacking surface; no privacy-negative impact.
- **Rollout Readiness:** High — additive meta tags can be added to all 15 pages in one PR with no functional risk.
- **Validation Gates:**
  - Grep confirms `Referrer-Policy` meta tag present on all 15 HTML files post-change.
  - Manual browser DevTools check confirms no CSP violations introduced by the new meta tags.
  - securityheaders.com scan (manual, post-deploy) shows improved grade versus baseline.
- **Acceptance Criteria:**
  - All 15 HTML files contain a `<meta name="referrer" content="strict-origin-when-cross-origin">` (or stricter) tag.
  - No console CSP errors appear on any page after the change (spot-checked in a browser).
  - A follow-up decision record exists (in `docs/SECURITY.md` or `docs/ARCHITECTURE.md`) documenting whether HSTS/X-Frame-Options require a hosting migration, and if so, the target platform.

### FR-002: Activate live Stripe payment processing (currently test-mode only)
- **Description:** Every product `Buy Now` button links to a `buy.stripe.com/test_...` URL (verified across all 6 product cards in `index.html`, E-006). No live Stripe checkout link exists anywhere in the repo. `docs/PRD.md` §8 explicitly lists "Stripe test links remain live in production" as a named risk with High impact.
- **Why It Matters:** The site cannot generate any revenue in its current state — every purchase attempt hits Stripe's test-mode checkout, which does not charge real cards or fulfill real orders. This is the single largest gap between the site's stated business goals (PRD §2: "Convert product page visitors... ≥3%... measured via Stripe + analytics") and its actual capability.
- **Verification Evidence:** Directly confirmed by reading `index.html` product-card `href` attributes; all 6 contain the `test_` path segment used by Stripe's payment-link test mode.
- **Evidence IDs:** E-006
- **Priority:** P0
- **Category:** Monetization/Business-Critical
- **ROI Score:** 9/10 — this is the direct revenue-unlock gate; weighted heavily on the 25% revenue/adoption criterion since literally zero revenue is possible until this ships.
- **Risk Score:** 4/10 — low technical complexity (swap URLs), but real financial/compliance stakes once live (PCI scope, refund policy accuracy, tax handling) bump the risk above trivial; no migration or blast-radius concern since Stripe fully owns PCI compliance per `docs/SECURITY.md`.
- **Dependencies:** Requires the site owner to complete Stripe account activation (business verification, bank details) — an off-repo prerequisite `docs/PRD.md` and `DEPLOYMENT.md` both flag as outstanding.
- **Competitive Reference:** Gumroad/Lemon Squeezy storefronts ship with live checkout by default; this is table stakes for any commerce site.
- **Security/Privacy Impact:** None added by this repo's code (Stripe hosts the entire payment flow per `docs/SECURITY.md`); ensures the "as-is" test-mode exposure risk named in PRD §8 is closed.
- **Rollout Readiness:** Medium — blocked on an off-repo Stripe account activation step, not a code change.
- **Validation Gates:**
  - Manual test purchase completes successfully in Stripe live mode with a real (small) charge, then refunded.
  - `refund.html` policy is re-verified to match the now-live refund process end-to-end.
  - All 6 product links plus the bundle link are spot-checked to confirm none still contain `test_`.
- **Acceptance Criteria:**
  - Zero occurrences of `buy.stripe.com/test_` remain in any tracked file.
  - A live purchase produces an order confirmation email from Stripe to the buyer.
  - `docs/PRD.md` risk table is updated to mark this risk as resolved with a date.

### FR-003: Implement a real email-capture backend for newsletter and waitlist forms
- **Description:** The newsletter form (`index.html` `#newsletter-form`) and waitlist form (`#waitlist-form`) are both wired to client-side-only handlers. In `js/script.js` lines 250-278, the newsletter submit handler only calls `alert()` and `.reset()`; the waitlist handler does the same. In `js/main.js` lines 26-43, `handleEmailSubmit` logs the email to `console.log` and shows a fake success message — no network request (`fetch`/`XHR`) to any email service provider (ESP) exists anywhere in either JS file.
- **Why It Matters:** `docs/PRD.md` FR-009 requires the free-preview download to be "gated by email capture," and Goal row 3 targets "500/month" newsletter signups measured via "Email platform count" — neither is achievable because no emails are ever actually transmitted or stored anywhere.
- **Verification Evidence:** Full-file read of both `js/main.js` and `js/script.js` confirms no `fetch(`, `XMLHttpRequest`, or third-party ESP SDK/script tag exists in the repo; corroborated by the repo's own `audit/technical_debt.md` listing "Email capture system: Absent (no form handler)" as High priority.
- **Evidence IDs:** E-016, E-017
- **Priority:** P0
- **Category:** Monetization/Growth
- **ROI Score:** 8/10 — directly blocks the PRD's stated lead-gen and waitlist-conversion goals (revenue/adoption weighted 25%); every current form submission is silently discarded, representing 100% lead loss today.
- **Risk Score:** 4/10 — moderate complexity (ESP account setup + API/embed integration + privacy-policy consistency check), low blast radius since it's additive, but does introduce a new third-party vendor dependency (10% vendor weight) and a GDPR/CAN-SPAM consent-language check (5% compliance weight).
- **Dependencies:** Requires choosing an ESP (ConvertKit/Mailchimp, both already named in `DEPLOYMENT.md` "Soon" section and `audit/review_overview.md`); if a client-side embed approach is used, CSP `connect-src`/`script-src` directives (E-003) will need to be extended to allow the ESP's domain.
- **Competitive Reference:** Any Webflow/Framer/creator-storefront site ships with a working ESP integration as a default block.
- **Security/Privacy Impact:** Must update `privacy.html` (already mentions "Email service providers" generically) to name the specific ESP once chosen, per data-processor disclosure norms.
- **Rollout Readiness:** Medium — requires an ESP account and API key/embed setup outside this repo, then a small JS change inside it.
- **Validation Gates:**
  - A test email submitted via the live form appears in the ESP's contact list within a defined SLA (e.g., 60 seconds).
  - CSP is re-verified to still block unrelated third-party script execution after the `connect-src`/`script-src` allowlist is extended only for the chosen ESP domain.
  - `privacy.html` diff reviewed to confirm the ESP is now named explicitly.
- **Acceptance Criteria:**
  - Submitting the newsletter form with a valid email results in a real, verifiable subscriber record in the ESP dashboard (not just a browser `alert()`).
  - The waitlist form's "biggest business challenge" field data is captured and retrievable by the site owner (not merely alerted and discarded).
  - No secret ESP API key is committed in plaintext to any tracked file (verify via the same secret-filename/pattern scan used in this review).

### FR-004: Add privacy-respecting analytics/measurement
- **Description:** No analytics of any kind (Google Analytics, Plausible, Fathom, or any custom telemetry) is present in any HTML or JS file (E-013). `docs/PRD.md` explicitly names "GA4" as the measurement method for 3 of its 5 stated success goals (conversion rate, time-on-site, organic-growth tracking), none of which are currently measurable.
- **Why It Matters:** Without any analytics, the site owner has no visibility into traffic, conversion funnel performance, or which of the 6 products/blog posts are driving engagement — making the PRD's own success metrics unverifiable in practice.
- **Verification Evidence:** Case-insensitive Grep for `google-analytics|gtag|GA_MEASUREMENT|analytics` across the whole repo returned zero matches in any `.html`/`.js` source file (only mentions inside markdown audit/PRD docs, which per the hard rules do not count as implementation).
- **Evidence IDs:** E-013, E-022
- **Priority:** P1
- **Category:** Observability/Growth
- **ROI Score:** 6/10 — indirect revenue impact (enables data-driven iteration on the funnel) rather than direct; scored on adoption/trust (15%) and differentiation (10%) more than immediate revenue.
- **Risk Score:** 3/10 — low complexity (single script tag or lightweight analytics embed), minor CSP `script-src`/`connect-src` extension needed, minor privacy-policy consistency update.
- **Dependencies:** CSP (E-003) `script-src`/`connect-src` directives must be extended to allow the chosen analytics provider's domain; `privacy.html` "Usage Data... via analytics tools" language should be updated to name the specific tool.
- **Competitive Reference:** Every mainstream storefront/marketing-site platform ships default traffic analytics.
- **Security/Privacy Impact:** Choice of provider affects privacy posture — a cookie-less option (Plausible/Fathom, both already suggested in the repo's own `audit/review_overview.md`) would avoid a cookie-consent-banner requirement that GA4 would likely trigger under GDPR/CCPA.
- **Rollout Readiness:** High — single script tag addition across 15 pages plus one CSP directive update.
- **Validation Gates:**
  - Live pageview appears in the analytics dashboard within the provider's normal latency window after a manual test visit.
  - CSP updated and re-verified with no console violations.
  - `privacy.html` updated to name the specific analytics provider used.
- **Acceptance Criteria:**
  - All 15 HTML pages contain the analytics snippet consistently (verifiable via Grep count = 15 post-change).
  - A real visit from a test browser produces a visible session in the analytics dashboard.
  - If a cookie-based tool is chosen, a consent mechanism is added before the tool fires; if a cookieless tool is chosen, this is documented as the reason no consent banner was needed.

### FR-005: Add CI validation for HTML/link integrity on every push (not just governance-file presence)
- **Description:** The only CI gate that runs on push/PR to `main` is `swarm-gate.yml`, which exclusively validates that `AGENT.md`/`AGENTS.md` exist and contain required schema fields (E-009). No workflow validates HTML syntax, checks for broken internal links, or verifies the sitemap stays in sync with the actual page set on every push — the existing link/sitemap fixes (`CODE_REVIEW_REPORT.md`, `findings.json`) were performed manually in a single one-off remediation session, not enforced continuously. A local script (`run_review.sh`/`run_review.ps1`) exists that performs a broken-link check, but it is not wired into any `.github/workflows/*.yml` trigger.
- **Why It Matters:** Without automated link/sitemap validation on every push, the exact class of bug already found and fixed once (broken blog links, stale sitemap — `findings.json` F-0001/F-0002) can silently regress on the next content edit, since nothing currently blocks a merge that reintroduces it.
- **Verification Evidence:** Full read of all three `.github/workflows/*.yml` files confirms none invoke `run_review.sh`/`run_review.ps1` or perform any HTML/link validation; the script exists in the repo root but has no CI trigger referencing it.
- **Evidence IDs:** E-009, E-024
- **Priority:** P1
- **Category:** CI/CD Reliability
- **ROI Score:** 5/10 — moderate velocity benefit (catches regressions automatically, 15% weight) and trust/UX protection (broken links directly hurt visitor experience and SEO), but no direct revenue unlock.
- **Risk Score:** 2/10 — very low complexity; the validation script already exists and only needs a workflow trigger wrapping it; no migration, no blast radius (CI-only, doesn't touch production).
- **Dependencies:** The existing `run_review.sh` script (already present) can be wrapped in a new or extended GitHub Actions workflow with minimal changes.
- **Competitive Reference:** Standard practice for any static site repo of this size (Jamstack build-time checks; Netlify/Vercel do this by default).
- **Security/Privacy Impact:** None directly; indirectly reduces the risk of shipping broken/misleading pages that could affect user trust.
- **Rollout Readiness:** High — script already exists and is proven to work (used successfully in the 2026-05-12 remediation session per session notes).
- **Validation Gates:**
  - New workflow runs `run_review.sh verify` (or equivalent) on every PR touching `.html`/`sitemap.xml` and fails the build on broken links.
  - A deliberately introduced broken link in a test branch causes the new CI job to fail as expected.
  - Existing `swarm-gate.yml` continues to pass unaffected (no regression to existing governance checks).
- **Acceptance Criteria:**
  - A new `.github/workflows/*.yml` file exists that invokes the existing link-check logic on relevant PRs.
  - CI status shows red on a PR with a known-broken link and green once fixed.
  - Sitemap URL count is asserted to match the actual count of `.html` files in a defined CI step.

### FR-006: Add `prefers-reduced-motion` support for animations
- **Description:** `docs/PRD.md` FR-013 states: "Particle/animation backgrounds MUST degrade gracefully on low-end devices (reduced motion preference respected)." A repo-wide Grep for `prefers-reduced-motion` returns zero matches in any CSS or JS file. The canvas-based particle system (`js/script.js` `initParticles()`), scroll-reveal animations (`IntersectionObserver` blocks in both JS files), and CSS `floating`/`glow-button` animation classes all run unconditionally regardless of the user's OS-level motion preference.
- **Why It Matters:** Users with vestibular disorders or motion sensitivity (a defined WCAG 2.1 Success Criterion 2.3.3 concern) currently have no way to disable the persistent particle animation, testimonial auto-rotation, or scroll-triggered effects — and the site's own PRD names this exact requirement as a MUST, unmet by the current code.
- **Verification Evidence:** Direct Grep for the CSS media feature string across the whole repository (all CSS/JS files) returned zero matches; corroborated by direct reads of `js/script.js`'s `initParticles`, `initScrollAnimations`, and the unconditional `setInterval(nextTestimonial, 5000)` auto-rotation call, none of which check `window.matchMedia('(prefers-reduced-motion: reduce)')`.
- **Evidence IDs:** E-015, E-021
- **Priority:** P1
- **Category:** Accessibility
- **ROI Score:** 4/10 — primarily a trust/UX and compliance concern (15% + partial compliance weight) rather than a revenue driver, but closes a documented PRD requirement gap.
- **Risk Score:** 2/10 — low complexity (a single `matchMedia` check gating existing animation-init calls), no migration, no blast radius beyond the animation code paths themselves.
- **Dependencies:** None — purely additive to existing `js/script.js` and `css/style.css`.
- **Competitive Reference:** WCAG 2.1 AA baseline (referenced in the repo's own `docs/PRD.md` §5 Non-Functional Requirements: "Accessibility... WCAG contrast ratio AA minimum").
- **Security/Privacy Impact:** None.
- **Rollout Readiness:** High — small, isolated, testable change.
- **Validation Gates:**
  - Toggling the OS/browser "reduce motion" setting and reloading the page confirms particle canvas does not render and scroll-reveal elements appear in their final state immediately (no transition).
  - Testimonial carousel auto-rotation is confirmed to stop (or slow significantly) under the reduced-motion media query.
  - No regression to the default (motion-enabled) experience when the OS preference is not set.
- **Acceptance Criteria:**
  - `@media (prefers-reduced-motion: reduce)` block exists in `css/style.css` disabling/shortening all `@keyframes`-based animation and `transition` properties currently used for `floating`, `glow-button`, and scroll-reveal classes.
  - `initParticles()` and the testimonial auto-rotate `setInterval` in `js/script.js` are both gated behind a `window.matchMedia('(prefers-reduced-motion: reduce)').matches` check.
  - `docs/PRD.md` FR-013 status is marked resolved with a reference to the implementing commit.

### FR-007: Expand accessibility attribute coverage beyond the single repeated aria-label
- **Description:** Across `index.html`, only 2 accessibility attributes exist in total, both being the identical `aria-label="Toggle menu"` on the mobile hamburger button (E-014). No `role=` attributes appear anywhere. Interactive elements like the modal close button (`&times;` glyph, no `aria-label`), the carousel dot navigation (`<span class="dot" onclick="...">`, no `role="button"` or `aria-label`), and the testimonial carousel itself (no `aria-live` region to announce rotation to screen-reader users) all lack accessible names/roles.
- **Why It Matters:** `docs/PRD.md` §5 sets "WCAG contrast ratio AA minimum" as a P1 non-functional requirement, and while contrast itself wasn't measured in this static review, the broader accessible-name/role gap is a more foundational WCAG 2.1 concern (SC 4.1.2 Name, Role, Value) that a static markup read directly confirms is unmet for several interactive controls.
- **Verification Evidence:** Grep count of `aria-|role=|alt=|lang=` in `index.html` returned exactly 2 matches, both `aria-label="Toggle menu"`; direct reading of the modal-close button, carousel dots, and waitlist modal markup in `index.html` confirms no accessible-name attributes on any of them.
- **Evidence IDs:** E-014
- **Priority:** P2
- **Category:** Accessibility
- **ROI Score:** 3/10 — narrow user-segment impact (screen-reader/AT users), scored mostly on trust/UX and compliance rather than broad revenue.
- **Risk Score:** 2/10 — low complexity, purely additive markup attributes, no functional risk.
- **Dependencies:** None.
- **Competitive Reference:** WCAG 2.1 AA (same baseline the repo's own PRD cites).
- **Security/Privacy Impact:** None.
- **Rollout Readiness:** High.
- **Validation Gates:**
  - Automated accessibility scan (e.g., axe or Lighthouse accessibility audit, run manually post-implementation) shows a reduced count of "missing accessible name" violations versus a pre-change baseline scan.
  - Manual screen-reader spot-check (VoiceOver/NVDA) confirms the modal-close button and carousel dots announce a meaningful label.
  - No visual regression to the existing design (attributes are non-visual).
- **Acceptance Criteria:**
  - Modal-close button has an `aria-label="Close"` (or equivalent) attribute.
  - Each carousel dot has an `aria-label` identifying which testimonial it selects (e.g., "Testimonial 1 of 3").
  - The testimonial carousel container has an appropriate `aria-live="polite"` (or equivalent pattern) so rotation is announced to assistive technology.

### FR-008: Add automated secret-scanning to CI
- **Description:** No CI workflow performs secret scanning (no gitleaks, detect-secrets, or equivalent tool invocation found in any `.github/workflows/*.yml` file). The only safeguard against committed secrets today is the `.gitignore` file (which excludes `.env*`, `*.key`, `*.pem`, `*.p12`) and manual review — there is no automated gate that would catch, for example, an accidentally-committed live Stripe secret key before it reaches `main`.
- **Why It Matters:** As FR-002 moves this site toward live payment processing, the consequence of an accidentally-committed Stripe secret key rises significantly; a CI-side secret scan is a low-cost safety net that today does not exist.
- **Verification Evidence:** Full read of all three existing `.github/workflows/*.yml` files confirms none invoke gitleaks, detect-secrets, trufflehog, or any similar tool; the repo's own `docs/SECURITY.md` and `.github/copilot-instructions.md` both state "never commit secrets" as a policy, but policy without an automated gate is unenforced.
- **Evidence IDs:** E-009, E-010 (workflow inventory), corroborated by absence noted in `rules/rule_009_secrets.md`'s existence as a policy doc without a corresponding enforcement mechanism
- **Priority:** P1
- **Category:** Security/CI
- **ROI Score:** 4/10 — primarily a risk-mitigation item (20% risk weight) rather than a growth lever; becomes more valuable once FR-002 (live payments) ships.
- **Risk Score:** 2/10 — very low implementation complexity (a single GitHub Action step using an off-the-shelf secret-scanning action), no blast radius, no migration.
- **Dependencies:** None blocking; ideally sequenced before or alongside FR-002 (live Stripe activation) to close the gap before real secret keys are ever handled.
- **Competitive Reference:** SLSA v1.2 and NIST SSDF SP 800-218 both recommend automated secret detection as a baseline supply-chain control; this is a widely adopted CI practice even for simple static sites once any payment/API-key surface exists.
- **Security/Privacy Impact:** Directly reduces the risk of secret leakage reaching a public GitHub repository.
- **Rollout Readiness:** High — off-the-shelf GitHub Action, minimal configuration.
- **Validation Gates:**
  - A test PR containing a deliberately fake "secret-shaped" string (e.g., a dummy `sk_live_` pattern) triggers a CI failure.
  - Existing legitimate content (test-mode Stripe URLs, which are not secrets) does not produce false-positive failures.
  - CI run time impact is confirmed to be minimal (under ~30 seconds added).
- **Acceptance Criteria:**
  - A new or extended workflow step runs a secret-scanning tool on every PR to `main`.
  - The scan is confirmed to catch a synthetic test secret in a throwaway test branch.
  - False-positive rate against current repo content (including the intentional `test_` Stripe links) is zero.

### FR-009: Upload missing referenced image assets (`og-image.jpg`, `logo.png`) or remove the dangling references
- **Description:** `index.html` references `https://anavr.in/images/og-image.jpg` (Open Graph preview image) and `https://anavr.in/images/logo.png` (Schema.org `Organization.logo`), but no `images/` directory exists anywhere in the repository (E-011, E-012). This was already flagged as F-0003 in the repo's own `findings.json`/`CODE_REVIEW_REPORT.md` from the 2026-05-12 remediation session and marked `needs_owner` (not resolved).
- **Why It Matters:** Social shares of any page (Twitter/LinkedIn/Facebook) will render without a preview image, and the Organization JSON-LD structured data has a broken `logo` reference, which can affect how the brand appears in Google's Knowledge Panel / rich results.
- **Verification Evidence:** Glob for `images/**` returns zero results; direct read of `index.html` lines 19 and 41 confirms both broken references still exist as of this review, unchanged since the prior audit flagged them.
- **Evidence IDs:** E-011, E-012
- **Priority:** P2
- **Category:** SEO/Brand
- **ROI Score:** 3/10 — narrow but real impact on social-share conversion and brand presentation; low complexity to fix once assets are provided.
- **Risk Score:** 1/10 — trivial complexity (asset upload + path verification), zero blast radius.
- **Dependencies:** Requires the site owner to supply the actual logo/OG-image files (this is an asset-creation task, not a code task) — already correctly identified as `needs_owner` in the repo's own tracking.
- **Competitive Reference:** Baseline expectation for any commercial site with social sharing in mind.
- **Security/Privacy Impact:** None.
- **Rollout Readiness:** Low — blocked on asset creation/sourcing by the owner, not a readiness issue with the code itself.
- **Validation Gates:**
  - Fetching both image URLs directly (e.g., `https://anavr.in/images/og-image.jpg`) returns HTTP 200 instead of 404.
  - Facebook Sharing Debugger / Twitter Card Validator (manual, post-deploy) shows the image rendering correctly.
  - Schema.org markup validator confirms no broken `logo` URL warning.
- **Acceptance Criteria:**
  - `images/og-image.jpg` (1200x630 per the repo's own `prompt.md` recommendation) and `images/logo.png` both exist and are committed to the repo.
  - Both files are correctly referenced and load without 404 on the live site.
  - `findings.json` F-0003 status is updated from `needs_owner` to `fixed`.

### FR-010: Repair broken cross-references to non-existent `agents/`, `commands/`, `skills/` directories
- **Description:** `codex.md` (lines 58-63) and `.github/copilot-instructions.md` (line 20) both instruct any AI coding agent working in this repo to consult `agents/`, `commands/`, and `skills/` directories for role definitions, available operations, and skill definitions respectively — but none of these three directories exist anywhere in the repository (confirmed via three separate Glob calls, all returning zero results).
- **Why It Matters:** Any AI agent (Copilot, Codex, or another Claude instance) that follows these explicit, authoritative-looking instructions will look for guidance that isn't there, potentially causing confused or degraded agent behavior, or wasted tool calls, when operating in this repo. This is a documentation-integrity gap, not a website functionality gap, but it directly affects the fleet's own stated operating model for this repo.
- **Verification Evidence:** Direct reads of both `codex.md` and `.github/copilot-instructions.md` confirm the references exist as written; three separate Glob searches (`agents/**`, `commands/**`, `skills/**`) each independently returned zero matching files.
- **Evidence IDs:** E-018, E-019
- **Priority:** P2
- **Category:** Documentation/Agent-Tooling Integrity
- **ROI Score:** 3/10 — narrow but real velocity impact (15% weight) for any future agent session in this repo; no direct end-user/revenue impact.
- **Risk Score:** 2/10 — trivial complexity (either create minimal stub directories or remove the dangling references), no blast radius.
- **Dependencies:** None — this is a same-repo documentation consistency fix; if `myskills` (the fleet hub) has a canonical template for these directories, that template could be used, but is out of scope for this standalone review.
- **Competitive Reference:** N/A (fleet-internal documentation hygiene, not a competitive product feature).
- **Security/Privacy Impact:** None.
- **Rollout Readiness:** High.
- **Validation Gates:**
  - After the fix, `codex.md`'s cross-reference table either points to real, existing paths or the rows for non-existent directories are removed.
  - Grep confirms no remaining reference to a directory that Glob shows doesn't exist.
  - A fresh agent session in this repo (simulated) would no longer receive misleading directory pointers.
- **Acceptance Criteria:**
  - Either `agents/`, `commands/`, and `skills/` directories are created with minimal real content, or `codex.md`/`copilot-instructions.md` are edited to remove the false references.
  - No remaining dangling directory reference exists in any governance/agent-manifest file in this repo.
  - The fix is confirmed consistent with whatever pattern the `myskills` hub uses fleet-wide (if accessible in a future cross-repo pass).

### FR-011: Correct `dependabot.yml` ecosystem mismatch (configured for `pip`, but repo has no Python dependency manifest)
- **Description:** `.github/dependabot.yml` configures Dependabot to check for updates on a `pip` package ecosystem at the repo root on a weekly schedule, alongside a `github-actions` ecosystem entry. However, this repo contains no `requirements.txt`, `pyproject.toml`, `Pipfile`, or any other Python dependency manifest anywhere (confirmed via the app-type discovery Glob sweep) — meaning the `pip` entry can never find anything to update and is silently a no-op.
- **Why It Matters:** This is a low-severity but clear misconfiguration, most likely inherited from a copy-pasted template used elsewhere in Michael's fleet (many sibling repos are Python-based per `CLAUDE.md`'s "Most-active sibling repos" list). While harmless today, it's a signal of template drift that could mask a real intent (e.g., if Python tooling for content generation is planned) or simply be dead configuration.
- **Verification Evidence:** Direct read of `.github/dependabot.yml` confirms the `pip` ecosystem block; the app-type discovery phase (Glob for `requirements.txt`, `pyproject.toml`, etc. across the whole tree) found none.
- **Evidence IDs:** E-010, E-002
- **Priority:** P2
- **Category:** CI/Configuration Hygiene
- **ROI Score:** 2/10 — negligible direct impact (a no-op config entry); mostly an opex/cleanliness item (10% weight).
- **Risk Score:** 1/10 — trivial, purely a config file edit.
- **Dependencies:** None.
- **Competitive Reference:** N/A — internal configuration hygiene.
- **Security/Privacy Impact:** None.
- **Rollout Readiness:** High.
- **Validation Gates:**
  - Dependabot's next scheduled run shows no `pip` ecosystem errors/no-op noise in its run log.
  - `github-actions` ecosystem entry (which is legitimately used, per the 3 existing workflow files) continues to function correctly.
- **Acceptance Criteria:**
  - The `pip` ecosystem block is removed from `dependabot.yml`, OR a rationale comment is added explaining why it's intentionally present for future use.
  - `github-actions` ecosystem entry remains intact and unaffected.

### FR-012: Add Subresource Integrity (SRI) or self-host the Google Fonts CDN dependency
- **Description:** All 15 HTML pages load Google Fonts via `<link>` tags to `fonts.googleapis.com`/`fonts.gstatic.com` with no SRI `integrity` attribute (SRI is not applicable to `<link rel="stylesheet">` fetched CSS in the same way as `<script>`, but the broader point — that this is the only external runtime dependency and it's unpinned — still holds via version pinning or self-hosting). `docs/SECURITY.md` itself explicitly recommends: "Use Subresource Integrity (SRI) hashes for any CDN-loaded scripts," but no such hash exists for the current Google Fonts load, and no script-level CDN dependency exists to check either.
- **Why It Matters:** While Google Fonts is a low-risk, high-trust CDN, the repo's own documented security policy calls for SRI on CDN dependencies and the current implementation doesn't follow that self-imposed standard — a self-hosting approach (bundling the woff2 files into `css/` or a new `fonts/` directory) would remove the external dependency and its associated CSP `font-src`/`style-src` allowlist entries entirely, simplifying the CSP.
- **Verification Evidence:** Direct read of `index.html` lines 27-30 (and equivalent blocks in the other 14 HTML files) confirms the `<link rel="preconnect">`/`<link rel="stylesheet">` pattern to the two Google-owned domains, with no integrity/version-pinning mechanism; cross-referenced against `docs/SECURITY.md`'s explicit SRI recommendation.
- **Evidence IDs:** E-003 (CSP allowlist for these domains), corroborated by direct read of `docs/SECURITY.md` "External Dependencies" section
- **Priority:** P2
- **Category:** Security/Performance
- **ROI Score:** 3/10 — minor performance benefit (self-hosting removes a render-blocking third-party DNS lookup) and closes a self-documented policy gap; not a growth driver.
- **Risk Score:** 2/10 — low complexity (font file download + CSS `@font-face` reference update + CSP simplification), no functional risk.
- **Dependencies:** None blocking.
- **Competitive Reference:** Performance-focused static sites commonly self-host fonts to eliminate third-party render-blocking requests and improve Core Web Vitals — directly relevant since `docs/PRD.md` §5 sets an explicit LCP target of "< 2.5s."
- **Security/Privacy Impact:** Self-hosting removes a third-party request that could theoretically be used for user fingerprinting/tracking via the Google Fonts CDN (a commonly cited privacy consideration, notably enforced by a 2022 Munich court ruling under GDPR for EU visitors).
- **Rollout Readiness:** High.
- **Validation Gates:**
  - Visual regression check confirms fonts render identically after self-hosting.
  - CSP `font-src`/`style-src` entries for `fonts.googleapis.com`/`fonts.gstatic.com` are removed and no console CSP violations appear.
  - Lighthouse performance score is re-measured (manually) to confirm no regression, ideally an improvement from removing the external round-trip.
- **Acceptance Criteria:**
  - Font files are hosted within this repo (e.g., under a new `fonts/` directory) and referenced via `@font-face` in `css/style.css`.
  - All 15 HTML files no longer reference `fonts.googleapis.com`/`fonts.gstatic.com`.
  - CSP is simplified accordingly and re-verified against all pages.

### FR-013: Add a formal `SECURITY.md` at the repository root with a defined vulnerability-reporting process
- **Description:** No `SECURITY.md` exists at the repository root (Glob for `SECURITY.md` at root returned zero results); a `docs/SECURITY.md` exists instead with useful content (payment security, CSP guidance, secrets management) but lacks a formal reporting channel — it only says "Contact the repo owner privately. Do not post security vulnerabilities in public issues" with no named contact method, no PGP key, no response-time SLA, and is not in the GitHub-recognized root location that would surface it in GitHub's "Security" tab.
- **Why It Matters:** GitHub surfaces a root-level `SECURITY.md` prominently in its repository UI (a "Security policy" badge/link); having the content only in `docs/` means it's less discoverable to a security researcher who might find an issue with this site (especially once live payments are active per FR-002).
- **Verification Evidence:** Glob confirms no root-level `SECURITY.md`; direct read of `docs/SECURITY.md` confirms the content exists but the reporting-process section is vague (no email, no timeline).
- **Evidence IDs:** E-026
- **Priority:** P2
- **Category:** Security Process
- **ROI Score:** 2/10 — minor risk-reduction and trust signal; low direct business value.
- **Risk Score:** 1/10 — trivial (move/duplicate the file to root, add a contact email).
- **Dependencies:** None.
- **Competitive Reference:** Standard GitHub open-source/commercial-repo hygiene practice.
- **Security/Privacy Impact:** Improves the odds that a real vulnerability report reaches the owner through a proper channel rather than a public issue or nowhere at all.
- **Rollout Readiness:** High.
- **Validation Gates:**
  - GitHub's repository UI shows the "Security policy" indicator once the root file exists.
  - The named contact (e.g., a dedicated `security@anavr.in` alias, distinct from general `hello@anavr.in`) is confirmed to route correctly.
- **Acceptance Criteria:**
  - A `SECURITY.md` file exists at the repository root with a named contact method and an expected response-time commitment.
  - The existing `docs/SECURITY.md` content is either merged into the root file or clearly cross-referenced from it.
  - No regression to any existing content currently in `docs/SECURITY.md`.

## Prioritized Implementation Roadmap

**Phase 1 — Revenue unlock (P0, do first):**
- FR-002 (activate live Stripe payments) — the single highest-value unblock; everything else is secondary until the site can actually sell.
- FR-003 (real email-capture backend) — closes 100% lead-loss on every current form submission; sequence alongside FR-002 since both touch the conversion funnel.

**Phase 2 — Security hardening before/alongside going live (P1):**
- FR-008 (CI secret scanning) — sequence *before* FR-002 completes if possible, so live Stripe keys are never at risk of accidental commit.
- FR-001 (additional HTTP security headers via meta tags).
- FR-004 (privacy-respecting analytics) — needed to measure the PRD's own success metrics once live.
- FR-005 (CI link/HTML validation) — prevents regression of already-fixed issues.
- FR-006 (prefers-reduced-motion support) — closes a specific, named PRD requirement gap.

**Phase 3 — Polish and documentation hygiene (P2):**
- FR-007 (broader accessibility attribute coverage).
- FR-009 (missing image assets — blocked on owner-supplied files).
- FR-010 (fix dangling `agents/`/`commands/`/`skills/` references).
- FR-011 (dependabot ecosystem cleanup).
- FR-012 (self-host fonts / SRI).
- FR-013 (root-level SECURITY.md).

## Top 5 Highest-ROI Features

| FR | Title | ROI | Priority | One-line rationale |
|---|---|---|---|---|
| FR-002 | Activate live Stripe payment processing | 9/10 | P0 | Zero revenue is possible today; this is the direct unlock. |
| FR-003 | Real email-capture backend | 8/10 | P0 | Every current form submission is silently discarded — 100% lead loss. |
| FR-004 | Privacy-respecting analytics | 6/10 | P1 | Unlocks measurement of 3 of the PRD's own 5 stated success goals. |
| FR-005 | CI link/HTML validation | 5/10 | P1 | Cheap, prevents regression of an already-fixed bug class. |
| FR-001 | Additional HTTP security headers | 4/10 | P1 | Low cost, closes a self-documented hardening gap ahead of going live. |

## Validation Plan

Once any FR above is implemented, verify it generically as follows: (1) re-run the same Grep/Glob queries used as evidence in this review against the changed files to confirm the previously-absent pattern now exists (e.g., re-grep for `prefers-reduced-motion` after FR-006 ships and confirm non-zero matches); (2) for anything touching CSP (FR-001, FR-003, FR-004, FR-012), manually load each of the 15 pages in a browser with DevTools open and confirm zero CSP violation console errors; (3) for anything touching payments/forms (FR-002, FR-003), perform one real end-to-end manual transaction/submission and confirm it reaches the expected destination (Stripe dashboard / ESP contact list) rather than relying on code inspection alone; (4) for CI-related FRs (FR-005, FR-008), deliberately introduce the exact failure condition on a throwaway branch (a broken link, a fake secret pattern) and confirm the new gate catches it before merging the fix; (5) re-run this same blitz-review methodology (Grep/Glob evidence sweep) 30-60 days after implementation to confirm no regression and to catch any newly-introduced gaps.

## Executive Summary

anavr.in is a small, well-structured static website for a digital-products storefront brand called Anavrin. It already does several things right: it has a security policy (Content-Security-Policy) on every page, no exposed secrets, clean legal pages, and solid SEO basics like a sitemap and meta tags. However, the site currently cannot make money — every "Buy Now" button points to Stripe's test mode rather than real payment processing, and every email signup form only shows a fake "thank you" message without actually saving anyone's email address anywhere. There's also no way to see how many visitors the site gets, since no analytics tool is installed, despite the site's own planning documents assuming one exists. Most of the other findings are smaller polish items — a missing logo/preview image, some outdated internal documentation pointing to folders that don't exist, and a few accessibility and hardening improvements that are inexpensive to make. The two most urgent, highest-value fixes are turning on real payment processing and connecting the email signup forms to an actual mailing list — until those ship, the site is essentially a very polished brochure that cannot yet convert a visitor into a customer or a lead.
