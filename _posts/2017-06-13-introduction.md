---
layout: post
title:  "Introduction"
permalink:   /introduction/
---

This is a guide for developers who kinda sorta know what blockchains _are for_ (making distributed crypto-currencies like Bitcoin possible) but have no idea what exactly is involved in that or how it works.

This problem is compounded by the fact that popular discussions of (e.g.) Bitcoin try to make it interesting by pumping up the mathematics side of it, which makes it sound even more inaccessible to developers without strong maths or CS chops. For instance, news articles will mention that placing a "block" in the "chain" - whatever that means - requires solving a very difficult mathematical problem. This sounds complicated! But it reality it's just "mutate a string over and over until its md5 hash meets a very stringent condition". Yes, it's a difficult maths problem, but the implementation couldn't be simpler.

By the end of this article, I hope you'll understand why blockchains work, and feel comfortable writing a ~200 line toy blockchain client in your language of choice. (That's two hundred lines, not a typo.)
