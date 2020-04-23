---
layout: post
title: "Gemeinfreie Werke in lobid finden"
author: Adrian Pohl
tags: lobid-resources
---

Wir haben ein Anfrage bekommen, ob lobid benutzt werden könnte, um eine Liste von Titeln im Bestand einer bestimmten Bibliothek zu generieren, die mit hoher Wahrscheinlichkeit gemeinfrei sind. In diesem Beitrag werden zunächst die einzelnen Schritte ohne weitere Erklärung aufgezeigt und im Anschluss der Aufbau einer entsprechenden Abfrage erläutert.

---
## Kurzanleitung

Dies sind die Schritte, wenn ich im Bestand einer bestimmten Bibliothek eine Liste von Titeln browsen möchte, die mit recht hoher Wahrscheinlichkeit gemeinfrei sind (weil alle verzeichneten beteiligten vor dem 1.1.1950 gestorben sind) und nicht schon in einer Online-Version vorliegen:

1. Zu [lobid-resources](https://lobid.org/resources/) gehen und in das Suchfenster folgendes einfügen bzw. einfach den Link klicken: [`NOT contribution.agent.dateOfDeath:[1950-01-01 TO *] AND _exists_:contribution.agent.dateOfDeath AND NOT medium.id:"http://rdaregistry.info/termList/RDACarrierType/1018"`](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath+AND+NOT+medium.id%3A%22http%3A%2F%2Frdaregistry.info%2FtermList%2FRDACarrierType%2F1018%22)
2. Im Bestandsfilter meine Bibliothek wählen, z.B. UB Wuppertal: <img src="/images/gemeinfreie-titel-finden/bestandsfilter.png" alt="Bestandsfacette mit Auswahl der Bibliothek 'Wuppertal UB'" style="width:250px">
3. Nach Bedarf weitere Filter anwenden (Erscheinungsjahr, Publikationstyp, Medientyp etc.) oder die Abfrage durch eine Volltextsuche in den Metadaten erweitern durch Voranstellen des Suchworts und eines `AND`, z.B.:
[`seuche AND NOT contribution.agent.dateOfDeath:[1950-01-01 TO *] AND _exists_:contribution.agent.dateOfDeath AND NOT medium.id:"http://rdaregistry.info/termList/RDACarrierType/1018"`](https://lobid.org/resources/search?q=seuche+AND+NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath+AND+NOT+medium.id%3A%22http%3A%2F%2Frdaregistry.info%2FtermList%2FRDACarrierType%2F1018%22)

---

## Die Abfrage im Detail

Die Gemeinfreiheit eines Werkes beginnt jeweils in dem Jahr, das auf den 70. Todestag der Urheber\*innen folgt. Das heißt, 2020 sind alle Werke gemeinfrei geworden, deren Urheber\*innen 1949 gestorben sind. In der Wikipedia gibt es etwa zu beginn jedes Jahres eine neue Liste der Urheber\*innen, deren Werke gemeinfrei geworden sind. Mittlerweile wird diese Liste aus eine Wikidata-Anfrage automatisch generiert, siehe z.B. die [Liste von Urheberinnen und Urhebern, deren Werke am 1. Januar 2020 in Public Domain übergingen](https://de.wikipedia.org/wiki/Wikipedia:Public_Domain_Day/2020_in_Public_Domain). Etwas ähnliches wollen wir also auf Basis von lobid machen, nur, dass nicht Urheber\*innen, sondern deren Werke (bzw. Druckausgaben) gelistet sind.  

 Das heißt, wir müssen die Titel in lobid-resources danach filtern, ob die dazu Beitragenden vor oder in 1949 gestorben sind. Da wir die Lebensdaten aus der GND übernehmen, ist dies mit einer einzelnen Abfrage möglich. Da lobid auf Elasticsearch basiert, nutzen wir für unsere Abfragen die [Elasticsearch Query String Syntax](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/query-dsl-query-string-query.html#query-string-syntax).
 
 Zunächst schauen wir uns ein Beispiel an, um herauszufinden, wie wir unsere Abfrage formulieren müssen: ["Gone with the Wind"](https://lobid.org/resources/HT015046968) von Margaret Mitchell, die am 16.8.1949 starb. Dort findet sich Angaben zum Sterbedatum wie folgt in den [JSON-Daten](https://lobid.org/resources/HT015046968.json).

 ```json
{
   "contribution":[
      {
         "type":[
            "Contribution"
         ],
         "agent":{
            "id":"https://d-nb.info/gnd/118734202",
            "type":[
               "Person"
            ],
            "label":"Mitchell, Margaret",
            "altLabel":[
               "Mičel, Margaret",
               "Marsh, Margaret Mitchell",
               "Митчелл, Маргарет",
               "Mitchell, Margret",
               "Miqier, ...",
               "Mitčell, Margaret",
               "Mitchel Marsh, Margaret Munnerlyn",
               "Mitchell, Margaret Munnerlyn"
            ],
            "dateOfBirth":"1900",
            "dateOfDeath":"1949",
            "gndIdentifier":"118734202"
         },
         "role":{
            "id":"http://id.loc.gov/vocabulary/relators/cre",
            "label":"Autor/in"
         }
      }
   ]
}
 ```

Wie man sieht findet sich das Todesjahr im Feld `contribution.agent.dateOfDeath`. Wir müssten also einfach alle Titel rausfiltern, die dort einen Wert größer als 1949 stehen haben. Die entsprechende Abfrage sieht wie folgt aus, wobei wir die [range query](https://www.elastic.co/guide/en/elasticsearch/reference/5.6/query-dsl-query-string-query.html#_ranges) verwenden:

[`NOT contribution.agent.dateOfDeath:[1950-01-01 TO *]`](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D)

Das sind über 19 Millionen Titel und der gesamte hbz-Verbundkatalog beinhaltet gut 21 Millionen Titel. Da scheint also etwas mit unserer Abfrage nicht zu stimmen. Das zugrundeliegende Problem ist, dass in [17 Millionen Titeln](http://lobid.org/resources/search?q=NOT+_exists_%3Acontribution.agent.dateOfDeath) das entsprechende Feld gar nicht vorhanden ist (und dementsprechend bei einer `NOT`-Abfrage in der Ergebnisliste auftauchen). Also sollten wir unsere gesamte Analyse also nur auf jene gut 4 Millionen Titel anwenden, bei denen sich überhaupt eine Angabe zum Sterbedatum der beteiligten Personen findet. Mit einer `_exists_`-Abfrage kann ich auf alle Titel einschränken, in denen ein bestimmtes Feld gegeben ist:

[`_exists_:contribution.agent.dateOfDeath`](https://lobid.org/resources/search?q=_exists_%3Acontribution.agent.dateOfDeath)

Mit dieser Einschränkung kann ich nun Titel identifizieren, die mit großer Wahrscheinlichkeit gemeinfrei sind, weil das Todesdatum der Beitragenden vor dem 1. Januar 1950 liegt. Das sind gut zwei Millionen Titel:

[`NOT contribution.agent.dateOfDeath:[1950-01-01 TO *] AND _exists_:contribution.agent.dateOfDeath`](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath)


## Bereits digitalisierte Titel herausfiltern

Wenn man auf der Suche ist nach gemeinfreien Werken, die es sich zu digitalisieren lohnt, kann es sinnvoll sein, die Online zugänglichen Ressourcen herauszufiltern, weil es sich dabei in der Regel um bereits digitalisierte gemeinfreie Titel handelt:

[`NOT contribution.agent.dateOfDeath:[1950-01-01 TO *] AND _exists_:contribution.agent.dateOfDeath AND NOT medium.id:"http://rdaregistry.info/termList/RDACarrierType/1018"`](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath+AND+NOT+medium.id%3A%22http%3A%2F%2Frdaregistry.info%2FtermList%2FRDACarrierType%2F1018%22)

## Filtern nach Bestand

Das sind also gut 2 Millionen Titel im gesamten hbz-Verbundkatalog, die man sich nun genauer anschauen kann. Zum Beispiel kann diese Abfrage jetzt weiter nach Bestand gefiltert werden. Dies geht am bequemsten über den Bestandsfilter in der Benutzeroberfläche mit dem `owner`-Parameter, z.B. [gemeinfreie Titel im Bestand der UB Wuppertal](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath+AND+NOT+medium.id%3A%22http%3A%2F%2Frdaregistry.info%2FtermList%2FRDACarrierType%2F1018%22&owner=DE-468). Ich kann auch einfach nach Bestand in mehreren Bibliotheken filtern, indem ich in der Benutzeroberfläche mehrere Filter setze oder im `owner`-Parameter durch Komma getrennt mehrere ISILs angebe, z.B. [`owner=DE-464,DE-465M,DE-465`](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath+AND+NOT+medium.id%3A%22http%3A%2F%2Frdaregistry.info%2FtermList%2FRDACarrierType%2F1018%22&owner=DE-464,DE-465M,DE-465).

Komplizierter wird es, wenn ich den Bestand nach ISIL mit einer Wildcard filtern muss, z.B. um den Bestand in [allen Instituts- und Fachbereichsbibliotheken der WWU Münster]([isil:DE-6-*](http://lobid.org/organisations/search?q=isil%3ADE-6-*)) abzudecken. Da der `owner`-Parameter nicht mit Wildcard funktioniert, muss ich eine Query auf das entsprechend Feld machen. Hier die Bestandsangabe aus einem [Beispieltitel](https://lobid.org/resources/HT016153937):

```json
{
   "hasItem":[
      {
         "id":"http://lobid.org/items/HT016153937:DE-6-015:Ks%201488%2F11#!",
         "type":[
            "Item"
         ],
         "heldBy":{
            "id":"http://lobid.org/organisations/DE-6-015#!",
            "label":"lobid Organisation"
         },
         "note":"00017001",
         "callNumber":"Ks 1488/11",
         "label":"Ks 1488/11"
      }
   ]
}
```

Die entsprechende Abfrage aller der Universität Münster zugeordneten Bibliotheken sieht wie folgt aus:

[`hasItem.heldBy.id:http\:\/\/lobid.org\/organisations\/DE-6-*`](https://lobid.org/resources/search?q=hasItem.heldBy.id%3Ahttp%5C%3A%5C%2F%5C%2Flobid.org%5C%2Forganisations%5C%2FDE-6-*)

Allerdings fehlt darin noch die ULB Münster selbst (DE-6). Sie kann wie folgt ergänzt werden:

[`hasItem.heldBy.id:(http\:\/\/lobid.org\/organisations\/DE-6-* OR "http://lobid.org/organisations/DE-6#!")`](https://lobid.org/resources/search?q=hasItem.heldBy.id%3A%28http%5C%3A%5C%2F%5C%2Flobid.org%5C%2Forganisations%5C%2FDE-6-*+OR+%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-6%23%21%22%29)

Hier die komplette Abfrage nach gemeinfreien Werken, eingeschränkt auf die ULB Münster und die :

[`NOT contribution.agent.dateOfDeath:[1950-01-01 TO *] AND _exists_:contribution.agent.dateOfDeath AND NOT medium.id:"http://rdaregistry.info/termList/RDACarrierType/1018" AND hasItem.heldBy.id:(http\:\/\/lobid.org\/organisations\/DE-6-* OR "http://lobid.org/organisations/DE-6#!")`](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath+AND+NOT+medium.id%3A%22http%3A%2F%2Frdaregistry.info%2FtermList%2FRDACarrierType%2F1018%22+AND+hasItem.heldBy.id%3A%28http%5C%3A%5C%2F%5C%2Flobid.org%5C%2Forganisations%5C%2FDE-6-*+OR+%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-6%23%21%22%29)
