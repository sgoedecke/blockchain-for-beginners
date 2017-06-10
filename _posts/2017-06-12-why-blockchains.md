---
layout: post
title:  "Why blockchains?"
permalink:   /why-blockchains/
---

What kind of problem is a blockchain designed to solve? Suppose you want to write an database-backed app, without using a server. All your users will have a copy of your app, and must be able to read and write to a shared data store at will. When they read from the store, they should get the latest copy of everyone else's writes. Since most blockchain implementations are crypto-currencies, this is often called a _ledger_.

How would we design an app like this? Since we don't have a server, we'll have to make all the copies of our app connect to each other and share data somehow. Luckily, this problem's already been solved by peer-to-peer networking, most famously used in torrent clients.

But building a torrent client is easier than our problem, since torrenters will just be downloading copies of the same file. Torrenting is a write-once system: once a file is made available, it can't be added to or altered. It's easy to prevent people tampering with a file by putting a hash on it: if the hash of the copy of `Twilight[aXXo].mp4` you downloaded doesn't match the hash in the `.torrent` file, you (or at least your torrenting program) knows it's an invalid download.

>There's nothing to stop a hacker from uploading a `.torrent` file that's associated with a malicious copy of _Twilight_. But there's safety in numbers: if thirty thousand people have downloaded a particular copy of the movie, and haven't reported it as malicious, you can be pretty sure it's safe - since you _know_ from the hash that you're getting exactly the same file that they did.

Like a torrent client, our blockchain app will rely on hashes to verify that you've got the right copy of the ledger. But unlike a torrent client, we don't just want to download the right copy of the ledger - we also want to _write_ to the ledger. The first glaring issue here is preventing someone from rewriting history. Since we don't actually have a database, and thus have no single source of truth, we'll have to find another way to stop people tampering.

>Can we just stick a hash on the ledger, like we do with torrents? No, because every write will invalidate the hash. You could generate a new hash when you write, but there's no reason for any other user to believe you've just added something to the ledger and haven't altered anything you weren't supposed to.
