---
layout: post
title: "Data modeling client effects"
date: 2016-12-13
author: Fabian Steeg
tags: lobid-resources
---

While [working on UI updates](https://github.com/hbz/nwbib/pull/362) for [changes in our beta API](https://github.com/hbz/lobid-resources/issues/38), I noticed an interesting way that these changes affect the client side code.

The basic idea of the data change is to replace different fields for contributors that have different roles like this:

	"contributor": [
		{
			"id": "http://d-nb.info/gnd/11200668X",
			"label": "Winter, Heike"
		}
	],
	"translator": [
		{
			"id": "http://d-nb.info/gnd/1075675383",
			"label": "Mac ‘IlleMhaoil, Gillebrìde"
		}
	]

With a single `contribution` field, in which each `agent` has a `role`:

	"contribution": [
		{
			"agent": {
				"id": "http://d-nb.info/gnd/11200668X",
				"label": "Winter, Heike"
			},
			"role": {
				"id": "http://id.loc.gov/vocabulary/relators/ctb",
				"label": "Mitwirkende"
			}
		},
		{
			"agent": {
				"id": "http://d-nb.info/gnd/1075675383",
				"label": "Mac ‘IlleMhaoil, Gillebrìde"
			},
			"role": {
				"id": "http://id.loc.gov/vocabulary/relators/trl",
				"label": "Übersetzung"
			}
		}
	]

In the client code this allows us to replace something like this (where `@field` would use the given label and property to create a `<tr>` for each field):

	@field("Autor/in", "creator")
	@field("Redaktion", "redaktor")
	@field("Herausgeber/in", "editor")
	@field("Mitwirkung", "contributor")
	@field("Schauspieler/in", "actor")
	@field("Nachwort", "afterwordBy")
	@field("Einleitung", "introductionBy")
	@field("Drehbuch", "screenwriter")
	@field("Mitarbeit", "collaborator")
	@field("Komponist/in", "composer")
	@field("Dirigent/in", "conductor")
	@field("Kamera", "cinematographer")
	@field("Sammler/in", "collector")
	@field("Kartographie", "cartographer")
	@field("Regie", "director")
	@field("Widmungsträger/in", "dedicatee")
	@field("Stecher/in", "engraver")
	@field("Illustration", "illustrator")
	@field("Interviewte/r", "interviewee")
	@field("Interviewer/in", "interviewer")
	@field("Musik", "musician")
	@field("Fotografie", "photographer")
	@field("Interpret/in", "performer")
	@field("Produktion", "producer")
	@field("Gesang", "singer")
	@field("Gefeierte Person", "honoree")
	@field("Übersetzung", "translator")

With something like this (the actual implementation groups the contributions with the same role into a single `<tr>`):

	@for(contribution <- contributions) {
		<tr>
			<td>@(contribution \ "role" \ "label")</td>
			<td>@(contribution \ "agent" \ "label")</td>
		</tr>
	}

That is, instead of explicitly listing every field we want to display in the UI, and how to label it, we include the role semantics right in our data, and can process it in a unified way: show all contributions, and label each agent with its role.