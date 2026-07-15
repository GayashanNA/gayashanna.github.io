# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Gayashan Amarasinghe's personal website — a Jekyll site built on the [al-folio](https://github.com/alshedivat/al-folio) theme, forked and heavily trimmed. Published at `gn.amrsnghe.org` (see `CNAME`) via GitHub Pages.

The site is positioned industry-first: data engineering and Australian energy market work lead, with the PhD and publications as supporting credentials. The upstream theme's blog, news, teaching, and repositories features have all been removed — don't reintroduce them without asking.

Because this is a fork of an actively maintained upstream theme, prefer changing content over theme internals; theme edits make future upstream merges painful. The content lives in `_config.yml`, `_pages/`, `_data/cv.yml`, `_bibliography/papers.bib`, `_projects/`, and `assets/img/`.

## Commands

```bash
bundle install                # needs Ruby 3.2.x (CI pins 3.2.1) + ImageMagick
bundle exec jekyll serve      # http://localhost:4000
bundle exec jekyll build
```

Docker alternatives (no local Ruby), both serve on `:8080` and delete `Gemfile.lock` first:

```bash
docker-compose up                        # prebuilt image amirpourmand/al-folio
docker-compose -f docker-local.yml up    # build the local Dockerfile instead
```

Note the system Ruby on macOS is 2.6 with no gems, so a local `bundle exec` needs a real toolchain first — Docker is usually the faster path. `Gemfile.lock` is gitignored, so CI resolves gem versions fresh on every run; an upstream gem release can break a build with no code change here.

There are no tests and no linter. `.pre-commit-config.yaml` only wires whitespace/YAML hygiene hooks (`pre-commit install` to enable).

## Deployment

Pushing to `master` triggers `.github/workflows/deploy.yml`, which builds with Ruby 3.2.1 and publishes `_site` to `gh-pages`. Pull requests build without deploying — that PR build is the only real test of `Gemfile` changes. **Do not commit `_site` or `gh-pages` by hand.** `bin/deploy` is the legacy manual path and force-pushes `gh-pages`; don't run it unless CI is broken and the user asks.

## Architecture

Standard Jekyll, but these contracts fail *silently* when violated — worth knowing before editing.

**The CV is data-driven, and there is no PDF.** `_data/cv.yml` is a top-level array of sections; `_layouts/cv.html` renders one card per element and dispatches on `type` to an include in `_includes/cv/`. Only four types exist — anything else falls through and dumps Ruby-inspect garbage:

| type | contract |
|---|---|
| `map` | `contents: [{name:, value:}]` |
| `list` | `contents: ["str"]` — **strings only** |
| `nested_list` | `contents: [{title:, items: ["str"]}]` — reads **`items`** |
| `time_table` | `contents: [{year:, title:, institution:, description: [...]}]` |

In `time_table`, each `description` element is either a plain string or `{title:, contents: ["str"]}` for one level of sub-bullets. Max depth 2. The keyword changes at every level (`contents` → `description` → `contents`), which is the main way to get this wrong.

**The trap:** indenting a `- ` under a plain string item is *not* nesting — YAML folds it into the same scalar and it renders as a run-on bullet with a literal `- `. Always use the `{title:, contents: []}` form. Validate with:

```bash
ruby -ryaml -e 'YAML.load_file("_data/cv.yml")'
```

`_pages/cv.md` is front matter only. It deliberately has no `cv_pdf` — the CV is web-only and `assets/pdf/` no longer exists. `_layouts/cv.html` guards on `{% if page.cv_pdf %}`, so re-adding the key is all it would take to bring the download icon back.

**Projects.** `_projects/*.md` → `/projects/:path/`, so the filename is the URL slug; `importance` (ascending, within category) drives sort order, not the filename. `_pages/projects.md` declares `display_categories: [energy, open source]` — **a project whose `category` isn't an exact string match is silently dropped from the index** while still building its own page. `img` is a full path including `assets/img/` and the extension (unlike `about.md`'s `profile.image`, which is a bare filename). Omitting `img` is a supported state and yields a clean text-only card. `redirect:` makes the whole card link off-site and strands the project page — deliberately unused here. `github_stars` is dead (no JS backs it) and `enable_tooltips` is false.

**Publications are generated from BibTeX.** `jekyll-scholar` renders `_bibliography/papers.bib` through `_layouts/bib.html`. Years are derived from the bib by `_plugins/publication-years.rb` (a `priority :high` generator that sets `site.data['bib_years']`), so adding a paper in a new year Just Works — `_pages/publications.md` no longer hardcodes a year list, though `years:` in its front matter still overrides. **An entry with no `year` field renders nowhere**, since the page partitions by year. Non-standard bib fields (`selected`, `abbr`, `pdf`, `code`, `preview`…) drive rendering; `filtered_bibtex_keywords` strips them back out of the displayed BibTeX via `_plugins/hideCustomBibtex.rb`. `selected={true}` entries surface on the landing page via `selected_papers: true` in `_pages/about.md`.

**Custom plugins** in `_plugins/` (these run because CI builds the site, not GitHub's restricted Pages builder): `publication-years.rb`, `details.rb` (a `{% details %}` block tag), and `hideCustomBibtex.rb`.

**Landing page.** `_layouts/about.html` toggles on `_pages/about.md` front matter: `profile`, `selected_papers`, `goodreads`, `social`. The Goodreads widget lives in `_includes/goodreads.html` with the user id in `_config.yml` (`goodreads_user_id`) — keep it that way; it used to be hardcoded inline in the layout, which is the kind of fork divergence that breaks upstream merges.

**Styles** are SCSS in `_sass/`, compiled through `assets/css/main.scss`. `_themes.scss` + `assets/js/theme.js` do light/dark via CSS custom properties — new colors belong in `_variables.scss`/`_themes.scss`, not hardcoded in a component. `_distill.scss` is dead but still imported; harmless.

`imagemagick.enabled` is `false`, so no responsive WebP variants are generated and `_includes/figure.html` serves the original. Downscale large images offline instead.
