---
layout: post
title: "Ein Protokoll für den Datenabgleich im Web am Beispiel von OpenRefine und der Gemeinsamen Normdatei (GND)"
author: Adrian Pohl
tags: lobid-gnd
---

<img src="/images/recon-article-screenshot.png" alt="Screenshot mit bibliographischen Angaben des Beitrags von der De-Gruyter-Webseite.">

Bereits im Oktober 2021 wurde der Sammelband [Qualität in der Inhaltserschließung](https://doi.org/10.1515/9783110691597), herausgegeben von Michael Franke-Maier, Anna Kasprzik, Andreas Ledl und Hans Schürmann, veröffentlicht, in dem auch ein Beitrag aus dem lobid-Team mit dem Titel <a href="https://doi.org/10.1515/9783110691597-013">Ein Protokoll für den Datenabgleich im Web am Beispiel von OpenRefine und der Gemeinsamen Normdatei (GND)</a> enthalten ist.

Wir bedanken uns bei den Herausgeber:innen für die gute Kommunikation und insgesamt gute Arbeit an dem Sammelband (<a href="https://www.uebertext.org/2014/03/sammelband-herausgeben-gelernt.html">ich weiß wovon ich spreche</a>). Das Ergebnis kann sich sehen lassen und ist – wie sich das gehört – Open Access zugänglich, was auch eine Bedingung von uns und anderen Autor:innen für einen Beitrag war. 

## Zusammenfassung

Normdaten spielen als externe Datenquellen eine wichtige Rolle für die Qualität der Inhaltserschließung. OpenRefine ermöglicht über eine Reconciliation-API den Abgleich eigener Daten mit externen Datenquellen. Das hbz stellt mit lobid-gnd eine solche Datenquelle für die GND bereit. Dieser Beitrag stellt nach einer Einordnung der Reconciliation für die Inhaltserschließung die Möglichkeiten der Reconciliation-API anhand ihrer Verwendung in OpenRefine zum Abgleich mit der GND dar. Anschließend wird als Ausblick die Arbeit der Entity Reconciliation Community Group des W3C vorgestellt, in der ein Protokoll zur Standardisierung dieser Funktionalität entwickelt wird.

Der Beitrag behandelt so die Qualität des Datenaustauschs (speziell die Beschreibung und Verbesserung des Protokolls selbst im Rahmen einer Standardisierung), die Qualität von Datensätzen im Kontext anderer Datensätze (speziell die Einheitlichkeit der Verknüpfung und Ermöglichung von Datenanreicherung durch Nutzung von Normdaten statt der Verwendung von Freitext), sowie die Qualität von Werkzeugen und Algorithmen (speziell von Werkzeugen, die das Protokoll nutzen, konkret OpenRefine, sowie durch das Protokoll ermöglichte Arbeitsabläufe).


