---
layout: post
title: "Elasticsearch distance scoring"
date: 2016-12-09
author: Fabian Steeg
tags: lobid-organisations
---

In our [organisations directory beta](https://beta.lobid.org/organisations) we were sorting results by distance to the user, if they share their location. [Adrian noticed](https://github.com/hbz/lobid-organisations/issues/280) that this yields confusing results, since the relevance ranking is completely overridden by the distance sorting. A quick research in the fabulous [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/guide/current/sorting-by-distance.html#scoring-by-distance) revealed that we actually want to _score_ results by distance, not _sort_ by distance.

The basic solution was straight-forward: [implement a scoring function](https://github.com/hbz/lobid-organisations/commit/6cf93d84bb88248573b9714d9107151177809740#diff-fdebe9b141e34cc47158f8b5ce8dbf80L322) that scores the results returned by the regular query based on their distance to the user's location. We did encounter one issue though: not all our organisations have geo coordinates, and for those with a missing `location.geo` field Elasticsearch gives a perfect score.

Elasticsearch might provide [a way to specify a value for missing fields](https://github.com/elastic/elasticsearch/issues/18892) in the future, but in the meantime, there's a [documented workaround](https://github.com/elastic/elasticsearch/issues/18892#issuecomment-226544977) that works fine. For our specific setup though, the fact that the workaround includes a script led to some more overhead: we run Elasticsearch in embedded mode and disabled Groovy scripting. So instead of a simple line in the JSON, we implemented it as [a native script in Java](https://github.com/hbz/lobid-organisations/blob/6cf93d84bb88248573b9714d9107151177809740/app/controllers/Zero.java). It's [registered when creating the `Node`](https://github.com/hbz/lobid-organisations/commit/6cf93d84bb88248573b9714d9107151177809740#diff-b98324f209179b7ef27fbd183c238193R63).

Once again I'm impressed with all the stuff Elasticsearch offers, it's a fantastic tool.
