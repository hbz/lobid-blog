---
layout: post
title: "Presenting the SkoHub Editor"
author: Adrian Pohl, Felix Ostrowski
tags: skohub
---

In a [previous blog post](http://blog.lobid.org/2019/09/27/presenting-skohub-vocabs.html) we presented a first SkoHub module: *SkoHub Vocabs*. Before talking about another module, first a short summary of the features SkoHub Vocabs offers. Basically, it provides an editorial workflow to publishing a SKOS vocabulary on the web to be consumed by humans and applications. It builds on git-based online software development platforms (currently GitHub and GitLab are supported) where you maintain a SKOS schemes as a Turtle file, thus being able to use all the associated features (branches, merge requests) for a full-fledged review process. With every new commit in a branch, triggered by a webhook, SkoHub Vocabs will build a static site for the vocab – with HTML for human consumption and JSON-LD for consumption by applications.

In this post, we will present *SkoHub Editor* ([demo](https://skohub.io/editor/), [code](https://github.com/hbz/skohub-editor)) that is accompanied by a browser extension. In a nutshell, SkoHub Editor enables the automatic generation of a web form based on a JSON schema, along with the possibility to lookup terms in a controlled vocabulary that is published with SkoHub Vocabs. Additionally, described resources can be published using SkoHub PubSub. Let's take a look at the specifics by configuring an editor that lets you create JSON-LD describing an open educational resource (OER) on the web.

# Describing a resource with the browser extension

Let's start with actually using SkoHub Editor. You will have the most comfortable experience when using the SkoHub browser extension that wraps the SkoHub Editor and pre-populates some field in the web form. The browser extension is available both for [Firefox](https://addons.mozilla.org/en-US/firefox/addon/skohub-extension/) and [Chrome](tbd). Just add the extension to your browser and a little icon will be shown on the right-hand side of your navigation bar:

<img src="../images/skohub-editor/extension-icon.png" alt="The SkoHub extension icon in between other extensions in the Firefox nav bar" style="width:600px">

While having any web page open, you can now open the SkoHub editor in your browser to describe any web resource. In times of a coronavirus pandemic, we use as an example the YouTube video ["COVID-19 | 6 Dangerous Coronavirus Myths, Busted by World Health Organization"](https://www.youtube.com/watch?v=ZaiDDOZcaqc) published recently by the World Economic Forum under a CC-BY license. Open the extension and and you will see that several fields are automatically filled out.

<img src="../images/skohub-editor/pre-populated-fields.png" alt="SjoHub extension in the sidebar of the browser with fields 'URL', 'Title' and 'Description' being pre-populated" style="width:600px">

Clicking on "Show Preview" in the extension, you can see the JSON-LD that is being generated with the input. For example, it can easily be copied to the clipboard to be included in the HTML of any web page within a `<script type="application/ld+json">` tag.

We also mentioned being able to look up a subject from a controlled vocabulary in the web form. You can experience this, when inputting content into the fields "Subject", "License", "Learning Resource Type", "Intended Audience". You will then get a dropdown with suggestions from a controlled vocabulary, e.g. for "Subject" from a German [classification](https://w3id.org/kim/hochschulfaechersystematik/scheme) of subjects in Higher ed that is published with SkoHub Vocabs.

<img src="../images/skohub-editor/auto-suggestion-from-skos-vocab.png" alt="The string 'gesundh' is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:620px">

Currently, only the fields "URL", "Title" and "Subject" are obligatory, any other field is optional. So when you think you have described the resource sufficiently you can copy & paste the JSON-LD or publish the resource via SkoHub PubSub (to be covered in the next blog post).

# Configuring the web form with JSON Schema

As said above, the SkoHub Extension wraps the SkoHub Editor running at [https://skohub.io/editor/](https://skohub.io/editor/). SkoHub Editor is configured with a [JSON schema](https://json-schema.org/understanding-json-schema/) document that is simultaneously used for the validation of the entered content. Thus, the JSON Schema is the central, ost crucial part when working with SkoHub Editor. Currently, we are using as default schema a [draft schema for OER](https://dini-ag-kim.github.io/lrmi-profile/draft/schemas/schema.json) we created using relevant properties and types from [schema.org](https://schema.org). With the JSON schema URL, we can now load the [web form](https://skohub.io/editor/?schema=https://dini-ag-kim.github.io/lrmi-profile/draft/schemas/schema.json) you already know from the browser extension by providing the link to the schema. Let's take a deeper look at the schema.

To make our data JSON-LD, we set as default define a mandatory `@context` property with only possible value – a link to the JSON-LD context at `https://dini-ag-kim.github.io/lrmi-profile/draft/schemas/context.jsonld`. This makes the editor add it to the document as default without any user interaction needed.

The underlying schema is pretty straightforward. Generally, with JSON schema you can specify a number of optional or mandatory properties and what type of input each expects.
The `"title"` of each property will be used as the label for the field in the web form.

As in every JSON schema, I can provide a list of values to be selected from for a specific field like the schema does for choosing one of three OER licenses in [lines 65 to 74](https://github.com/lobid/lobid.github.com/blob/0bf57d4fcdddefbb47a50eda37d623189c9bb4c9/data/oer-schema.json#L71-L73). In the  SkoHub Editor this is then reflected by a "select" under the "License" field button where after clicking all three values are shown in a dropdown.

You may have noticed some custom keys in the JSON schema, those that start with an underscore `_`. tbd

For example, a SkoHub-specific addition to JSON schema – the SkoHub Lookup Widget – is used. It works with all controlled vocabularies that are published with SkoHub Vocabs.

## Areas for schema improvement

SkoHub Editor already works very well and can be extremely useful for different purposes. However, some things are still work in progress and will need some future effort to be improved: 

- **Unfinished Vocabularies**: For "Learning Resource Type" and "intended Audience" we are using controlled vocabularies that are in development at the Dublin Core Metadata Initiative (DCMI). You will see that they might be missing some options. However, we assume that the combination of SkoHub Editor & SkoHub Vocabs makes a pretty nice environment for further developing these vocabularies with an open and transparent process on GitHub or GitLab.
-  **Custom JSON-LD context**: As we are using some SKOS elements besides schema.org markup, we decided to publish a custom JSON-LD context for the editor output. However, it seems like Google won't detect and use the schema.org markup although it is the. We might have to think about another way to addressing this, e.g. by embedding the context in each document orby solely using schema.org markup (see [#31](https://github.com/hbz/skohub-editor/issues/31)).

# Implementation



# Outlook

