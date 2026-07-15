---
layout: page
title: ECSNeT++
description: A simulator for distributed stream processing on edge and cloud environments.
importance: 1
category: open source
github: https://github.com/sedgecloud/ECSNeTpp
---

ECSNeT++ is an open-source simulation toolkit for modelling Distributed Stream Processing applications running across edge and cloud computing environments. It came out of my doctoral research at the University of Melbourne, and is published in *Future Generation Computer Systems* — see the <a href="{{ '/publications/' | relative_url }}">publications</a> page.

Evaluating stream processing on real edge infrastructure is expensive and slow: you need the devices, the network between them, and a willingness to redeploy everything each time you want to try a different task placement. ECSNeT++ lets you ask those questions in simulation first — define an application topology, configure a placement plan, and observe the processing delays, message sizes, and network behaviour that result.

It is implemented on top of <a href="https://omnetpp.org/">OMNeT++</a> and the INET framework, so the networking is modelled properly rather than approximated — including wireless and LTE links between edge devices. Data sources, processing operators, and device characteristics are all configurable.

Visit the <a href="https://sedgecloud.github.io/ECSNeTpp/">documentation site</a> for the tutorial and API reference, or the <a href="https://github.com/sedgecloud/ECSNeTpp">repository</a> for the source.
