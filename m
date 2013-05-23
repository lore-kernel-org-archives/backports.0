Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:54053 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab3EWGZw (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 May 2013 02:25:52 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so2852527lab.12
        for <backports@vger.kernel.org>; Wed, 22 May 2013 23:25:50 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 22 May 2013 23:25:30 -0700
Message-ID: <CAB=NE6WfdFenyispiH36SZX2wnNhOLBT6+ug001yAvmC-3pkJg@mail.gmail.com> (sfid-20130523_082554_133929_22063A5F)
Subject: Additional flags to backports releases
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Given that we've done a whole full reshuffle of backports I figured
it'd be a good time to ask how the extra additional flags to releases
has been for users / distributions / etc. For those unfamiliar please
check out:

https://backports.wiki.kernel.org/index.php/Documentation/compat-drivers/additional-patches

We use to apply patches from these directories provided you supplied
either and/or of the arguments: -s -n -p -c.  In short, the legend:

 * -s - get and apply pending-stable/ from linux-next.git
 * -n - apply the patches linux-next-cherry-picks/ directory
 * -p - apply the patches on the linux-next-pending/ directory
 * -c - apply the patches on the crap/ directory
 * -u - apply the patches on the unified-drivers/ directory

The -u stuff likely is going to fade away given that the alx driver
now just needs to be upstreamed and that was the only one that tried
to follow that route. The others were useful to help upkeep release as
vendors required but by still respending the upstream process and
highly prioritizing it. Given that we had metrics on each release and
amount of code / patches from each directory this also gave us a sense
of what poo we were failing at: not getting code posted at all, not
getting stable patches merged soon enough, tons of non-critical fixes
on linux-next giving us an indication of how bad the original code
could be, etc. I love statistics, and I believe we have yet to compile
a new set of statistics since the last time this was reviewed, so I
may go out and try to generate the old code-metrics style file but
with Python. Apart from that though -- do we like the flags and
annotations for the different releases?

One of the things that proved a bit cumbersome was getting these extra
patches all tidied up in order. I'm wondering if perhaps instead
supplying public feeds for each release might make more sense for each
driver for each PGP signed release on either linux-next or
linux-stable. These patches would also have to be PGP signed,
otherwise they could have poo. I think that might be more sustainable
and provides the flexibility for *anyone* to pull cherry picked
patches for each tag out there, regardless if this is for backports or
not -- well I guess this would be a bit more specific to backports
given at times we do modify the original code slightly.

Thoughts?

  Luis
