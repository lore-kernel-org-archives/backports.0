Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37484 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbbFOWxj (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 15 Jun 2015 18:53:39 -0400
Received: by igbsb11 with SMTP id sb11so2199511igb.0
        for <backports@vger.kernel.org>; Mon, 15 Jun 2015 15:53:39 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 15 Jun 2015 15:53:18 -0700
Message-ID: <CAB=NE6U7c7qHkcBkCP6TH=khmudOeUS6vXYM7848Z1jn5teABw@mail.gmail.com> (sfid-20150616_005341_705828_A7C1A046)
Subject: Super simple boot test for backports
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
	Michal Marek <mmarek@suse.cz>,
	Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We currently do a 'ckmake' compilation test of a Linux backports
release prior to a release, this consists compilation of a release
over 30 vanilla kernels with one default popular kernel configuration.
This takes about 1 hour now on a 32-core system with 256 GiB of RAM
and all source code being on RAM. We now have support to enable
backported stuff as built-in, we call this integration support [0] but
we have no formal build testing for that, perhaps we should start
doing that but note that if building all modules takes 1 hours on 30
kernels this will likely take much longer as we'd then be building 30
full kernels. Its a pain but if we're going to support this I think we
should look towards that, and the only thing I can hope for is perhaps
a distributed build test, or we just see if we can get a bigger box.
Last time we hit a crux like this we got a bigger box thanks to HP,
SUSE and the Linux Foundation and it's helped quite. The number of
subsystems we backport has increased and so has our userbase, as well
as our R&D and developer base.

Apart from this I think it'd also worth we start doing some very
simple run time tests prior to a release. Considering our current
build test takes about 1 hour and we have 32 cores and we support
about 30 kernels, it would seem adding a very simple run time test
that might take 1 minute, one kernel per CPU, might be worth it. I
don't think doing integration kernel build testing is NOT needed right
now per se, but its something we should consider towards the future if
we get a bigger box. Run time tests however would seem very useful and
I think we can squeeze them in.

For run time tests it'd be great if we can leverage off of someone's
else's work already. Fengguang's work with 0 day tests comes to mind
as one place to pook and look at but I'm not sure if the stuff in
place there is overly complex for what we'd need. Since we backport,
obviously we'd want to at least test a few drivers, that poses however
a challenge in that any meaningful backports test should require
loading at least a driver. Loading drivers require libc, with libkkmod
at least, so we'd need those, unless of course we use sysfs echo
hacks. A simple test unit that comes to mind without requiring a full
init system could be for instance force loading mac80211_hwsim and
issuing a simple scan request, even though it won't return anything.
It would seem likely some folks already have most of this already
written and we can just mesh things in. Ideally, if we had integration
testing going, we could avoid loading modules and just build things as
built-in and then we'd just test that the kernel can boot, and perhaps
do a very simple run time test. If we go this route what should we do?

Let me know your thoughts, and if anyone really values kernel
integration support -- consider poking us about a possible help on a
box upgrade :)

[0] https://backports.wiki.kernel.org/index.php/Documentation/integration

 Luis
