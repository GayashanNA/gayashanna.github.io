---
layout: page
title: NEM Constraint Watch
description: Modelling AEMO NEM constraints, and predicting which ones are about to bind.
img: assets/img/projects/nem/dashboard.jpg
importance: 1
category: Energy
---

A personal project that models network and FCAS constraints in Australia's National Electricity Market. It tracks which constraint equations exist, what state each one is in, and which are about to bind. It runs live at <a href="https://nem.amrsnghe.org">nem.amrsnghe.org</a> and refreshes every dispatch interval.

Constraints decide what generators are allowed to dispatch, and what that dispatch is worth. So knowing which constraint is about to bind, and what it is likely to cost, is useful. AEMO publishes all the data needed to work this out, but not in a form that answers the question directly. That gap is what the project fills.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/projects/nem/dashboard.jpg" title="NEM Constraint Watch dashboard" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    The hour ahead view. Constraints are ranked by their probability of binding within 60 minutes, alongside headroom, a 24 hour sparkline, and expected price impact.
</div>

## What it does

**Ingest.** Downloads and parses AEMO MMS CSV reports from NEMWeb into a local DuckDB database. That covers 5 minute `DISPATCHCONSTRAINT` actuals, `P5MIN` and `PREDISPATCH` constraint forecasts, and the generic constraint standing data (`GENCONDATA`, the `SPD*` LHS factors, RHS term formulations, constraint sets and invocations).

**Model.** Reconstructs each constraint equation from its parts: the operator, the left hand side terms with their factors over units, interconnectors and regions, and the right hand side. From there it computes per interval state, including headroom, binding, violated, and swamped.

**Predict.** Builds features from headroom dynamics, binding history, and AEMO's own short horizon forecasts, then classifies "binds within the next hour" with a scikit-learn model. Walk forward backtesting reports watchlist precision@K and lead time distribution against persistence, `P5MIN`, and headroom rank baselines.

**Compare.** Scores the model against AEMO's own forecasts, with pre-dispatch and ST PASA skill broken down by forecast lead time out to seven days.

## Stack

Python 3.12 with `uv`, DuckDB for storage and analytics, pandas, scikit-learn, a Typer CLI, pydantic, and httpx. Tests run offline against CSV fixtures with pytest, and linting is handled by ruff. It ships as a Docker image and runs on AWS Lightsail behind Caddy for automatic HTTPS, deployed by GitHub Actions on merge.

The source is not public at the moment. The dashboard is, and it runs entirely on public AEMO data.
