---
layout: post
title: "Presenting the SkoHub Editor"
author: Adrian Pohl, Felix Ostrowski
tags: skohub
---

In a [previous blog post](http://blog.lobid.org/2019/09/27/presenting-skohub-vocabs.html) we presented a first SkoHub module: *SkoHub Vocabs*. Before talking about another module, first a short summary of the features SkoHub Vocabs offers. Basically, it provides an editorial workflow to publishing a SKOS vocabulary on the web to be consumed by humans and applications. It builds on git-based online software development platforms (currently GitHub and GitLab are supported) where you maintain a SKOS schemes as a Turtle file, thus being able to use all the associated features (branches, merge requests) for a full-fledged review process. With every new commit in a branch, triggered by a webhook, SkoHub Vocabs will build a static site for the vocab – with HTML for human consumption and JSON-LD for consumption by applications.

In this post, we will present *SkoHub Editor* ([demo](https://skohub.io/editor/), [code](https://github.com/hbz/skohub-editor)) that is accompanied by a browser extension. In a nutshell, SkoHub Editor enables the automatic generation of a web form based on a JSON schema, along with the possibility to lookup terms in a controlled vocabulary that is published with SkoHub Vocabs. Additionally, described resources can be published using SkoHub PubSub. Let's take a look at the specifics by creating an editor that lets you create JSON-LD describing an open educational resource (OER) on the web.

# Loading the web form

So we want to create an editor that lets you create JSON-LD describing an OER that is published somewhere on the web. SkoHub Editor is configured with a [JSON schema](https://json-schema.org/understanding-json-schema/) document that is simultaneously used for the validation of the entered content. Accordingly, this is what we have to start with. We created & put online a [basic JSON schema](https://github.com/lobid/lobid.github.com/blob/master/data/oer-schema.json) for recording the URL, title, creator(s) of a resource and choosing a license & topic it is about.

With the JSON schema URL, we can now load [a web form](https://skohub.io/editor/?schema=https://raw.githubusercontent.com/lobid/lobid.github.com/master/data/oer-schema.json) in SkoHub Editor by providing the link to the [raw JSON file of the schema](https://raw.githubusercontent.com/lobid/lobid.github.com/skohub-endOfProject1/data/oer-schema.json) and then start to input the information.

# Describing a resource

In times of a coronavirus pandemic, we use as an example the YouTube video ["COVID-19 | 6 Dangerous Coronavirus Myths, Busted by World Health Organization"](https://www.youtube.com/watch?v=ZaiDDOZcaqc) published recently by the World Economic Forum under a CC-BY license.

<img src="../images/skohub-editor/editor-input.png" alt="Screenshot of the SkoHub editor with input describing a YouTube video." style="width:620px">

As you can see, the JSON-LD is output on the right-hand side of the screen and can easily be copied to the clipboard to be included in the HTML of any web page within a `<script type="application/ld+json">` tag.

We also mentioned being able to lookup a subject from a controlled vocabulary in the web form. You can experience this, when inputing content into the "Subject" field. You will then get a dropdown with suggestions from the [Educational Subjects Classificaiton](https://w3id.org/class/esc/scheme) that is published with SkoHub Vocabs.

<img src="../images/skohub-editor/auto-suggestion-from-skos-vocab.png" alt="The string 'Inform' is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:620px">

Here, a SkoHub-specific addition to JSON schema – the SkoHub Lookup Widget – is used. It works with all controlled vocabularies that are published with SkoHub Vocabs.

# Browser Extension with pre-populated web form

Comparing to the standalone editor at [https://skohub.io/editor/](https://skohub.io/editor/), there is an even more comfortable way to describe a web resource with your browser by using the SkoHub browser extension. It is available both for [Firefox](https://addons.mozilla.org/en-US/firefox/addon/skohub-extension/) and [Chrome](tbd). Just add the extension to your browser and a little icon will be shown on the right-hand side of your navigation bar:

<img src="../images/skohub-editor/extension-icon.png" alt="The SkoHub extension icon in between other extensions in the Firefox nav bar" style="width:600px">

While having any web page open, you can now open the SkoHub editor in your browser to describe the respective web resource.Try it out with the [already mentioned YouTube video](https://www.youtube.com/watch?v=ZaiDDOZcaqc) and you will see that several fields are automatically filled out when opening the extension.

# Diving deeper into the JSON schema config

The underlying schema is pretty straightforward. Generally, with JSON schema you can specify a number of optional or mandatory properties and what type of input each expects.

The `"title"` of each property will be used as the label for the field in the web form.

To make our data JSON-LD, we define a mandatory `@context` property with only possible value `http://schema.org/`. This makes the editor add it to the document as default without any user interaction needed.

As in every JSON schema, I can provide a list of values to be selected from for a specific field like the schema does for choosing one of three OER licenses in [lines 65 to 74](https://github.com/lobid/lobid.github.com/blob/0bf57d4fcdddefbb47a50eda37d623189c9bb4c9/data/oer-schema.json#L71-L73). In the  SkoHub Editor this is then reflected by a "select" under the "License" field button where after clicking all three values are shown in a dropdown.

You may have noticed some custom keys in the JSON schema, those that start with an underscore `_`. tbd

<img src="../images/skohub-editor/pick-a-license.png" alt="The string 'Inform' is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:620px">

