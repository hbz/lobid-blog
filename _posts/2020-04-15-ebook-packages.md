---
layout: post
title: "Verbesserte Metadaten zur Zugehörigkeit von Titeln zu E-Book-Paketen"
author: Adrian Pohl
date: 2020-04-15
tags: lobid-resources
---

Kürzlich haben wir auf [Anfrage der UB Dortmund](https://github.com/hbz/lobid-resources/issues/1052) Angaben zu E-Books in lobid-resources ergänzt, auch wenn das entsprechende E-Book-Paket nicht im ISIL-Verzeichnis enthalten ist. Im hbz-Wiki findet sich eine [Übersicht über alle E-Book-Pakete im hbz-Verbundkatalog](https://service-wiki.hbz-nrw.de/display/VDBE/Produktsigel+und+interne+Selektionskennzeichen) mit Angabe ihrer ID – sei es eine ISIL oder eine interne ID.

Schon vorher gab es in Titeln, die einem E-Book-Paket mit ISIL zugehören, einen Verweis auf das jeweilige Paket. Zum Beispiel zeigt sich in den Metadaten zum E-Book "Gottlob Frege: Schriften zur Logik und Sprachphilosophie" ([https://lobid.org/resources/HT020405841](https://lobid.org/resources/HT020405841)), dass es zu zwei E-Book-Paketen gehört:

```json
{
   "inCollection":[
      {
         "id":"http://lobid.org/organisations/ZDB-196-MPB#!",
         "type":[
            "Collection"
         ],
         "label":"eResource package"
      },
      {
         "id":"http://lobid.org/organisat<ions/ZDB-196-MEL#!",
         "type":[
            "Collection"
         ],
         "label":"eResource package"
      }
   ]
}
```

Die neuen Angaben zu Paketen, die keine ISIL haben, sehen entsprechend aus. Ein Beispieltitel ist [https://lobid.org/resources/HT020045788](https://lobid.org/resources/HT020045788) ([JSON](https://lobid.org/resources/HT020045788.json)) mit diesen Angaben:

```json
{
   "inCollection":[
      {
         "id":"https://lobid.org/collections#wbv",
         "label":"W. Bertelsmann Verlag E-Books"
      }
   ]
}
```

In diesem Beispiel sind die Metadaten sogar deskriptiver als im obigen Beispiel, weil der Kollektionsname angezeigt wird. Allerdings haben wir nicht alle Namen konfigurieren können, so dass es manchmal aussieht wie in diesem [Beispiel](https://lobid.org/resources/CT007001558) ([JSON](https://lobid.org/resources/CT007001558.json)):

```json
{
   "inCollection":[
      {
         "id":"https://lobid.org/collections#ldd",
         "label":"collections#ldd"
      },
      {
         "id":"https://lobid.org/collections#vl-ddbk",
         "label":"collections#vl-ddbk"
      }
   ]
}
```

Die `label`-Angabe sollte allerdings ohnehin nie zu Query-Zwecken benutzt werden, sondern allein für die Anzeige. Zuverlässig ist in Abfragen allein die Nutzung von URIs (`id`).

## Beispielsuche

Mit den neuen Angaben ist es möglich, jedes E-Book-Paket einzeln zu durchsuchen, hier z. B. eine Suche nach "Bibliothek" in allen über die Nationallizenzen erworbenen Paketen:

[`inCollection.id:"https://lobid.org/collections#NLZ" AND bibliothek`](http://lobid.org/resources/search?q=inCollection.id%3A%22https%3A%2F%2Flobid.org%2Fcollections%23NLZ%22+AND+bibliothek)