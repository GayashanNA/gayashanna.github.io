---
layout: page
title: ECSNeT++
description: A simulator for distributed stream processing on edge and cloud environments.
importance: 1
category: Open Source
github: https://github.com/sedgecloud/ECSNeTpp
---

ECSNeT++ is an open source simulation toolkit for modelling Distributed Stream Processing applications that run across edge and cloud computing environments. It came out of my doctoral research at The University of Melbourne, and is published in *Future Generation Computer Systems*. See the <a href="{{ '/publications/' | relative_url }}">publications</a> page for the paper.

Evaluating stream processing on real edge infrastructure is expensive and slow. You need the devices, the network between them, and the patience to redeploy everything each time you want to try a different task placement. ECSNeT++ lets you ask those questions in simulation first. You define an application topology, configure a placement plan, and observe the processing delays, message sizes, and network behaviour that come out of it.

It is built on <a href="https://omnetpp.org/">OMNeT++</a> and the INET framework, so the networking is modelled properly rather than approximated, including wireless and LTE links between edge devices. Data sources, processing operators, and device characteristics are all configurable.

The <a href="https://sedgecloud.github.io/ECSNeTpp/">documentation site</a> has the tutorial and API reference, and the source is on <a href="https://github.com/sedgecloud/ECSNeTpp">GitHub</a>.
