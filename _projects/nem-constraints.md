---
layout: page
title: NEM Constraints
description: Modelled AEMO NEM constraints, and predicted which ones were about to bind.
img: assets/img/projects/nem/dashboard.jpg
importance: 1
category: Energy
---

**This project has been wound down** and the dashboard at nem.amrsnghe.org is no longer online. While it ran, it refreshed every dispatch interval.

A personal project that modelled network and FCAS constraints in Australia's National Electricity Market. It tracked which constraint equations existed, what state each one was in, and which were about to bind.

Constraints decide what generators are allowed to dispatch, and what that dispatch is worth. So knowing which constraint is about to bind, and what it is likely to cost, is useful. AEMO publishes all the data needed to work this out, but not in a form that answers the question directly. That gap is what the project filled.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/projects/nem/dashboard.jpg" title="NEM Constraints dashboard" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    The hour ahead view. Constraints were ranked by their probability of binding within 60 minutes, alongside headroom, a 24 hour sparkline, and expected price impact.
</div>

## What it did

**Ingest.** Downloaded and parsed AEMO MMS CSV reports from NEMWeb into a local DuckDB database. That covered 5 minute `DISPATCHCONSTRAINT` actuals, `P5MIN` and `PREDISPATCH` constraint forecasts, and the generic constraint standing data (`GENCONDATA`, the `SPD*` LHS factors, RHS term formulations, constraint sets and invocations).

**Model.** Reconstructed each constraint equation from its parts: the operator, the left hand side terms with their factors over units, interconnectors and regions, and the right hand side. From there it computed per interval state, including headroom, binding, violated, and swamped.

**Predict.** Built features from headroom dynamics, binding history, and AEMO's own short horizon forecasts, then classified "binds within the next hour" with a scikit-learn model. Walk forward backtesting reported watchlist precision@K and lead time distribution against persistence, `P5MIN`, and headroom rank baselines.

**Compare.** Scored the model against AEMO's own forecasts, with pre-dispatch and ST PASA skill broken down by forecast lead time out to seven days.

## Stack

Python 3.12 with `uv`, DuckDB for storage and analytics, pandas, scikit-learn, a Typer CLI, pydantic, and httpx. Tests ran offline against CSV fixtures with pytest, and linting was handled by ruff. It shipped as a Docker image and ran on AWS Lightsail behind Caddy for automatic HTTPS, deployed by GitHub Actions on merge.

The source was never public. The dashboard was, and it ran entirely on public AEMO data.
