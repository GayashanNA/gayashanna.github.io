---
layout: page
title: NEM Constraint Watch
description: Modelling AEMO NEM constraints, and predicting which ones are about to bind.
img: assets/img/projects/nem/dashboard.jpg
importance: 1
category: energy
---

A personal project that models network and FCAS constraints in Australia's National Electricity Market: which constraint equations exist, what state they are in right now, and which ones are about to bind. It runs live at <a href="https://nem.amrsnghe.org">nem.amrsnghe.org</a>, refreshing every dispatch interval.

Constraints are where the physics of the grid meets the economics of the market. When a constraint binds, it changes what generators can dispatch and what that dispatch is worth — so knowing *which* constraint is about to bind, and how much it will cost, is genuinely useful information. AEMO publishes everything needed to work this out, but not in a form that answers the question directly.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/projects/nem/dashboard.jpg" title="NEM Constraint Watch dashboard" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    The hour-ahead view: constraints ranked by probability of binding within 60 minutes, with headroom, a 24-hour sparkline, and expected price impact.
</div>

## What it does

**Ingest.** Downloads and parses AEMO MMS CSV reports from NEMWeb into a local DuckDB database — 5-minute `DISPATCHCONSTRAINT` actuals, `P5MIN` and `PREDISPATCH` constraint forecasts, and the generic constraint standing data (`GENCONDATA`, the `SPD*` LHS factors, RHS term formulations, constraint sets and invocations).

**Model.** Reconstructs each constraint equation from its parts — the operator, the left-hand side terms with their factors over units, interconnectors and regions, and the right-hand side — then computes per-interval state: headroom, binding, violated, and swamped.

**Predict.** Builds features from headroom dynamics, binding history, and AEMO's own short-horizon forecasts, and classifies "binds within the next hour" with a scikit-learn model. Walk-forward backtesting reports watchlist precision@K and lead-time distribution against persistence, `P5MIN`, and headroom-rank baselines.

**Compare.** Scores the model against AEMO's own forecasts, with pre-dispatch and ST PASA skill broken down by forecast lead time out to seven days.

## Stack

Python 3.12 with `uv`, DuckDB for storage and analytics, pandas, scikit-learn, a Typer CLI, pydantic, and httpx. Tested with pytest against offline CSV fixtures, linted with ruff. It ships as a Docker image and runs on AWS Lightsail behind Caddy for automatic HTTPS, deployed by GitHub Actions on merge.

The source isn't public at the moment — but the dashboard is, and it runs on entirely public AEMO data.
