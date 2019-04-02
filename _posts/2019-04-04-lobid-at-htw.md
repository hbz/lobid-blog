---
layout: post
title: "lobid-Lehrveranstaltung an der HTW chur"
date: 2019-04-04
author: Adrian Pohl, Pascal Christoph
tags: misc
---

Ende letzter Woche waren [Adrian](http://lobid.org/team/ap#!) und [Pascal](http://lobid.org/team/pc#!) in Zürich. Eingeladen von [Fabio Ricci](https://ch.semweb.ch/firma/de-fabio-ricci/) haben wir im Kurs "Semantische Systeme" im [Bachelor-Studiengang Informationswissenschaft](https://www.htwchur.ch/studium/bachelorangebot/wirtschaft-und-dienstleistung/information-science/) an der HTW Chur über unsere Erfahrungen in der Bereitstellung von Linked Open Data am hbz gesprochen.

Wir wurden als Externe einzuladen, damit die Student*innen ein wenig aus der Berufspraxis erfahren würden. Es war das erste Mal, dass wir vor Student\*innen vorgetragen haben. Wir hatten ein wenig Informationen über das Vorwissen der Student\*innen und waren frei, was den Inhalt, Struktur und Methode der Veranstaltung anging. Wir begrüßen eine solche GFreiheit, das bedeutet allerdings auch unendliche Gestaltungsmöglichkeiten und die Aufgabe, sich für einen Ansatz zu entscheiden.

Wir hatten uns in der Vorbereitung relativ zügig auf die groben Inhalte geeinigt: Zum einen wollten wir im allgemeinen zeigen, was wir machen und wie wir arbeiten (Open Source, Open Data, offene Standards wollten wir in diesem Kontext natürlich nicht zu kurz kommen lassen) und zum anderen ein paar Details zum Aufbau einer JSOND-LD-basierten Web-API geben und deren Nutzungsmöglichkeiten beschreiben. Damit es nicht zu langweilig wird, sollten die Studierenden zwischendurch selbst Aufgaben an ihren Laptops erledigen, so dass die Inhalt besser verfangen. Hier die Agenda, mit der wir in die Veranstaltung gegangen sind:

| Zeit | Thema | Inhalt |
|------|-------|--------|
| 13:15-13:30 | Kennenlernen | Vorstellung der Referenten, Fragen an Teilnehmer*innen |
| 13:30-14:00 | Arbeitsweise	| Arbeitsprinzipien & Softwareentwicklungsprozess des lobid-Teams |
| 14:00-14:10 | Linked Open Data	| Linked-Open-Data-Grundlagen |
| 14:10-14:30 | lobid	 | Grundlegendes und Historisches|
| *14:30-15:00* | *Pause* |  |
| 15:00-15:30 | LOUD & JSON-LD | Linked Open Usable Data & JSON-LD-Grundlagen inkl. Übungen |
| 15:30-16:00 | Ein Beispiel: lobid-gnd | lobid-gnd-Demo als LOUD-Beispiel |
| 16:00-16:15 | lobid-Nutzungsbeispiele | Anwendungsbeispiele der lobid-API mit OpenRefine-Reconciliation-Übung|
| 16:15-16:30 | Abschlussdiskussion |  |

Die Slides zur Veranstaltung finden sich unter [http://slides.lobid.org/htw-chur-2019/](http://slides.lobid.org/htw-chur-2019/). Wir haben zu einem großen Teil Slides aus vergangenen Präsentationen recyclet und angepasst aber auch einige Dinge – wie z.B. die [JSON-LD-Übung ab Slide 66](http://slides.lobid.org/htw-chur-2019/#/66) – neu erstellt.

# Lessons Learned

Vor dem Hintergrund, dass wir keine Erfahrungen mit solcherlei Veranstaltungen hatten, sind wir insgesamt sehr zufrieden mit dem Verlauf. Ein großer Teil der Teillnehmer\*innen ist unserem Vortrag gefolgt (natürlich gab es auch einige, die anderes zu tun hatten, aber das bleibt bei so etwas nicht aus) und eine Handvoll von Student\*innen hat an verschiedenen Stellen nachgefragt und es haben sich Diskussionen entsponnen. Die Rückmeldungen, die wir am Ende bekamen, waren sehr positiv.

Es gab natürlich auch einige Dinge, die wir bei einer weiteren Veranstaltung anders machen würden:

- *Reduktion*: Während die Zeit im ersten Teil vollkommen ausreichte und wir in die Details gehen konnten, haben wir nach der Pause gemerkt, dass wir uns mit der Agenda übernommen haben. Das hat dazu geführt, dass wir für die Übungen nicht genügend Zeit hatten und immer mehr durch die Folien hetzen mussten. Eine Möglichkeit, damit umzugehen: den Entwicklungsprozess (ab [Folie 17](http://slides.lobid.org/htw-chur-2019/#/17)) von elf auf maximal drei knappe Folien reduzieren und mehr Fokus auf den technischen Teil (APIs & JSON-LD sowie OpenRefine-Übung) legen. Das hätte auch besser zum dem Kurs-Titel "Semantische Systeme" gepasst.
- *Vereinfachung*: Im zweiten Teil der Veranstaltung haben wir teilweise zu viel vorausgesetzt. Der allgemeine Web-API-Teil (ab [Folie 53](http://slides.lobid.org/htw-chur-2019/#/53)), hat ein Grundverständnis vorausgesetzt, was APIs sind und wie sie funktionieren. (Wir hatten ihn aus vorherigen Folien, die sich eher an Entwickler\*innen richteten adapiert.) Da müssten wir noch weiter ausholen und vereinfachen. Ideen: API als "erweiterte Suche über URL" (siehe z.B. diese alten [NWBib-Slides](http://slides.com/acka47/20151027-nwbib-dini#/18)), eine Webanwendung als Beispiel zeigen, für die selbst direkt keinerlei Daten geschaffen werden, sondern die einfach komplett auf einer offenen API aufsetzt.
- *Mehr Fragen an das Publikum vorbereiten*: Für die Vorstellung am Anfang hatten wir ein paar Fragen vorbereitet, um die Vorkenntnisse im Publikum besser einschätzen zu können. Im Lauf der Veranstaltung haben wir teilweise spontan weitere Fragen gestellt. Es wäre gut, beim nächsten Mal solche Fragen vorzubereiten. Dabei beachten, dass man mit "Wer hat nie.../Wer kennt noch nicht...?"-Fragen oft mehr Rückmeldung bekommt als auf "Wer kennt.../Wer hat schon...?"-Fragen.
- *Rückmeldungen einholen*: Reflexion ist zwar immer hilfreich für den eigenen Lernprozess, noch besser wäre es allerdings gewesen, wenn wir gezielt Rückmeldungen der Teilnehmer\*innen eingesammelt hätten. Beim nächsten Mal werden wir einen kleinen *Fragebogen* (nach Relevanz, Umfang, Schwierigkeit der Inhalte etc.) vorbereiten und die Teilnehmer\*innen am Ende bitten ihn auszufüllen.