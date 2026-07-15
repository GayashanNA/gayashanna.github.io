# gn.amrsnghe.org

Personal website of Gayashan Amarasinghe — [gn.amrsnghe.org](https://gn.amrsnghe.org).

Built with [Jekyll](https://jekyllrb.com/) on the [al-folio](https://github.com/alshedivat/al-folio) theme (MIT).

## Develop

Needs Ruby 3.2.x and Bundler:

```bash
bundle install
bundle exec jekyll serve     # http://localhost:4000
```

Or without a local Ruby:

```bash
docker-compose -f docker-local.yml up   # http://localhost:8080
```

## Content

| What | Where |
|---|---|
| Landing page | `_pages/about.md` |
| CV | `_data/cv.yml` (rendered by `_layouts/cv.html`) |
| Projects | `_projects/*.md` |
| Publications | `_bibliography/papers.bib` |

See `CLAUDE.md` for architecture notes and the gotchas worth knowing before editing.

## Deploy

Pushing to `master` builds via GitHub Actions and publishes `_site` to the `gh-pages` branch. Pull requests build without deploying.
