<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="en" data-theme="dark">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Sitemap — Debloat</title>
        <style>
          :root {
            color-scheme: dark;
            /* Debloat theme tokens (static/css/theme.css), layout from 301-ui static/sitemap.xsl */
            --bg: #0B0F0D;
            --bg-elevated: #111916;
            --bg-soft: #162019;
            --text-main: #E7EDE9;
            --text-muted: #8FA99A;
            --text-subtle: #6E8A7B;
            --primary: #10B981;
            --primary-soft: rgba(16, 185, 129, 0.1);
            --primary-hover: #34D399;
            --border-subtle: rgba(255, 255, 255, 0.06);
            --border-strong: rgba(255, 255, 255, 0.14);
            --input-border: var(--border-strong);
            --input-bg: rgba(11, 15, 13, 0.9);
            --bg-success: #042C1C;
            --success: #18C27A;
            --radius-xs: 0.25rem;
            --radius: 0.5rem;
            --radius-lg: 0.75rem;
            --r-pill: 999px;
            --space-1: 0.25rem;
            --space-2: 0.5rem;
            --space-3: 0.75rem;
            --space-4: 1rem;
            --space-5: 1.5rem;
            --space-6: 2rem;
            --font-sans: system-ui, -apple-system, BlinkMacSystemFont, "SF Pro Text", "Segoe UI", sans-serif;
            --font-mono: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace;
          }

          /* Project defaults to dark theme regardless of system preference */

          * { box-sizing: border-box; }

          html, body {
            margin: 0;
            min-height: 100%;
            background: var(--bg);
            color: var(--text-main);
            font-family: var(--font-sans);
            font-size: 14px;
            line-height: 1.55;
          }

          body { padding: var(--space-5) var(--space-4); }

          a { color: var(--primary-hover); text-decoration: none; }
          a:hover, a:focus { text-decoration: underline; }

          .shell {
            width: min(980px, 100%);
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: var(--space-4);
          }

          .page-header { display: flex; flex-direction: column; gap: var(--space-2); }
          .page-header h1 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-main);
          }
          .page-header p {
            margin: 0;
            color: var(--text-muted);
            max-width: 48rem;
          }
          .page-header .meta {
            display: flex;
            gap: var(--space-3);
            color: var(--text-subtle);
            font-size: 0.82rem;
            margin-top: var(--space-1);
          }
          .page-header .meta strong { color: var(--text-main); font-weight: 600; }

          /* Fieldset-group pattern (matches src/css/site.css) */
          .fieldset-group {
            border: 1px solid var(--input-border);
            border-radius: var(--radius);
            padding: var(--space-3);
            margin: 0;
            background: var(--bg-elevated);
          }
          .fieldset-group > legend {
            padding: 0 var(--space-2);
            margin-left: calc(var(--space-2) * -1);
            color: var(--text-main);
            font-size: 0.78rem;
            font-weight: 600;
            letter-spacing: 0.04em;
            text-transform: uppercase;
          }

          .url-list {
            display: flex;
            flex-direction: column;
            gap: 1px;
            background: var(--border-subtle);
            border-radius: var(--radius-xs);
            overflow: hidden;
          }
          .url-row {
            display: grid;
            grid-template-columns: minmax(16rem, 1fr) auto auto;
            gap: var(--space-3);
            align-items: center;
            padding: var(--space-2) var(--space-3);
            background: var(--bg-elevated);
          }
          .url-row:hover { background: var(--bg-soft); }
          .url-row__link {
            font-family: var(--font-mono);
            font-size: 0.84rem;
            color: var(--text-main);
            min-width: 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
          }
          .url-row__link:hover, .url-row__link:focus { color: var(--primary-hover); }

          .langs { display: inline-flex; flex-wrap: wrap; justify-content: flex-end; gap: var(--space-1); max-width: 34rem; }
          .lang {
            display: inline-flex;
            align-items: center;
            padding: 2px 6px;
            border-radius: var(--radius-xs);
            background: transparent;
            color: var(--text-subtle);
            font-family: var(--font-mono);
            font-size: 0.72rem;
            border: 1px solid var(--border-subtle);
          }
          a.lang:hover, a.lang:focus {
            color: var(--primary-hover);
            border-color: var(--primary-soft);
            text-decoration: none;
          }
          .lang.current {
            background: var(--primary-soft);
            color: var(--primary-hover);
            border-color: transparent;
            font-weight: 600;
          }

          .lastmod {
            font-family: var(--font-mono);
            font-size: 0.72rem;
            color: var(--text-subtle);
            white-space: nowrap;
          }

          .note {
            color: var(--text-subtle);
            font-size: 0.82rem;
            margin: 0;
          }
          .note strong { color: var(--text-muted); }

          @media (max-width: 640px) {
            body { padding: var(--space-3); }
            .url-row {
              grid-template-columns: 1fr;
              gap: var(--space-2);
              padding: var(--space-3);
            }
            .lastmod { order: -1; }
          }
        </style>
      </head>
      <body>
        <main class="shell">
          <header class="page-header">
            <h1>Sitemap</h1>
            <p>Public pages of debloat.click for search engines: the home page and the guides in up to 21 languages. Each entry is a canonical URL; the chips are its hreflang alternates.</p>
            <div class="meta">
              <span><strong><xsl:value-of select="count(sitemap:urlset/sitemap:url | sitemap:sitemapindex/sitemap:sitemap)"/></strong> entries</span>
              <span>rendered via XSL</span>
            </div>
          </header>

          <xsl:choose>
            <xsl:when test="sitemap:urlset">
              <fieldset class="fieldset-group">
                <legend>URL Set</legend>
                <div class="url-list">
                  <xsl:for-each select="sitemap:urlset/sitemap:url">
                    <div class="url-row">
                      <a class="url-row__link" href="{sitemap:loc}">
                        <xsl:value-of select="sitemap:loc"/>
                      </a>
                      <xsl:if test="xhtml:link[@rel='alternate']">
                        <div class="langs">
                          <xsl:variable name="current-loc" select="sitemap:loc"/>
                          <xsl:for-each select="xhtml:link[@rel='alternate' and @hreflang != 'x-default']">
                            <xsl:choose>
                              <xsl:when test="@href = $current-loc">
                                <span class="lang current"><xsl:value-of select="@hreflang"/></span>
                              </xsl:when>
                              <xsl:otherwise>
                                <a class="lang" href="{@href}"><xsl:value-of select="@hreflang"/></a>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </div>
                      </xsl:if>
                      <xsl:if test="sitemap:lastmod">
                        <span class="lastmod"><xsl:value-of select="sitemap:lastmod"/></span>
                      </xsl:if>
                    </div>
                  </xsl:for-each>
                </div>
              </fieldset>
            </xsl:when>
            <xsl:otherwise>
              <fieldset class="fieldset-group">
                <legend>Sitemap Index</legend>
                <div class="url-list">
                  <xsl:for-each select="sitemap:sitemapindex/sitemap:sitemap">
                    <div class="url-row">
                      <a class="url-row__link" href="{sitemap:loc}">
                        <xsl:value-of select="sitemap:loc"/>
                      </a>
                      <xsl:if test="sitemap:lastmod">
                        <span class="lastmod"><xsl:value-of select="sitemap:lastmod"/></span>
                      </xsl:if>
                    </div>
                  </xsl:for-each>
                </div>
              </fieldset>
            </xsl:otherwise>
          </xsl:choose>

          <p class="note"><strong>Note:</strong> search engines consume the raw XML structure. The stylesheet affects browser presentation only and does not change sitemap semantics.</p>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
