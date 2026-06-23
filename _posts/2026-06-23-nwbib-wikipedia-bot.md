---
layout: post
title: "NWBibBot – Eine Regionalbibliographie in Wikipedia sichtbar machen"
date: 2026-06-23
author: Adrian Pohl, Tobias Bülte
tags: nwbib
---

# Eine Regionalbibliographie in Wikipedia sichtbar machen

Dieser Beitrag beschreibt, wie wir mithilfe eines Wikipedia Bots automatisiert mehr als 4300 Verlinkungen in Wikipedia-Artikeln über Ortschaften in Nordrhein-Westfalen ergänzt haben. Die ergänzten Links zeigen auf Listen von Einträgen über den jeweiligen Ort in der [Nordrhein-Westfälischen Bibliographie (NWBib)](https://nwbib.de).

## Vorarbeiten: Von Textstrings zum SKOS Vokabular auf Wikidata-Basis

In einem NWBib-Vorgängerprojekt von 2017 bis 2020 wurden die Grundlagen geschaffen, indem wir die freie Ortsverschlagwortung auf kontrollierte Werte umgestellt haben. Wir hatten uns damals für Wikidata als Normdatenquelle entschieden, aus der wir die entsprechenden Ortseinträge extrahieren und in eine hierarchische Raumsystematik überführen.

Für Details zur Umsetzung siehe den [Code4Lib-Artikel "How We Built a Spatial Subject Classification Based on Wikidata"](https://journal.code4lib.org/articles/15875) oder die [Präsentationsfolien zu einem Vortrag bei der WikidataCon 2019](https://slides.lobid.org/nwbib-wikidatacon).

Hier eine Zusammenfassung des aktuellen Verfahrens:

* Mit der [Wikidata Property P6814 "NWBib ID"](https://www.wikidata.org/wiki/Property:P6814) werden alle Wikidata-Einträge markiert, die in die Raumsystematik übernommen werden sollen.
* Die [Wikidata Property P4900 broader concept](https://www.wikidata.org/wiki/Property:P4900) wird als Qualifier genutzt, um die hierarchische Beziehung zur übergeordneten Systematikstelle zu markieren.
* Die Informationen aus Wikidata werden genommen, um die Raumsystematik in Form einer [SKOS-Datei](https://github.com/hbz/lobid-vocabs/blob/master/nwbib/nwbib-spatial.ttl)[^skos] zu generieren, die wiederum als Basis für die [Raumsystematik in der Webanwendung](https://nwbib.de/spatial) dient.
* Die Raumsystematik der NWBib lässt sich unter [https://nwbib.de/spatial](https://nwbib.de/spatial) browsen und ermöglicht es, mit einem Klick auf die Literaturliste zu einem Ort zu kommen. Zudem basiert eine Filterfunktion der NWBib-Suche auf der Systematik.
* Möchten NWBib-Redakteur:innen einen neue Systematikstelle ergänzen, dann fügen sie zum Wikidata-Eintrag des jeweiligen Ortes ein P6814-Statement hinzu und wir lösen einen Neuaufbau der Systematik aus, damit der Ort auch in der SKOS-Datei und auf der Webseite erscheint.

## Das Ziel

Es gibt also seit Jahren eine Verknüpfung von Orten in der NWBib-Raumsystematik zu Wikidata und wir können uns in der NWBib eine Liste mit Literatur zu einem Ort auf Basis seiner Q-ID in Wikidata anzeigen lassen, z.B. Köln mit der Q-ID 365: [https://nwbib.de/search?nwbibspatial=https%3A%2F%2Fnwbib.de%2Fspatial%23Q365](https://nwbib.de/search?nwbibspatial=https%3A%2F%2Fnwbib.de%2Fspatial%23Q365)

Wikidata verlinkt wiederum auf den zugehörigen Artikel in der deutschsprachigen Wikipedia, wenn es denn einen gibt. Die Idee: Dieser Umstand ließe sich doch gut nutzen, um neben der Wikidata-NWBib-Verknüpfung auch eine Verknüpfung der *Wikipedia*-Einträge zu Orten in NRW mit der entsprechenden NWBib-Trefferliste herzustellen.

Die Idee der Wikipedia-NWBib-Verknüpfung kam mit der Umsetzung des Projekts wurde aber zunächst nicht umgesetzt. Das Ganze wurde dann reaktiviert im November 2025  im Kontext des [1. bundesweiten Treffen der Wikimedians in Bibliotheken](https://de.wikiversity.org/wiki/Wikimedians_in_Bibliotheken).

## ...zur Anreicherung von Wikipedia durch einen Bot

Da es sich um mehr als 4000 Wikipediartikel handelt, wäre eine manuelle Ergänzung von Links ein sehr aufwändiges Unterfangen. Eine automatisierte Anreichung hingegen würde den Aufwand erheblich reduzieren. Da wir selbst nicht so mit dem Wikiversum vertraut sind, haben wir uns [im metadaten.community-Forum](https://metadaten.community/t/links-in-wikipedia-artikeln-auf-wikidata-basis-automatisiert-ergaenzen/939) Ratschläge eingeholt.

Danke an [Christian Erlinger](https://librerli.eu/), der uns dabei geholfen hat, eine [Vorlage](https://de.wikipedia.org/wiki/Vorlage:NWBib.de) zu erstellen, damit nicht für jeden Link die inividualisierte URL eingefügt werden muss. Auf Basis dieser Vorlage muss nun einfach `{% raw %}{{NWBib.de}}{% endraw %}` in einem Wikipedia-Artikel ergänzt werden, um die Verlinkung zu ergänzen. Im Hintergrund wird dabei auf die Informationen in Wikidata zugegriffen, um den korrekten Link anzuzeigen.

Zusätzlich hat Christian uns darauf hingewiesen, dass wir für eine automatisierte Anpassung der Wikipedia im größeren Stil einen Bot erstellen sollten. Grundsätzlich gibt es eine Vielzahl von Ansatzpunkten im Wikiversum, die darüber aufklären sollen, wie man einen Wikipedia-Bot erstellen soll und kann, sowie welche bürokratischen Hürden man nehmen muss:

- [https://en.wikipedia.org/wiki/Help:Creating_a_bot](https://en.wikipedia.org/wiki/Help:Creating_a_bot)
- [https://de.wikipedia.org/wiki/Wikipedia:Bots/Antr%C3%A4ge_auf_Botflag](https://de.wikipedia.org/wiki/Wikipedia:Bots/Antr%C3%A4ge_auf_Botflag)
- [https://de.wikipedia.org/wiki/Wikipedia:Bots](https://de.wikipedia.org/wiki/Wikipedia:Bots)
- [https://www.mediawiki.org/wiki/Manual:Creating_a_bot/de](https://www.mediawiki.org/wiki/Manual:Creating_a_bot/de)


## PAWS to the rescue

Neulingen bieten diese Seiten zwar einen Einstieg, aber sie helfen einem nicht direkt dabei, einen Bot zu erstellen. Dazu kommt eine Vielzahl an Möglichkeiten und Frameworks in Betracht, was die Umsetzung nicht leichter macht. Für uns hat das von Wikimedia bereitgestellte [PAWS](https://wikitech.wikimedia.org/wiki/PAWS) einiges erleichtert. PAWS ermöglicht das Erstellen von [Jupyter Notebooks](https://jupyter.org/), einer Programmierumgebung im Browser, innerhalb der ich mit dem eigenen Account direkt Daten aus dem Wikiverse abfragen, analysieren aber auch manipulieren kann.

Mit Hilfe eines Python Scripts innerhalb eines Jupyter Notebooks haben wir das Projekt letztlich umgesetzt. und dabei auf [PyWikiBot](https://doc.wikimedia.org/pywikibot/stable/index.html) zurückgegriffen, einer Python-Library für die Bearbeitung von Seiten des Wikiversums. Mit Hilfe dieser Library sollte auf die Wikipedia-Seiten zugegriffen, und je nach die Ausgangssituation die Verlinkung unter "Weblinks" ergänzt bzw. zunächst ein neuer Abschnitt Weblinks angelegt werden, falls er noch nicht vorhanden war.

## Nutzerkonto und Genehmigung für den Bot

Für den Bot haben wir zuerst einen neuen Benutzer angelegt und mittels der [Vorlage:Bot](https://de.wikipedia.org/wiki/Vorlage:Bot) beschrieben. Anschließend konnten wir mit der Entwicklung des Scripts in einem Jupyter Notebook beginnen und auf [https://test.wikipedia.org/](https://test.wikipedia.org/) testen. Nach ersten erfolgreichen Tests, wurden kleinere Tests in der deutschsprachigen Wikipedia ausgeführt. Als aus unserer Sicht das Script ausgereift war, haben wir einen [Antrag auf das Botflag](https://de.wikipedia.org/wiki/Wikipedia:Bots/Antr%C3%A4ge_auf_Botflag) gestellt und [Feedback von Wikipedianer:innen erhalten](https://de.wikipedia.org/wiki/Wikipedia:Bots/Antr%C3%A4ge_auf_Botflag/Archiv/2026#c-NWBibBot-20260430085000-2026-04-30_%E2%80%93_Benutzer:NWBibBot).

## "Einfach mal laufen lassen" & Bot-Sperre

Nach Genehmigung unseres Botflags haben wir den Bot auf erste 1000 Datensätze losgelassen. Das Ergebnis sah für den Laien gut aus, hat aber einiger Kritik durch Wikipedia-Admins und letztlich einer Sperre unseres Bots geführt. Grund dafür war, dass wir mit Blick auf die Formatierung teilweise unsauber gearbeitet hatten und nicht alle möglichen Gegebenheit im "Weblinks"-Abschnitt von Wikipedia-Seiten berücksichtigten.

Um die Sperre aufzuheben, mussten wir für den sperrenden Wikipedianer die [Bugs](https://de.wikipedia.org/wiki/Benutzer:NWBibBot/Bugs) beheben und zusagen, dass wir in kleineren Schritten Datensätze anpassen und die Anzahl der Änderungen erst ausweiten, sobald wir sicher sind, dass die Fehler nicht mehr auftreten. 

## Let it run

Mit Hilfe von Hinweisen der Wikipedianer ließen sich die Bugs schnell ausbessern. Anschließend haben wir die Anzahl der Änderungen Schrittweise von 25 auf 1000 pro Lauf gesteigert. Die finale Version des Bots durchläuft folgende Schritte:

- SPARQL-Abfrage an Wikidata, nach allen Items, die eine NWBib-Id haben und eine deutschsprachige Wikipedia-Seite
- 1. Prüfung, wenn alles ja, dann weiter:
    - Existiert die deutsche Wikipedia-Seite? 
    - Ist der Wikipedia-Link keine Weiterleitung?
    - Ist die Seite vor Änderungen nicht geschützt?
    - Ist die Vorlage `{% raw %}{{NWBib.de}}{% endraw %}` noch nicht eingebunden?
- 2. Prüfung und Entscheidung über weiteres Vorgehen:
    - Abschnitt `[[Weblinks]]` existiert --> ergänze Vorlage `{% raw %}{{NWBib.de}}{% endraw %}` am Anfang der Weblink-Liste
    - Abschnitt `[[Einzelnachweise]]` existiert, aber kein Abschnitt `[[Weblinks]]` --> ergänze`[[Weblinks]]` mit Vorlage `{{NWBib.de}}` vor dem Abschnitt `[[Einzelnachweise]]`
    -  Weder `[[Einzelnachweise]]` noch Abschnitt `[[Weblinks]]` existieren --> ergänze `[[Weblinks]]` mit Vorlage `{% raw %}{{NWBib.de}}{% endraw %}` am Ende des Artikels, aber vor der Navigationsleiste und Kategorien

Alle Prüfungen und Aktionen werden in Listen geloggt und als Report festgehalten:

```
Processed Wikidata entries:885
Newly added nwbib links:885
Changed Vorlage:0
Missing weblink section:157
Missing Einzelnachweise section:16
Already linked pages:0
Missing Wikipedia Pages for Wikidata entry:0
Protected pages:0
```

Am Ende haben wir mit Hilfe des Bots in 4309 Wikipedia-Artikeln Verlinkungen zur NWBib ergänzt.

## Lessons learned

- Trotz vieler Doku ist der Einstieg in die automatisierte Bearbeitung von Wikipedia-Seiten nicht leicht. Bei pywikibot sind zwar alle Funktionen dokumentiert, Anwendungsfälle sind aber eher auf Wikidata bzw. auf die fertigen Scripte begrenzt. Dies kann aber auch an unseren begrenzten Kenntnissen von Python und der formalen Gestaltung von Wikipediaartikeln liegen.
- Erfahrung anderer hilft enorm. Die Hilfe und Kenntnisse von Christian und den Wikipedianern hat bei der Erstellung der Bots und der Vorlage geholfen. Gerade als Neulinge hilft es, wenn erfahrene Wikipedianer:innen dabei helfen, wo man etwas suchen muss. Manchmal ist der Ton aber auch etwas rauer, aber meist kollegial.
- Nach Vergabe des Bot-Flags sollte man erstmal weiter in kleinen Änderungspaketen vorgehen. Damit man im Notfall manuell Fehler durch den Bot korrigieren kann.
- Trotz der kleinschrittigeren Ausweitung der Bearbeitungsgröße, war die Änderung an den Wikipediaseiten wesentlich schneller als manuelle Änderungen.
- PAWS ist ein tolles Tool, leider fehlt (bisher) die Möglichkeit für Versionierung der Jupyter-Notebooks. Dies hat es erschwert, die Entwicklungsschritte und kleine Änderungen beim Testen festzuhalten.

---

[^skos]: SKOS steht für "Simple Knowledge Organization System" und ist ein Standard für die Publikation kontrollierter Vokabulare (Thesauri, Systematiken etc.) im Web. Siehe für eine Einfphrung https://dini-ag-kim.github.io/skos-einfuehrung/.
