---
layout: post
title:  "How hash lists prevent tampering"
permalink:   /hash-lists/
---

To solve this, blockchains rely on a data structure called a _hash list_ (sometimes called a Merkle list). It's a way to hash parts of the ledger and the whole thing at the same time. A hash list is a list where each element contains its content, a pointer to the previous element - like a regular linked list - and a hash of that previous element. If we both have a copy of the same hash list, and you add an element on the end, I can verify that you haven't altered any of the existing elements by re-hashing the existing elements and checking the hash (stored on the next element). Once I'm satisfied that you haven't tampered with history, I'll accept your new element. Since each element contains the hash of the previous element, which then goes into the hash stored in the following element, you can't tamper with the order of elements either.

![Hash list](./hash_list.svg)

In our blockchain app, our ledger will be stored as a hash list. Each element in the hash list is called a _block_. (This is where "blockchain" comes from: it's a chain of blocks.) Every time we accept or generate a new block, our blockchain app will send the latest version of the ledger to all its peers on the P2P network. When they verify the hashes in the chain, they'll add the block or blocks they were missing. Changes to the ledger will thus propagate over the network, without anybody being able to change the past.
