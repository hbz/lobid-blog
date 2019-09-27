---
layout: post
title: "Presenting the SkoHub Prototype"
author: Adrian Pohl
tags: skohub
---

We are happy to announce that the SkoHub prototype outlined in our post ["SkoHub: Enabling KOS-based content subscription"](http://blog.lobid.org/2019/05/17/skohub.html) is now finished. Thanks Daniel and Felix from graphthinking GmbH for their work! In a series of three post we will report on the outcome by walking through the different components and demoing their features.

As SkoHub is all about utilizing the power of Knowledge Organization Systems (KOS) to create a publication/subscription infrastructure for Open Educational Resources (OER), we will start the series with [SkoHub Vocabs](https://github.com/hbz/skohub-vocabs), a static site generator that provides means for a GitHub-based workflow to publish an HTML version of [SKOS](https://en.wikipedia.org/wiki/Simple_Knowledge_Organization_System) vocabularies.

SkoHub Vocabs – like SkoHub Editor that is presented in a [separate post](http://blog.lobid.org/2019/09/xx/skohub-editor.html) – is a stand-alone module that can already be helpful on its own, when used without any other SkoHub modules. Let's take a look at the editing and publishing workflow step by step.

We will use SkoHub Vocabs to publish a subject classification for Open Educational Resources. We will use the "Educational Subject Classification" (ESC), that was created for the [OER World Map](https://oerworldmap.org) based on [ISCED Fields of Education and Training 2013](http://uis.unesco.org/sites/default/files/documents/isced-fields-of-education-and-training-2013-en.pdf).

## Step 1: Publish vocab as turtle file(s) on GitHub

Currently, a SKOS vocab has to be published in GitHub repository as one or more [Turtle](https://www.w3.org/TR/turtle/) file(s) in order to be processible by SkoHub Vocabs. ESC is already [available on GitHub](https://github.com/hbz/vocabs-edu/blob/master/esc.ttl) in one Turtle file, so there is nothing to do in this regard.

## Step 2: Set up webhook

In order to publish a vocabulary from GitHub with SkoHub Vocabs you have to set up a webhook in GitHub. It goes like this:

1.  In the GitHub repo where the vocab resides, got to "Settings" → "Webhooks" and click "Add webhook"   
<img src="/images/2019-09-18-skohub-prototype/add-webhook.png" alt="Screenshot of the Webhook page in a GitHub repo with highlighted fields for the navigation path." style="width:620px">
2. Enter `https://test.skohub.io/build` as payload URL choose `application/json` as content type and enter the secret. (Please [contact](http://lobid.org/team/) us for the secret if you want to try it out.)
<img src="/images/2019-09-18-skohub-prototype/add-webhook2.png" alt="Screenshot of the Webhook page with input (payload URL and secret)." style="width:620px">

## Step 3: Execute build & error handling

For the vocabulary to be build on SkoHub, there has to be a new commit in the master branch. So, we have to adjust something in the vocab and push it into the master branch. Looking again at the webhook page in the repo settings, you can see a notice that the build was triggered:

<img src="/images/2019-09-18-skohub-prototype/check-webhook-response.png" alt="Screenshot from GitHub Webhook page with information that build was triggered with link to build log." style="width:620px">

However, looking at the [build log](https://test.skohub.io/build/?id=03f3a817-a11e-4498-a254-a478d4f6b089#44), an error is shown and the site did not build:

<img src="/images/2019-09-18-skohub-prototype/error-in-build-log.png" alt="Screenshot from build log with error message" style="width:620px">

Oups, we forgot to check the vocab for syntax errors before triggering the build and there actually *is* a syntax error in the turtle file. Fixing the syntax in a new [commit](https://github.com/hbz/vocabs-edu/commit/6ab97649874607df7784eaa0787adadbcefde166) will automatically trigger a new build:

<img src="/images/2019-09-18-skohub-prototype/fix-error.png" alt="Screenshot from build log with error message" style="width:620px">

This time the [build](https://test.skohub.io/build/?id=678ba699-758d-498d-afeb-104d8824f282) goes through without errors and, voilà, SkoHub has published a human-readable version of the vocabulary at [https://test.skohub.io/hbz/vocabs-edu/w3id.org/class/esc/scheme.html](https://test.skohub.io/hbz/vocabs-edu/w3id.org/class/esc/scheme.html). (SkoHub Static Site Generator also publishes an [overview](https://test.skohub.io/hbz/vocabs-edu/) of all the SKOS vocaularies in the GitHub repo.)

## Step 4: Redirect vocab URI to SkoHub

As I want the canonical version of ESC to be the one published with SkoHub Vocabs, I need to redirect the namespace URI I defined in the Turtle file to SkoHub. As I used w3id.org for this, I have to make a pull request in the respective repo.

<a href="https://github.com/perma-id/w3id.org/pull/1483"><img src="/images/2019-09-18-skohub-prototype/open-pr-at-w3id.png" alt="Screenshot of a pull request to redirect ESC to SkoHub" style="width:620px"></a>

If everything looks good, w3id.org PRs are merged very quickly, in this case it happend an hour later.

## Result: HTML & JSON-LD representation published with SkoHub & basic GitHub editing workflow

As result, I have published a controlled vocabulary in SKOS under a permanent URI and with a human-readable HTML representation from GitHub with a minimum of work. The HTML has a hierarchy view that can be expanded and collapsed at will:

<a href="https://test.skohub.io/hbz/vocabs-edu/w3id.org/class/esc/scheme.html"><img src="/images/2019-09-18-skohub-prototype/open-pr-at-w3id.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:620px"></a>

There also is a search field to easily filter the vocabulary:

<img src="/images/2019-09-18-skohub-prototype/skohub-ssg-filter.png" alt="Screenshot of the HTML version of ESC published with SkoHub." style="width:420px">

This filter is based on the same index that is also used in the SkoHub Editor. It can be requested with a `GET` on the SKOS schema URI and the content type `text/index`, in our case: `$ curl -L -H "Accept: text/index" https://w3id.org/class/esc/scheme`

## Implementation
