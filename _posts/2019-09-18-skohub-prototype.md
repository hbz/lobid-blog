---
layout: post
title: "Presenting the SkoHub Prototype"
date: 2019-09-18
author: Adrian Pohl
tags: skohub
---

The SkoHub prototype outlined in our post ["SkoHub: Enabling KOS-based content subscription"](http://blog.lobid.org/2019/05/17/skohub.html) is finished by now. Thanks Daniel and Felix from graphthinking GmbH for their work!

 In this post I will walk through the different components. For the sake of illustration and better understanding I will use the different components for the following scenario:

 We have this nice little ["Bildungsteiler"](https://oerhoernchen.de/bildungsteiler) (created unsalaried in his free time by our colleague Matthias Andrasch). "Bildungsteiler" is a simple application for creating structural markup to be embedded in a web page to conveniently share your educational resources with an open license on the web. You enter the creator, title, URL and license of a resource and the application will create the HTML snippet to be embedded in your web page. Just [try it out](https://oerhoernchen.de/bildungsteiler) for one minute.

 In this SkoHub demo we will use SkoHub components to rebuild Matthias' application with these main differences:

 1. Instead of HTML, SkoHub will output structured data as JSON-LD, ready to be embedded in your webpage using the `<script type="application/ld+json">` tag.
 2. With our implementation, we will enable adding one additional type of information to each reasource which is a subject from the [Educational Subject Classification](https://w3id.org/class/esc/scheme) we created some years ago based on ISCED-2013 for the [OER World Map](https://oerworldmap.org).
 3. The biggest innovation over Bildungsteiler, though, will be the publish/subscribe functionality that is integrated in SkoHub. With its description in the SkoHub Editor each resource can be syndicated to the devices of interested people subscribing to the topci the resource is about.

Let's start with this demo to make this clearer.

# Configuring & using the editor

The SkoHub Editor ([demo](https://test.skohub.io/editor/), [code](https://github.com/hbz/skohub-editor)) is configured with a [JSON schema](https://json-schema.org/understanding-json-schema/) document that simultaneously allows validation of the entered content.

I created a [basic JSON schema](https://github.com/lobid/lobid.github.com/blob/master/data/2019-09-18-oer-schema.json) for our purpose. I can now load [a web form in SkoHub Editor based on this schema](https://test.skohub.io/editor/?schema=https://raw.githubusercontent.com/lobid/lobid.github.com/master/data/2019-09-18-oer-schema.json) (by providing the link to the [raw JSON file of the schema](https://raw.githubusercontent.com/lobid/lobid.github.com/skohub-endOfProject1/data/2019-09-18-oer-schema.json)) and input the information, e.g. to describe the [slides](http://slides.lobid.org/htw-chur-2019/#/) for a class the lobid team gave at HTW Chur (see [this post in German](http://blog.lobid.org/2019/04/04/lobid-at-htw.html)).

<img src="/images/2019-09-18-skohub-prototype/editor-input.png" alt="Screenshot of the SkoHub editor with input describing slides for a class." style="width:650px">

As you can see, the JSON-LD is output on the right-hand side of the screen and can easily be copied to the clipboard to be included in the HTML of any web page.

The underlying schema is pretty straightforward. As with every JSON schema I can specify which fields to show, what type of input they expect and provide a list of values to be selected from for a specific field like the schema does in [lines 65 to 74](https://github.com/lobid/lobid.github.com/blob/3ebb98904e01cc445c27f966686de4012f93cae5/data/2019-09-18-oer-schema.json#L65-L74) for choosing one of three OER licenses. Where it gets interesting is when you input a value in the "Subject" field:

<img src="/images/2019-09-18-skohub-prototype/auto-suggestion-from-skos-vocab.png" alt="The string \"inform\" is input in the subject field and several entries with this string from a controlled vocabulary are suggested." style="width:650px">

Here a SkoHub-specific addition to JSON schema – the SkoHub Lookup Widget – is used to suggest entries from a controlled vocabulary.

Controlled vocabularies, from smaller value lists to bigger classifications and authority files – are frequently used when describing educational resources or other informative content. The next paragraph describes how to publish a vocabulary with the SkoHub Static Site Generator so that it can be looked up in the SkoHub editor and other SkoHub functionalities can be utilized.

# Publishing a controlled vocabulary with SkohHub Static Site Generator

[SkoHub Static Site Generator](https://github.com/hbz/skohub-ssg) already is quite useful on its own, when used without any other SkoHub modules. It provides means for a GitHub-based workflow to publish an HTML version of [SKOS](https://en.wikipedia.org/wiki/Simple_Knowledge_Organization_System) vocabularies. Let's take a look at the editing and publishing workflow step by step.

In our case, I want to publish a subject classification for Open Educational Resources with SkoHub. We will use the "Educational Subject Classification" (ESC), that was created for the [OER World Map](https://oerworldmap.org) based on [ISCED Fields of Education and Training 2013](http://uis.unesco.org/sites/default/files/documents/isced-fields-of-education-and-training-2013-en.pdf).

## Step 1: Publish vocab on GitHub

Currently, the SKOS vocab has to be published as a [Turtle](https://www.w3.org/TR/turtle/) file on GitHub in order to be processible by SkoHub. As ESC already was [available on GitHub](https://github.com/hbz/vocabs-edu/blob/master/esc.ttl), there was nothing to do in this regard.

## Step 2: Set up webhook

In order to publish your vocabulary to SkoHub you have to set up a webhook in GitHub. This is straightforward:

1.  In the GitHub repo where the vocab resides, got to "Settings" -> "Webhooks" and click "Add webhook"   
<img src="/images/2019-09-18-skohub-prototype/add-webhook.png" alt="Screenshot of the Webhook page in a GitHub repo with highlighted fields for the navigation path." style="width:650px">
2. Enter `https://test.skohub.io/build` as payload URL choose `application/json` as content type and enter the secret. (Please [contact](http://lobid.org/team/) us for the secret if you want to try it out.)
<img src="/images/2019-09-18-skohub-prototype/add-webhook2.png" alt="Screenshot of the Webhook page with input (payload URL and secret)." style="width:650px">


## Step 3: Execute build

For the vocabulary to be build on SkoHub, there has to be a new commit in the master branch. So, I adjust something in the vocab and push it into the master branch. Looking again at the webhook page in the repo settings, I notice that the build was triggered:

<img src="/images/2019-09-18-skohub-prototype/check-webhook-response.png" alt="Screenshot from GitHub Webhook page with information that build was triggered with link to build log." style="width:650px">

However, looking at the [build log](https://test.skohub.io/build/?id=03f3a817-a11e-4498-a254-a478d4f6b089#44), I notice that there is a problem and the site did not build:

<img src="/images/2019-09-18-skohub-prototype/error-in-build-log.png" alt="Screenshot from build log with error message" style="width:650px">

Oups, I did not check the vocab for syntax errors before triggering the build and there actually *is* a syntax error in the turtle. Fixing the syntax in a new [commit](https://github.com/hbz/vocabs-edu/commit/6ab97649874607df7784eaa0787adadbcefde166) will automatically trigger a new build:

<img src="/images/2019-09-18-skohub-prototype/fix-error.png" alt="Screenshot from build log with error message" style="width:650px">

This time the [build](https://test.skohub.io/build/?id=678ba699-758d-498d-afeb-104d8824f282) goes through without errors and – voilà – SkoHub has publised a human-readable version of the vocabulary: https://test.skohub.io/hbz/vocabs-edu/w3id.org/class/esc/scheme.html. (SkoHub Static Site Generator also publishes an overview of all the SKOS vocaularies in the linked GitHub repo, see https://test.skohub.io/hbz/vocabs-edu/.)

## Step 4: Redirect vocab URI to SkoHub

Now I want the canonical vocabulary namespace URI I defined in the Turtle file to redirect to SkoHub. As I used w3id.org for this, I have to make a [pull request](https://github.com/perma-id/w3id.org/pull/1483) in the respective repo.

<img src="/images/2019-09-18-skohub-prototype/open-pr-at-w3id.png" alt="Screenshot of a pull request to redirect ESC to SkoHub" style="width:650px">

If everything looks good, w3id PRs are merged very quickly, in this case it happend an hour later.

## Result: HTML & JSON-LD representation published with SkoHub & basic GitHub editing workflow available


# PubSub


# Work for production
