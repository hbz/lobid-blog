---
layout: post
title: "Ideen: NRW-Quiz auf Grundlage der NWBib-Daten für Coding da Vinci"
date: 2019-10-22
author: Pascal Christoph
tags: nwbib
---

Nach dem Besuch des ["Coding da Vinci Westfalen-Ruhrgebiet 2019"](https://codingdavinci.de/events/westfalen-ruhrgebiet/) entstand die Idee, auf Grundlage des von uns zur Verfügung gestellten [Datensets](https://codingdavinci.de/daten/#hochschulbibliothekszentrum-des-landes-nordrhein-westfalen) ein NRW-Quiz zu machen. Die Daten sind die Grundlage für die [Nordrhein-Westfälische Bibliographie (NWBib)](https://nwbib.de).

Die Möglichkeiten zur Nutzung der NWBib-Daten haben wir in ["NWBib-Daten für Coding da Vinci"](http://blog.lobid.org/2019/10/08/nwbib-at-cdv.html) beschrieben.

# Die Idee(n)
Es sind eigentlich mehrere Ideen. Je nach Aufwand und Lust zur Umsetzung reicht es, auch nur eine davon umzusetzen.

Der Knackpunkt ist, dass alle Antworten des Quiz automatisiert erzeugbar sind, aufgrund von explizitem Wissen in einem Datensatz
oder aufgrund von statistischen Auswertungen über das gesamte Datenset. Die anderen, "falschen" Antworten lassen sich ebenfalls automatisch erzeugen.

Hier ein paar Ideen:

Auf einer Karte von Nordrhein-Westfalen werden die größeren Städte mit einem Marker versehen, je nach Spiel randomisiert oder alle auf einmal. Wenn auf einen Marker
geklickt wird, erscheint eine Quizfrage, die auf Basis der Daten erzeugt wird (technische Details später). Zum Beispeil könnte eine Frage zu "Köln" heißen:

"Für was ist Köln am bekanntesten?"

1. Freilichtbühne
2. Zeche Zollern II/IV
3. Dom
4. Technische Universität
5. Westfälischer Frieden

Nach 10 Fragen ist das Spiel zu Ende => Eintrag in die Highscore-Liste.

Mögliche Variationen:
* es sind zwei Modi möglich: 1. der Ort ist auf der Karte anzuklicken (der Expertenmodus)  oder 2. Multiple-Choice (der leichte Modus)
* auch kleinere Städte mit einbeziehen
* eingrenzen auf "die bekannteste Person/Bauwerke/..." (hierzu lassen sich zumeist auch Bilder anzeigen. Eine weitere Variante wäre, nur die Portraits zu zeigen statt der Namen.)
* reverse, also die Antwort wird gezeigt, und die Spielerin muss den passenden Ort aussuchen
* Ende des Spiels nach zwei falsche Antworten. Wer kommt am weitesten?
* ...

Ein guter Einstieg wäre, nur Ortsbegriffe zu verwenden und dazu ein Bild aus der Wikidata zu der Stadt einzublenden.
Die beiden oben erwähnenten Modi würde also so aussehen:

1. Einsteigermodus:  eine Liste von Städten ist zum Aussuchen vorgegeben (Multiple-Choice)
2. Expertenmodus: die ungefähre Lokalisation muss durch einen Klick auf der Karte ausgesucht werden

Die Daten für dieses Einstiegsszenario lassen sich komplett aus der Wikidata holen, da alle Orte in Wikidata eine NWBib Property haben (z.B. [Bonn](https://www.wikidata.org/wiki/Q586), such dort nach "NWBib ID).

Hier ein Beispiel für Dortmund:
<a href="https://www.wikidata.org/wiki/Q1295">![Photozuordnung](/images/nrw-quiz-idee/1043px-North_Rhine-Westphalia_topographic_map_01V_Photo-Dortmund.svg.png "Photozuordnung auf der Karte für Dortmund")</a>

Das Quizfenster rechts unten impliziert die zweite Variante, d.h. es sind eigentlich zwei Spielideen verknüpft:
der Multiple-Choice Test ist sicherlich einfacher zu lösen, und würde in dieser komplexen Quizidee mit nur der Hälfte der Punkte belohnt
bei richtiger Antwort.

Für spannendere, weitere Fragen muss auf die lobid-API mit den NWBib-Daten zugegriffen werden.
Das wird im Folgenden beschrieben.

Die Kartenvisualisierungen sähen dabei ähnlich aus wie das "Dortmund"-Beispiel.

## Technische Details

Hier einige Details zum Einstieg, teilweise entnommen aus dem [voherigen Beitrag](http://blog.lobid.org/2019/10/08/nwbib-at-cdv.html). Bei Bedarf können wir das noch ausführlicher dokumentieren mit Queries und Programmschnippseln zum Filtern der Ergebnisse.

### NWBib-Ortssystematik und Wikidata

[96% aller NWBib-Titel haben einen Bezug zu einem Ort](https://lobid.org/resources/search?q=_exists_%3Aspatial+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Fresources%2FHT014176012%23%21%22), d.h. sie behandeln als Thema einen Landkreis, einen Stadtteil, einen Kirchenkreis, eine Grafschaft etc. Der Ortsbezug eines Eintrags findet sich im `spatial`-Objekt, siehe z.B. [https://lobid.org/resources/HT019559235.json](https://lobid.org/resources/HT019559235.json):

```json
{
   "spatial":[
      {
         "focus":{
            "id":"http://www.wikidata.org/entity/Q1295",
            "geo":{
               "lat":51.513888888889,
               "lon":7.4652777777778
            },
            "type":[
               "http://www.wikidata.org/entity/Q22865",
               "http://www.wikidata.org/entity/Q1549591",
               "http://www.wikidata.org/entity/Q253030",
               "http://www.wikidata.org/entity/Q707813",
               "http://www.wikidata.org/entity/Q42744322"
            ]
         },
         "id":"https://nwbib.de/spatial#Q1295",
         "type":[
            "Concept"
         ],
         "label":"Dortmund",
         "notation":"05913000",
         "source":{
            "id":"https://nwbib.de/spatial",
            "label":"Raumsystematik der Nordrhein-Westfälischen Bibliographie"
         }
      }
   ]
}
```

Die `id` im `spatial`-Objekt (im Beispiel `https://nwbib.de/spatial#Q1295`) verweist auf einen Eintrag in der [NWBib-Raumsystematik](https://nwbib.de/spatial), die alle Orte hierarchisch gliedert, auf die NWBib-Titel Bezug nehmen. Mit `spatial.focus.id` wird der entsprechende Wikidata-Eintrag zu dem Ort angegeben (hier `http://www.wikidata.org/entity/Q1295`).\* Zudem finden sich im `spatial.focus`-Objekt Geokoordinaten aus Wikidata und die Klassen, denen das Wikidata-Objekt zugeordnet wurde. Über die Links können weitere Informationen bei Wikidata geholt werden.

### Kartenvisualisierung auf Basis der Orts- und Geodaten aus Wikidata

#### Beispiel: Wofür ist "Gelsenkirchen am bekanntesten?"

Die Karte wird gezeigt mit Fokus auf Gelsenkirchen. Die Antwort auch die Frage "Wofür ist Gelsenkirchen am bekanntesten?" lässt sich automatisch aus der [raumbezogene Abfrage](https://nwbib.de/search?location=&q=spatial.id%3A%22https%3A%2F%2Fnwbib.de%2Fspatial%23Q2765%22) ableiten: das
Schlagworte "FC Schalke 04" steht ganz oben (in den Query-Results müssen die herausgefiltert werden, die sich selbst zum Gegenstand haben, z.B. hier also "Gelsenkirchen"). Die entsprechende API-Abfrage, um an die häufigsten Schlagworte zu gelangen, die in den Metadadten der Publikationen über "Gelsenkirchen" stehen, ist:

```
curl -L 'lobid.org/resources/search?q=spatial.id%3A"https%3A%2F%2Fnwbib.de%2Fspatial%23Q2765"&format=json&aggregations=subject.id%2Csubject.componentList.id&size=1' |jq .aggregation
```

Das Ergebnis sieht wie folgt aus:

```
{
  "subject.componentList.id": [
    {
      "doc_count": 641,
      "key": "https://d-nb.info/gnd/4019947-2"
    },
    {
      "doc_count": 105,
      "key": "https://d-nb.info/gnd/2037491-4"
    },
    {
      "doc_count": 54,
      "key": "https://d-nb.info/gnd/4069716-2"
    },
```

Wenn nun den gnd-IDs gefolgt wird, zeigt sich, dass der erste Eintrag für "Gelsenkirchen" steht (und folglich ignoriert werden muss, da es der Suchbegriff selbst ist)
und am zweithäufigsten mit 105 Treffern der Begriff "FC Schalke 04".
(Hier bestünde ebenfalls die Möglichkeit, ein Bild zu erhalten, das für diesen Sportverein steht:
Die GND-ID gibt es auch in Wikidata, und somit auch in der API der lobid-gnd. Um ein Bild zum Begriff zu bekommen kann diese ID einfach an diese API angehangen werden: [https://lobid.org/gnd/2037491-4](https://lobid.org/gnd/2037491-4). Dort ist, ebenfalls in JSON serialisiert, die URL zur Grafik hinterlegt, einmal also große Datei (`depiction.id`) und sogar als thumbnail (`depiction.thumbnail`). Ob für alle resp. für wie viele möglichen Begriffe im Quiz auch Bilder vorhanden sind, wäre zu untersuchen.)

#### Beispiel: "Suchwort Erraten"

Mit den oben beschriebenen Wikidata-Ortsdaten in der NWBib lassen sich mit wenig Aufwand Visualisierungen erstellen, z.B. eine [Karte mit Raumbezügen](http://blog.lobid.org/data/nwbib-at-cdv.html) zu bestimmten Suchanfragen (die HTML-Datei enthält die komplette Umsetzung und kann als Ausgangsbasis für eigene Ideen verwendet werden). Als Quiz würde dann gefragt:

"Um was für ein Suchwort hat es sich wohl gehandelt?"

1. FC Schalke
2. Tagebau
3. Malerei
4. Beethoven
5. Heimatmuseum


#### Beispiel Reverse-Quiz

Welche Stadt ist am bekanntesten für "Malerei"?
Dabei muss auf das [Schlagwort "Malerei" eingegrenzt](https://nwbib.de/search?q=subject.componentList.id%3A%22https%3A%2F%2Fd-nb.info%2Fgnd%2F4037220-0%22) werden. Auf der rechten Seite der Trefferliste steht unter "Regionen" mit 601 Treffer "Düsseldorf" ganz oben.

### Probleme

Es ist so: die Datengrundlage entscheidet. Die Fragen müssten also korrekterweise nicht lauten "Für was ist diese Stadt am bekanntesten?"
sondern "Welches Schlagwort zu Publikationen über diese Stadt kommt am häufigsten in der NWBib vor?".

Durch mehr Erfahrungen mit den Daten lässt sich, konsekutiv, das Quiz verbessern:
In einer Alpha-Version erscheinen oft unpassende Schlagworte. Vielen ist gemeinsam, das sie recht abstrakt sind und somit zu vielen Orten passt,
z.B. "Siegerland" oder "Rheinland". Diese Antworten lassen sich aber durch geeignete qualifizierte Queries rausfiltern: Begriffe, die insgesamt in den Daten
häufig vorkommen sind niedriger zu gewichten als solche, die nur bei wenigen Orten auftauchen.
In einer Beta-Version sind dann die erzeugten, richtigen Antworten besser.

Es ist davon auszugehen, dass trotzdem nicht alle automatisch generierten "richtige" Antworten auch "gute" Antworten sind.
Wenn die Grundlage keine on-the-fly Abfrage der Daten wäre, sondern eine statisch erzeugte geojson-Datei, so könnten
dort die Antworten händisch verbessert werden.

# Kontaktieren Sie das lobid-Team

Bei Unklarheiten, Bugs und Fragen jeglicher Art stehen wir gerne zur Verfügung: [Mastodon](https://openbiblio.social/@lobid), [Twitter](https://twitter.com/lobidOrg), [IRC](irc://irc.freenode.net/lobid), [E-Mail](semweb@hbz-nrw.de).


----

\*<small> Tatsächlich wird die Ortssystematik zum größten Teil aus Wikidata generiert und dort entsprechend gepflegt.</small>
