---
layout: post
title: "Tagesgenaue Löschungen bei lobid-resources"
date: 2026-09-22
author: Tobias Bülte
tags: lobid-resources
---

Für den [lobid-resources](https://lobid.org/resources)-Dienst, der die hbz-Verbunddaten als Linked Open Data bereitstellt, transformieren wir aus dem ALMA-Bibliothekssystem gepublishte MARC-XML-Daten zu JSON-LD und indexieren dieses in einen Elasticsearch-Index (siehe auch [Lobid API 2.0: Why and how](https://blog.lobid.org/2017/06/08/lobid-api-why-how.html)).

Jedes Wochenende wird der Index aus einem Vollabzug der ALMA-Daten neu aufgebaut. Ergänzend werden täglich Updates indexiert. Dabei wurden bisher bei den täglichen Updates keine Löschungen und die entsprechenden Titel verschwanden also erst beim Neuerzeugen des Indexes am Wochenende.

Das Team der DigiBib, die den lobid-resources-Index für die Suche in den Verbunddaten nutzt, hatte von Verbundbibliotheken die Anfrage erhalten, die Löschungen im Index tagesaktuell zu halten. Letzte Woche wurde das Feature durch das lobid-Team fertiggestellt (siehe [lobid-resources-Ticket #2357](https://github.com/hbz/lobid-resources/issues/2357)). Somit sind ab sofort gelöschte Titel am nächsten Tag nicht mehr im Index enthalten.
