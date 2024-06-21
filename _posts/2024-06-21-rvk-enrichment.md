---
layout: post
title: "RVK-Anreicherung durch Culturegraph-Aggregations"
date: 2024-06-17
author: Tobias Bülte
tags: lobid-resources
---

Seit 2018 steht die Idee im Raum die lobid-resources Daten um Inhaltserschließung anderer Verbünde mit Hilfe von Culturegraph anzureichern. Damals war der Stand der Entwicklung von Culturegraph und ihrer Aggregierten Daten (HIER LINK?) für diesen Anwendungsfall noch nicht ausreichend.
2020 hatte H.G. Becker von der TU Dortmund darauf hingewiesen, dass er die nachgenutzen lobid-resources Daten für sein Discovery System mit RVK-Klassifikationen.
Dieses Jahr haben wir endlich die Anreicherungsroutine der GND-Daten mit RVK-Daten umgesetzt. Dafür nutzen wir die aggregierten Culturegraph-Daten, die die verschiedenen Verbunddaten zusammenführt. Aus den Culturegraph-Daten erstellen wir eine zweispaltige TSV-Datei von ALMA-MMS-IDs des hbz und den RVK-Notationen. Mit Hilfe dieser Datei werden die Verbunddaten bei ihrer Transformation von MARCXML zum lobid jsonld per Lookup angereichert.

Durch die Anreicherung steigt die Anzahl der mit RVK versehenen Records von 1,5 auf knapp 7 Millionen.

Ein Beispiel: http://lobid.org/resources/990062574560206441.json

```JSON
{
          "notation": "XB 3592",
          "type": [
                "Concept"
          ],
          "source": {
                "label": "RVK (Regensburger Verbundklassifikation)",
                "id": "https://d-nb.info/gnd/4449787-8"
          }
 
    }
```

Die angereicherten Notationen werden aktuell nicht als solche ausgewiesen, da das Datenmodell dies nicht ohne große Anpassung zulässt. Zugleich ist aber die Frage, ob die Anreicherung der Notationen überhaupt ein Problem für die Nachnutzung darstellt und als solche ausgewiesen sein muss.
