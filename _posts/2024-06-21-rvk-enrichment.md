---
layout: post
title: "RVK-Anreicherung durch Culturegraph-Aggregationen"
date: 2024-06-17
author: Tobias Bülte, Pascal Christoph
tags: lobid-resources
---

Seit [2018 steht die Idee im Raum](https://github.com/hbz/lobid-resources/issues/819) die lobid-resources Daten um Inhaltserschließung anderer Verbünde mit Hilfe von [Culturegraph](https://hub.culturegraph.org/page/about) anzureichern. Damals war der Stand der Entwicklung von Culturegraph und ihrer aggregierten Daten für diesen Anwendungsfall noch nicht ausreichend, da die Daten nicht ausreichend häufig aktualisiert wurden.

2020 hatte H.G. Becker das auf der lobid-resources-API aufbauende [Discovery System der TU Dortmund mit RVK-Klassifikationen angereichert]( https://katalog.ub.tu-dortmund.de/taxonomy/tree ).
Dazu gab es einen Austausch, aus welchem das [Issue 1058](https://github.com/hbz/lobid-resources/issues/1058) hervorging, das die 2 Jahre ältere Idee wieder aufgriff und konkretisierte.

Dieses Jahr haben wir endlich die Anreicherungsroutine der GND-Daten mit RVK-Daten umgesetzt. Dafür nutzen wir die von den Verbünden aggregierten [Culturegraph-Daten](https://data.dnb.de/culturegraph/).

Aus der Aggregation erstellen wir eine ca. 300 MB große zweispaltige "key-value" TSV-Datei.
Mittels dieser Datei werden die Verbunddaten bei ihrer Transformation von MARCXML zum lobid JSON-LD [per Lookup angereichert](https://github.com/hbz/lobid-resources/pull/2024/files#diff-020b061fcaa03198b32e4683b6bc3321cf890ec08ded8cc43cd88ea8a0514b3fL328).
Die erste Spalte ist der Schlüssel ("key") und besteht aus der ALMA-MMS-IDs des hbz. In der zweiten Spalte stehen die damit assozierten RVK-Notationen ("value"). Sind mehrere Notationen assoziert, so sind diese mit Komma getrennt und werden während des Lookups iteriert und entsprechend dann tatsächlich als "Ein Feld - ein Wert" in den lobid Daten verspeichert.

Durch die Anreicherung steigt die Anzahl der mit RVK versehenen Records von 1,5 auf knapp 7 Millionen.

[Ein Beispiel](https://lobid.org/resources/990062574560206441):

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

Wie zu sehen ist, sind diese angereicherten Notationen aktuell nicht als
solche ausgewiesen - es steht dort unter "source" lediglich, dass sie aus
der "Regensburger Verbundklassifikation" stammen, jedoch lässt sich nicht
erkennen, ob die Notationen direkt aus dem hbz-Verbundkatalog stammen oder
eben aus der Culturegraph-Aggregation. Das lobid-Datenmodell lässt diese
Differenzierung nicht ohne größere Anpassung zu.
Zugleich ist aber die Frage, ob die Anreicherung
der Notationen überhaupt ein Problem für die Nachnutzung darstellt und als
solche ausgewiesen sein muss.

