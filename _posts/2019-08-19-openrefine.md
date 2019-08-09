---
layout: post
title: "Improved GND reconciliation for OpenRefine"
date: 2019-08-19
author: Fabian Steeg
tags: lobid-gnd
---

Triggered by the newly formed [W3C Entity Reconciliation Community Group](https://www.w3.org/community/reconciliation/) and its [reconciliation service test bench](https://reconciliation-api.github.io/testbench/) we have improved our GND reconciliation for OpenRefine by implementing the [OpenRefine suggest API](https://github.com/OpenRefine/OpenRefine/wiki/Suggest-API) for searching types, properties, and entities.

When selecting a custom type in the reconciliation dialog, matching types are suggested:

![7-2](/images/2018-08-27-openrefine/07-type-custom.png)

Data from other columns can be used to improve reconciliation results by selecting a suggested property:

![8](/images/2018-08-27-openrefine/08-other.png)

Candidates can be matched by selecting suggested entities:

![10](/images/2018-08-27-openrefine/10-search.png)

Properties are also suggested when adding columns from reconciled values:

![8](/images/2018-08-27-openrefine/12-add-suggest.png)

For complete usage instructions check out our updated documentation on [GND reconciliation for OpenRefine](http://blog.lobid.org/2018/08/27/openrefine.html).