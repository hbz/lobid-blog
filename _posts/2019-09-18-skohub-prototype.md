---
layout: post
title: "Presenting the SkoHub Prototype"
date: 2019-09-18
author: Adrian Pohl
tags: skohub
---

We are happy to announce that the SkoHub prototype outlined in our post ["SkoHub: Enabling KOS-based content subscription"](http://blog.lobid.org/2019/05/17/skohub.html) is now finished. Thanks Daniel and Felix from graphthinking GmbH for their work!

In this post I will walk through the different components. For the sake of illustration and better understanding I will utilize the different components for building an application to create structured markup for sharing your Open Educational Resources (OER) on the web.

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

The underlying schema is pretty straightforward. As with every JSON schema I can specify a number of optional or mandatory fields and the type each field expects. I also can provide a list of values to be selected from for a specific field like the schema does for choosing one of three OER licenses in [lines 65 to 74](https://github.com/lobid/lobid.github.com/blob/3ebb98904e01cc445c27f966686de4012f93cae5/data/2019-09-18-oer-schema.json#L65-L74). In the  SkoHub Editor this is then reflected by a "select" under the "License" field button where after clicking all three values are shown in a dropdown.

<img src="/images/2019-09-18-skohub-prototype/pick-a-license.png" alt="The string 'Inform' is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:620px">

With this setup, we already have covered all information you can create with "Bildungsteiler". But we said to also enable adding a subject from a controlled vocabulary to each resource. When inputing content into the "Subject" field, we also get a dropdown with suggestions:

<img src="/images/2019-09-18-skohub-prototype/auto-suggestion-from-skos-vocab.png" alt="The string 'Inform' is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:620px">

This time, these values are not listed in the JSON Schema but a SkoHub-specific addition to JSON schema – the SkoHub Lookup Widget – is used. It works with all controlled vocabularies that are published with the SkoHub Static Site Generator. The next paragraph describes how to publish a vocabulary with the SkoHub Static Site Generator so that it can be looked up in the SkoHub editor and additional SkoHub functionalities can be utilized.

# Publishing a controlled vocabulary with SkohHub Static Site Generator

[SkoHub Static Site Generator](https://github.com/hbz/skohub-ssg) – like SkoHub editor – is a stand-alone module that can already be helpful on its own, when used without any other SkoHub modules. It provides means for a GitHub-based workflow to publish an HTML version of [SKOS](https://en.wikipedia.org/wiki/Simple_Knowledge_Organization_System) vocabularies. Let's take a look at the editing and publishing workflow step by step.

In our case, I want to publish a subject classification for Open Educational Resources with SkoHub. We will use the "Educational Subject Classification" (ESC), that was created for the [OER World Map](https://oerworldmap.org) based on [ISCED Fields of Education and Training 2013](http://uis.unesco.org/sites/default/files/documents/isced-fields-of-education-and-training-2013-en.pdf).

## Step 1: Publish vocab on GitHub

Currently, a SKOS vocab has to be published as a [Turtle](https://www.w3.org/TR/turtle/) file on GitHub in order to be processible by SkoHub. As ESC already has been [available on GitHub](https://github.com/hbz/vocabs-edu/blob/master/esc.ttl), there is nothing to do in this regard.

## Step 2: Set up webhook

In order to publish a vocabulary to SkoHub you have to set up a webhook in GitHub. It goes like this:

1.  In the GitHub repo where the vocab resides, got to "Settings" → "Webhooks" and click "Add webhook"   
<img src="/images/2019-09-18-skohub-prototype/add-webhook.png" alt="Screenshot of the Webhook page in a GitHub repo with highlighted fields for the navigation path." style="width:620px">
2. Enter `https://test.skohub.io/build`. As payload URL choose `application/json` as content type and enter the secret. (Please [contact](https://lobid.org/team/) us for the secret if you want to try it out.)
<img src="/images/2019-09-18-skohub-prototype/add-webhook2.png" alt="Screenshot of the Webhook page with input (payload URL and secret)." style="width:620px">


## Step 3: Execute build

For the vocabulary to be build on SkoHub, there has to be a new commit in the master branch. So, we have to adjust something in the vocab and push it into the master branch. Looking again at the webhook page in the repo settings, you can see a notice that the build was triggered:

<img src="/images/2019-09-18-skohub-prototype/check-webhook-response.png" alt="Screenshot from GitHub Webhook page with information that build was triggered with link to build log." style="width:620px">

However, looking at the [build log](https://test.skohub.io/build/?id=03f3a817-a11e-4498-a254-a478d4f6b089#44), an error is shown and the site did not build:

<img src="/images/2019-09-18-skohub-prototype/error-in-build-log.png" alt="Screenshot from build log with error message" style="width:620px">

Oups, we forgot to check the vocab for syntax errors before triggering the build and there actually *is* a syntax error in the turtle file. Fixing the syntax in a new [commit](https://github.com/hbz/vocabs-edu/commit/6ab97649874607df7784eaa0787adadbcefde166) will automatically trigger a new build:

<img src="/images/2019-09-18-skohub-prototype/fix-error.png" alt="Screenshot from build log with error message" style="width:620px">

This time the [build](https://test.skohub.io/build/?id=678ba699-758d-498d-afeb-104d8824f282) goes through without errors and, voilà, SkoHub has published a human-readable version of the vocabulary at [https://test.skohub.io/hbz/vocabs-edu/w3id.org/class/esc/scheme.html](https://test.skohub.io/hbz/vocabs-edu/w3id.org/class/esc/scheme.html). (SkoHub Static Site Generator also publishes an [overview](https://test.skohub.io/hbz/vocabs-edu/) of all the SKOS vocaularies in the GitHub repo.)

## Step 4: Redirect vocab URI to SkoHub

Now I want the canonical vocabulary namespace URI I defined in the Turtle file to redirect to SkoHub. As I used w3id.org for this, I have to make a pull request in the respective repo.

<a href="https://github.com/perma-id/w3id.org/pull/1483"><img src="/images/2019-09-18-skohub-prototype/open-pr-at-w3id.png" alt="Screenshot of a pull request to redirect ESC to SkoHub" style="width:620px"></a>

If everything looks good, w3id.org PRs are merged very quickly, in this case it happend an hour later.

## Result: HTML & JSON-LD representation published with SkoHub & basic GitHub editing workflow

In the end, I have published a controlled vocabulary in SKOS under a permanent URI and with a human-readable HTML representation from GitHub with a minimum of work. The HTML has a hierarchy view that can be expanded and collapsed at will:

<a href="https://test.skohub.io/hbz/vocabs-edu/w3id.org/class/esc/scheme.html"><img src="/images/2019-09-18-skohub-prototype/open-pr-at-w3id.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:620px"></a>

There also is a search field to easily filter the vocabulary:

<img src="/images/2019-09-18-skohub-prototype/skohub-ssg-filter.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:420px">

This filter is based on the same index that is also used in the SkoHub Editor. It can be requested with a `GET` on the SKOS schema URI and the content type `text/index`, in our case: `$ curl -L -H "Accept: text/index" https://w3id.org/class/esc/scheme`

# Subscribing to a subject

If you came this far into this post you may ask yourself: *But what about the "KOS-based content subscription" that SkoHub announced to implement?* Just take a look at a single subject from a controlled vocabulary published with SkoHub, e.g. [Library, information and archival studies](https://w3id.org/class/esc/n0322), and you can see the "Subscribe" button right under the concept URI:

<img src="/images/2019-09-18-skohub-prototype/subscribe.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:420px">

When you click this link, you will be directed to [SkoHub Deck](https://github.com/hbz/skohub-deck), an application to subscribe to and view notifications sent to a specific subject in your browser.

<img src="/images/2019-09-18-skohub-prototype/skohub-deck.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:620px">

As the receiving end of notifications about new content about a specific subject SkoHub Deck makes use of the backend infrastructure provided by the [SkoHub Pubsub](https://github.com/hbz/skohub-pubsub) server. Although, SkoHub Pubsub is the core of the whole infrastructure and the module that connects all the other SkoHub components, it is not visible itself but only in applications like SkoHub Deck and SkoHub Editor which can send out notifications to a specific topic.

So, when I describe an OER in SkoHub Editor, assign the topic I have subscribed to and click "save", a notification about the resource will be sent to SkoHub Deck.

<img src="/images/2019-09-18-skohub-prototype/notification.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:620px">

With this prototype the basic functionality of SkoHub is presented as a proof of concept:
- an editor with validated structured data as output for
  1. *describing* a resource including the use of terms from a controlled vocabulary
  2. *sending notifications* to the terms' inboxes
- a process and application to *publish controlled vocabularies* represented in SKOS to the web and enable *lookup* of terms from the vocabulary
- the ability to *subscribe* to a vocabulary term and an application to view incoming messages about new resources

So the basic infrastructure is there but this is still a prototype. We will have to fix some smaller and bigger things and to generally improve the UI/UX of the components to make it production ready. We are happy to announce that we have obtained more funding for continuing SkoHub development and moving to production .

# To Dos for production

To achieve production level, we will directly continue work on SkoHub until the end of the year. Besides working on the UI/UX of the editor and static site generator, we have a lot of work to do on the PubSub backend (where we will switch the underlying pubsub protocol) and want to add some additional features. Here is a list of what we are thinking about.

- Move from WebSub to ActivityPub (see [#16](https://github.com/hbz/skohub-pubsub/issues/16) and the wiki page linked there)
- Enable easy setup on local server (Docker?)
- Offer plugins for content description and sending of notifications (e.g. for Moodle, WordPress and/or hypothes.is)
- Prototype for semi-automatic subject indexing in SkoHub Editor using [Annif](http://annif.org/)
- Provide more documentation
- Present SkoHub at conferences
- Create and maintain a reference application
- Find implementors
- Use SkoHub components in standardiziation work for OER metadata in the [DINI KIM](https://wiki.dnb.de/display/DINIAGKIM/OER-Metadaten-Gruppe) context (create agreed-upon schemas for describing OER and agree on controlled vocabularies for subjects, resource type etc.)

# Try it out

Please try it out. We are happy about bug reports, suggestions and feature requests for the production version. Get in contact with us via a hypothes.is annotation, GitHub, email, Twitter or IRC.
