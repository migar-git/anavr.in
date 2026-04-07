# Contributing to anavr.in

## Local Development

```bash
python -m http.server 8080
# or
npx serve .
```

Open `http://localhost:8080` in your browser.

## Adding a Product Page

1. Create `products/your-product-slug.html` (copy an existing product page as template).
2. Link it from `index.html` product grid.
3. Add to `sitemap.xml`.
4. Update pricing in both the product page and any listing pages.

## Adding Blog Content

1. Create the article in `blog/` directory.
2. Update `blog.html` with the article card.
3. Add to `sitemap.xml`.

## Updating Prices

Search for the price string across HTML files — update all instances consistently.

## Deployment

Push to `main` branch. See root `DEPLOYMENT.md` for full deploy process including custom domain and payment configuration.

## Standards

- Use `rel="noopener noreferrer"` on external links.
- Keep product copy honest — no fabricated testimonials.
- Do not commit payment processor secret keys or webhook secrets.
