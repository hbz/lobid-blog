---
layout: post
title: "Ergebnisse der Umfrage zur Nutzung der lobid-API"
author: Felix Lohmeier
date: 2022-07-06
tags: lobid-gnd lobid-resources lobid-organisations
---

Im Frühjahr hatten wir [eine kleine Umfrage](https://blog.lobid.org/2022/02/03/umfrage.html) zur Nutzung der lobid-API durchgeführt. Wir haben uns sehr über die hohe Teilnahme (70 Personen) gefreut! So haben wir einen guten Überblick gewonnen, welche schönen Dienste und Projekte auf der lobid-API aufbauen. Die Ergebnisse der Umfrage und erste Erkenntnisse möchten wir hier nun gerne teilen.

Zur Einordnung:

* Zeitraum: 03.02. bis 11.04.2022
* Rückmeldungen: 70
* Mehrfachnennungen waren möglich

## Frage 1: Welche Dienste von lobid nutzen Sie?

![frage-1](/images/2022-07-survey-results/frage1-dienste.png)

Wie erwartet, ist [lobid-gnd](https://lobid.org/gnd) der mit Abstand prominenteste Dienst.

## Frage 2: In welchem Anwendungskontext verwenden Sie lobid?

![frage-2](/images/2022-07-survey-results/frage2-anwendungskontext.png)

Interessant ist für uns der hohe Anteil von Anwendungen außerhalb des Bibliotheksbereichs. Offenbar wird die lobid-API in vielen Forschungsprojekten in den Digital Humanities aber auch darüber hinaus eingesetzt. Unter "Sonstiges" wurden beispielsweise Dissertationen, soziologische Forschung und wissenschaftliche Dokumentation genannt. Weiterhin wird lobid-API auch für Forschungsinformationssysteme eingesetzt.

## Frage 3: Welche Funktionen von lobid nutzen Sie?

![frage-3](/images/2022-07-survey-results/frage3-funktionen.png)

Die lobid-API verfügt über einige Zusatzfunktionen die offenbar wenig genutzt werden. Ortsbezogene Suche und RSS-Feeds wurden gar nicht ausgewählt. Hier wollen wir prüfen, ob diese vielleicht besser bekannt gemacht werden können.

Wie erwartet, wird die Reconciliation API (z.B. via OpenRefine) oft genutzt. Hier haben wir die letzten Jahre viel an den Funktionen gearbeitet, [Tutorials](https://blog.lobid.org/2018/08/27/openrefine.html) erstellt und Workshops angeboten.

Am meisten werden Live-Zugriffe auf Einzeldaten und die Suchfunktion genutzt. Der Abruf größerer Datenmengen (Bulk-Downloads) wird nur von einem kleineren Teil genutzt. In vielen Anwendungskontexten können Bulk-Downloads und anschließende lokale Verarbeitung effizienter als Einzelabrufe sein. Hier wollen wir prüfen, ob wir mit neuen Anleitungen eine ressourcenschonende Nutzung der lobid-API unterstützen können.

## Frage 4: Mit welcher Häufigkeit/Frequenz nutzen Sie lobid?

| Antwort           | Anteil  |
| ----------------- | ------- |
| Regelmäßig        | 58,44 % |
| Zeitlich begrenzt | 41,56 % |

Bei dieser Frage zeigt sich nochmal deutlich der Anteil von Forschungsprojekten.

## Frage 5: Welche Tools nutzen Sie um lobid abzufragen?

![frage-5](/images/2022-07-survey-results/frage5-tools.png)

Es ist schön zu sehen, mit welcher Vielfalt an Werkzeugen die lobid-API genutzt wird. Bei den Programmiersprachen führt Python (23) vor Java (7), Javascript (4), Perl (3) und PHP (3). Spezifisch für lobid entwickelte Clients wie [pylobid](https://github.com/csae8092/pylobid) (0), [lobid-client](https://github.com/telota/lobid-client) (1) und [django-gnd](https://github.com/acdh-oeaw/django-gnd) (0) wurden fast gar nicht genannt. Wir sind selbst erst im Rahmen der Umfrage [darauf aufmerksam geworden](https://twitter.com/lobidOrg/status/1494650142972129283), so dass diese sicher noch bekannter gemacht werden könnten.

## Frage 6: Wofür nutzen Sie lobid?

Hier waren wir schlicht überwältigt von der vielfältigen Nutzung. Einige Teilnehmer\*innen der Umfrage haben sich die Mühe gemacht, ihre Anwendungsfälle detailliert zu beschreiben. Wir finden das sind viele inspirierende Beispiele, von denen andere profitieren können. Daher wollen wir gerne eine Sammlung von Anwendungsfällen aufbauen, in die sich dann alle auch selbst eintragen können. 

## Frage 7: Erwähnen Sie lobid in irgendeiner Weise öffentlich als Datenquelle?

| Antwort | Anteil  |
| --------| ------- |
| Ja      | 41,54 % |
| Nein    | 58,46 % |

Vielen Dank für die Credits! Bislang gibt es dazu keine Empfehlungen und trotzdem hat fast die Hälfte bereits lobid als Datenquelle öffentlich erwähnt. In einigen Anwendungsfällen, z.B. bei Hintergrunddiensten, gibt es auch gar keine einfache Möglichkeit für eine öffentliche Notiz. Wir schauen uns die bisherigen Beispiele an und prüfen dann, ob wir allgemeine Empfehlungen aussprechen können.

## Und wozu die ganzen Fragen?

Wie hier im Blog schon zuvor berichtet, arbeiten wir an der Entwicklung von Leitlinien für die Nutzung offener Dienste. Wir sind oft nach Vorgaben und Empfehlungen zur Nutzung der lobid-API gefragt worden und möchten das nun einmal für zukünftige Nutzer\*innen ausarbeiten.

Als nächstes werden wir ein paar der Interviewpartner kontaktieren, um einzelne Anwendungsfälle noch genauer zu verstehen und Ideen für die Nutzungspolicy zu diskutieren. Außerdem werden wir recherchieren, was andere offene Dienste (frei zugängliche APIs ohne Registrierungszwang) regeln.

Zum Ende dieses kleinen Projekts in Zusammenarbeit mit [Open Culture Consulting](https://opencultureconsulting.com) sollen dann Entwürfe einer Nutzungspolicy und technischer Empfehlungen vorliegen, die wir gerne hier im Blog zur Diskussion stellen werden.