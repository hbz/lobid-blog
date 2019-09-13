---
layout: post
title: "Presenting the SkoHub Prototype"
date: 2019-09-xx
author: Adrian Pohl
tags: skohub
---

The SkoHub prototype outlined in our post ["SkoHub: Enabling KOS-based content subscription"](http://blog.lobid.org/2019/05/17/skohub.html) is finished by now. Thanks Daniel and Felix from graphthinking GmbH for their work!

 In this post I will walk through the different components. For the sake of illustration and better understanding I will walk use the different components for the following scenario.

 We have this nice little ["Bildungsteiler"](https://oerhoernchen.de/bildungsteiler), created by our colleague Matthias Andrasch, which is a simple application for creating structural markup to share your educational resources with an open license on the web. The goal is to rebuild this application using SkoHub modules. There will be two main differences to Matthias'' application:

 1. SkoHub will output structured data as JSON-LD, ready to be embedded in your webpage (using the `<script type="application/ld+json">` tag).
 2. We will enable adding one additional type of information to each reasource which is a subject from the [Educational Subject Classification](https://w3id.org/class/esc/scheme) we created some years ago based on ISCED-2013 for the [OER World Map](https://oerworldmap.org).

# Publishing a controlled vocabulary with SkohHub

- Build error: https://test.skohub.io/build/?id=03f3a817-a11e-4498-a254-a478d4f6b089#44
- Fix syntax: https://github.com/hbz/vocabs-edu/commit/6ab97649874607df7784eaa0787adadbcefde166
- Build again: https://test.skohub.io/build/?id=678ba699-758d-498d-afeb-104d8824f282
- voilà: https://test.skohub.io/hbz/vocabs-edu/
- PR: https://github.com/perma-id/w3id.org/pull/1483
