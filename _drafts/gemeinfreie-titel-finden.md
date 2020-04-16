layout: post
title: "Gemeinfreie Werke in lobid finden"
date: 2020-04-20
author: Adrian Pohl
tags: lobid-resources
---

Wir haben ein Anfrage bekommen, ob lobid benutzt werden könnte, um eine Liste von Titeln im Bestand einer bestimmten Bibliothek zu generieren, die mit hoher Wahrscheinlichkeit gemeinfrei sind. Die Gemeinfreiheit eines Werkes beginnt jeweils in dem Jahr, das auf den 70. Todestag des Urhebers folgt. Das heißt, 2020 sind alle Werke gemeinfrei geworden, deren Urheber 1949 gestorben ist. In der Wikipedia gibt es etwa zu beginn jedes Jahres eine neue Liste der Urheber\*innen, deren Werke gemeinfrei geworden sind. Mittlerweile wird diese Liste aus eine Wikidata-Anfrage automatisch generiert, siehe z.B. die [Liste von Urheberinnen und Urhebern, deren Werke am 1. Januar 2020 in Public Domain übergingen](https://de.wikipedia.org/wiki/Wikipedia:Public_Domain_Day/2020_in_Public_Domain). Etwas ähnliches wollen wir also auf Basis von lobid machen, nur, dass nicht Urheber\*innen, sondern deren Werke (bzw. Druckausgaben) gelistet sind.  

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

Das sind über 19 Millionen Titel und der gesamte hbz-Verbundkatalog beinhaltet gut 21 Millionen Titel. Da scheint also etwas nicht zu stimmen. Das zugrundeliegende Problem ist, dass in [17 Millionen Titeln](http://lobid.org/resources/search?q=NOT+_exists_%3Acontribution.agent.dateOfDeath) das entsprechende Feld gar nicht vorhanden ist. Wir können unsere gesamte Analyse also nur auf jene gut 4 Millionen Titel anwenden, bei denen sich überhaupt eine Angabe zum Sterbedatum der beteiligten Personen findet. Zu diesem zweck benutzen wir eine `_exists_`-Abfrage:

[`NOT contribution.agent.dateOfDeath:[1950-01-01 TO *] AND _exists_:contribution.agent.dateOfDeath`](https://lobid.org/resources/search?q=NOT+contribution.agent.dateOfDeath%3A%5B1950-01-01+TO+*%5D+AND+_exists_%3Acontribution.agent.dateOfDeath)


Das sieht schon besser aus. Es sind gut zwei Millionen Titel, die sich in lobid-resources als wahrscheinlich gemeinfrei identifizieren lassen.