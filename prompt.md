# Remediation Prompt Map - anavr.in

Maps 1:1 to findings.json. Run: bash run_review.sh verify

## F-0001 (High | maintainability) Broken blog links - FIXED
Verify: grep -oE 'blog/[a-z0-9_-]+\.html' blog.html | sort -u | xargs -n1 test -f

## F-0002 (Medium | compliance) Stale sitemap - FIXED
Verify: grep -c '<url>' sitemap.xml returns 15

## F-0003 (Low | compliance | needs_owner) Missing image assets
Owner uploads images/og-image.jpg (1200x630), images/logo.png

## F-0004 (Info | architecture | needs_owner) Business functions
Tracked in audit/technical_debt.md
