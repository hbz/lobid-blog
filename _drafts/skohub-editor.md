---
layout: post
title: "Presenting the SkoHub-Editor Prototype"
author: Adrian Pohl
tags: skohub
---

For the implementation application, we will be oriented towards ["Bildungsteiler"](https://oerhoernchen.de/bildungsteiler) (developed by our colleague [Matthias Andrasch](https://blog.matthias-andrasch.de/about/) in his free time). When you enter the creator, title, URL and license of a resource and the application in "Bildungsteiler", it will create a HTML snippet to be embedded in your web page. Just [try it out](https://oerhoernchen.de/bildungsteiler) for one minute.

In this demo we will use SkoHub components to rebuild Matthias' application with these main differences:

 1. Instead of HTML, SkoHub will output structured data as JSON-LD, ready to be embedded in your webpage using the `<script type="application/ld+json">` tag.
 2. With our implementation, we will enable adding a subject from a controlled vocabulary to each resource.
 3. The biggest innovation over Bildungsteiler, though, will be the publish/subscribe functionality that is integrated in SkoHub. With its description in the SkoHub Editor each resource can be syndicated to the devices of interested people subscribing to the subject the resource is about.

Let's start with this demo to make this clearer.

# Configuring & using the editor

So we want to create an editor that lets you create JSON-LD for a webpage. The SkoHub Editor ([demo](https://test.skohub.io/editor/), [code](https://github.com/hbz/skohub-editor)) does exactly that.

It is configured with a [JSON schema](https://json-schema.org/understanding-json-schema/) document that simultaneously allows validation of the entered content. I created a [basic JSON schema](https://github.com/lobid/lobid.github.com/blob/master/data/2019-09-18-oer-schema.json) for our purpose. I can now load [a web form](https://test.skohub.io/editor/?schema=https://raw.githubusercontent.com/lobid/lobid.github.com/master/data/2019-09-18-oer-schema.json) in SkoHub Editor by providing the link to the [raw JSON file of the schema](https://raw.githubusercontent.com/lobid/lobid.github.com/skohub-endOfProject1/data/2019-09-18-oer-schema.json) and then start to input the information, e.g. to describe the slides for a class the lobid team gave at HTW Chur.

<img src="/images/2019-09-18-skohub-prototype/editor-input.png" alt="Screenshot of the SkoHub editor with input describing slides for a class." style="width:620px">

As you can see, the JSON-LD is output on the right-hand side of the screen and can easily be copied to the clipboard to be included in the HTML of any web page.

The underlying schema is pretty straightforward. As with every JSON schema I can for specify a number of optional or mandatory fields, what type of input each field expects. I also can provide a list of values to be selected from for a specific field like the schema does for choosing one of three OER licenses in [lines 65 to 74](https://github.com/lobid/lobid.github.com/blob/3ebb98904e01cc445c27f966686de4012f93cae5/data/2019-09-18-oer-schema.json#L65-L74). In the  SkoHub Editor this is then reflected by a "select" under the "License" field button where after clicking all three values are shown in a dropdown.

<img src="/images/2019-09-18-skohub-prototype/pick-a-license.png" alt="The string 'Inform' is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:620px">

With this setup, we already have covered all information you can create with "Bildungsteiler". But we said to also enable adding a subject from a controlled vocabulary to each resource. When inputing content into the "Subject" field, we also get a dropdown with suggestions:

<img src="/images/2019-09-18-skohub-prototype/auto-suggestion-from-skos-vocab.png" alt="The string 'Inform' is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:620px">

This time, these values are not listed in the JSON Schema but a SkoHub-specific addition to JSON schema – the SkoHub Lookup Widget – is used. It works with all controlled vocabularies that are published with the SkoHub Static Site Generator. The next paragraph describes how to publish a vocabulary with the SkoHub Static Site Generator so that it can be looked up in the SkoHub editor and additional SkoHub functionalities can be utilized.
