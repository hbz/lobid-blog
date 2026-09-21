---
layout: post
title: "Tagesgenaue Löschungen bei lobid-resources"
date: 2026-09-21
author: Tobias Bülte
tags: lobid-resources
---


Bei lobid-resources transformieren wir die local gepublishten MARCXML-Daten aus dem ALMA-Bibliothekssystem des hbz-Verbunds zu JSON-LD und indexieren diese in einen ElasticSearch Index. Jedes Wochenende wird der Index aus einem Vollabzug der ALMA-Daten neuerzeugt. Ergänzend werden täglich Updates indexiert. Dabei wurden aktuell bei den Updates Löschungen nicht berücksichtigt und erst beim Neuerzeugen des Indexes am Wochenende berücksichtigt.

Das Team des Digitalen Verbundkatalog, der auf lobid-resources aufbaut, hat von NRW-Bibliotheken die Anfrage erhalten, die Löschungen im Index tagesaktuell zu halten.

Letzte Woche wurde das Feature durch das lobid-Team fertiggestellt. Somit sind ab sofort gelöschte Titel am nächsten Tag nicht mehr im Index enthalten.