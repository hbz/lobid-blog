---
layout: post
title: "ETL-Umstellung des hbz ALMA-Katalogs: von Metafacture-Morph zu
Metafacture-Fix"
author: Tobias Bülte, Pascal Christoph
date: 2023-03-02
tags: lobid-resources
---

lobid-resources exponiert zwei APIs, die auf den hbz-Katalog zugreifen:
1. API, die auf den [Aleph-Daten beruht](https://lobid.org/resources/)
2. API, die auf den [Alma-Daten beruht](https://alma.lobid.org/resources/)

Hintergrund ist die Migration der Datenhaltung von Aleph nach Alma.
Kürzlich haben wir dabei den ETL Prozess, der die alma-lobid-resources-API ermöglicht, von der Transformationssprache ["metafacture-morph" nach "metafacture-fix" gewechselt](https://github.com/hbz/lobid-resources/issues/1434).
Grundlage sind die Aleph-MARC-XML Daten ...
