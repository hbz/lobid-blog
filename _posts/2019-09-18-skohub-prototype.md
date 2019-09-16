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

# Configuring the editor

The SkoHub Editor ([demo](https://test.skohub.io/editor/), [code](https://github.com/hbz/skohub-editor)) is configured with a [JSON schema](https://json-schema.org/understanding-json-schema/) document that simultaneously allows validation of the entered content.

I created a basic JSON schema for our purpose, see xx. I can now load a web form in SkoHub Editor based on this schema and input the information, e.g. describing the [slides](http://slides.lobid.org/htw-chur-2019/#/) for a class the lobid team gave at HTW Chur (see [this post in German](http://blog.lobid.org/2019/04/04/lobid-at-htw.html)).

<img src="/images/2019-09-18-skohub-prototype/editor-input.png" alt="Screenshot of the SkoHub editor with input describing slides for a class." style="width:650px">



# Publishing a controlled vocabulary with SkohHub

- Build error: https://test.skohub.io/build/?id=03f3a817-a11e-4498-a254-a478d4f6b089#44
- Fix syntax: https://github.com/hbz/vocabs-edu/commit/6ab97649874607df7784eaa0787adadbcefde166
- Build again: https://test.skohub.io/build/?id=678ba699-758d-498d-afeb-104d8824f282
- voilà: https://test.skohub.io/hbz/vocabs-edu/
- PR: https://github.com/perma-id/w3id.org/pull/1483
