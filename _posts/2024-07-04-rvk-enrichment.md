---
layout: post
title: "RVK-Anreicherung mit Hilfe von Culturegraph"
date: 2024-07-04
author: Tobias Bülte, Pascal Christoph
tags: lobid-resources
---

### Eine sechs Jahre alte Idee

Seit [2018 steht die Idee im Raum](https://github.com/hbz/lobid-resources/issues/819) die lobid-resources-Daten um Inhaltserschließung anderer Verbünde mit Hilfe von [Culturegraph](https://hub.culturegraph.org/page/about) anzureichern. Damals reichte der Stand der Entwicklung von Culturegraph und ihrer aggregierten Daten für diesen Anwendungsfall noch nicht aus, da die Daten nicht  häufig genug aktualisiert wurden.

2020 hatte H.G. Becker das auf der lobid-resources-API aufbauende [Discovery System der TU Dortmund mit RVK-Notationen angereichert]( https://katalog.ub.tu-dortmund.de/taxonomy/tree ).
Dazu gab es einen Austausch, aus welchem das [Issue 1058](https://github.com/hbz/lobid-resources/issues/1058) hervorging, das die zwei Jahre ältere Idee wieder aufgriff und konkretisierte.

Dieses Jahr haben wir endlich die Anreicherungsroutine der GND-Daten mit RVK-Daten umgesetzt. Dafür nutzen wir die von den Verbünden aggregierten [Culturegraph-Daten](https://data.dnb.de/culturegraph/).

### Implementierung

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

### Verzicht auf Provenienzangaben

Wie zu sehen ist, sind diese angereicherten Notationen aktuell nicht als solche ausgewiesen, d.h. es gibt keine direkten Angaben zur Provenienz der angereicherten RVK-Notationen. Es wird lediglich – wie bei den intellektuell vergebenen RVK-Notationen – allgemein angegeben, dass sie aus der "Regensburger Verbundklassifikation" stammen. Wir haben diskutiert, ob diese Anreicherungen besser als solche markiert werden sollten und es sogar eine Möglichkeit geben sollte sie herauszufiltern. Das lobid-Datenmodell lässt das aber nicht ohne größere nicht rückwärtskompatible Anpassungen zu. Da wir davon ausgehen, dass es sich hier um ein Feature für alle Nutzer:innen handelt und eine Filtermöglichkeit deshalb nicht nötig ist, haben wir uns für die jetzige leichtgewichtige Umsetzung entschieden. Lasst uns gerne [im metadaten.community-Forum](https://metadaten.community/t/anreicherung-von-hbz-verbunddaten-lobid-resources-mit-culturegraph/402) wissen, was ihr davon haltet und meldet euch, falls es doch Probleme in eurer Anwendung macht.