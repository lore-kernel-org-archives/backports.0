Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57502 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbbFPACe (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Jun 2015 20:02:34 -0400
Date: Tue, 16 Jun 2015 08:02:01 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Michal Marek <mmarek@suse.cz>,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: Super simple boot test for backports
Message-ID: <20150616000201.GA31195@wfg-t540p.sh.intel.com> (sfid-20150616_020237_303505_9EC62ACD)
References: <CAB=NE6U7c7qHkcBkCP6TH=khmudOeUS6vXYM7848Z1jn5teABw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB=NE6U7c7qHkcBkCP6TH=khmudOeUS6vXYM7848Z1jn5teABw@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Luis,

On Mon, Jun 15, 2015 at 03:53:18PM -0700, Luis R. Rodriguez wrote:
> We currently do a 'ckmake' compilation test of a Linux backports
> release prior to a release, this consists compilation of a release
> over 30 vanilla kernels with one default popular kernel configuration.
> This takes about 1 hour now on a 32-core system with 256 GiB of RAM
> and all source code being on RAM. We now have support to enable
> backported stuff as built-in, we call this integration support [0] but
> we have no formal build testing for that, perhaps we should start
> doing that but note that if building all modules takes 1 hours on 30
> kernels this will likely take much longer as we'd then be building 30
> full kernels. Its a pain but if we're going to support this I think we
> should look towards that, and the only thing I can hope for is perhaps
> a distributed build test, or we just see if we can get a bigger box.
> Last time we hit a crux like this we got a bigger box thanks to HP,
> SUSE and the Linux Foundation and it's helped quite. The number of
> subsystems we backport has increased and so has our userbase, as well
> as our R&D and developer base.

The 0day kbuild test farm has enough powerful CPUs for carrying out
comprehensive test coverage. You may leverage the 0day facilities by
exporting the backports patches as regular kernel git tree/branches.

> Apart from this I think it'd also worth we start doing some very
> simple run time tests prior to a release. Considering our current
> build test takes about 1 hour and we have 32 cores and we support
> about 30 kernels, it would seem adding a very simple run time test
> that might take 1 minute, one kernel per CPU, might be worth it. I
> don't think doing integration kernel build testing is NOT needed right
> now per se, but its something we should consider towards the future if
> we get a bigger box. Run time tests however would seem very useful and
> I think we can squeeze them in.

We also do boot tests in qemu-system-x86_64, qemu-system-i386 and a
number of physical machines. I'd be happy to help test the backports
trees out.

> For run time tests it'd be great if we can leverage off of someone's
> else's work already. Fengguang's work with 0 day tests comes to mind
> as one place to pook and look at but I'm not sure if the stuff in
> place there is overly complex for what we'd need. Since we backport,

It'd be 0 complexity if running the tests in our test farm. However in
case you are interested, here are the runtime tests we run 7x24 in
about 60 test machines and more QEMU boxes:

https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/

This is the mac80211_hwsim test case:

https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/jobs/hwsim.yaml
https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/tests/hwsim
https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/tree/pack/hwsim

> obviously we'd want to at least test a few drivers, that poses however
> a challenge in that any meaningful backports test should require
> loading at least a driver. Loading drivers require libc, with libkkmod
> at least, so we'd need those, unless of course we use sysfs echo
> hacks. A simple test unit that comes to mind without requiring a full
> init system could be for instance force loading mac80211_hwsim and
> issuing a simple scan request, even though it won't return anything.
> It would seem likely some folks already have most of this already
> written and we can just mesh things in. Ideally, if we had integration
> testing going, we could avoid loading modules and just build things as
> built-in and then we'd just test that the kernel can boot, and perhaps
> do a very simple run time test. If we go this route what should we do?
> 
> Let me know your thoughts, and if anyone really values kernel
> integration support -- consider poking us about a possible help on a
> box upgrade :)
> 
> [0] https://backports.wiki.kernel.org/index.php/Documentation/integration

Thanks,
Fengguang
