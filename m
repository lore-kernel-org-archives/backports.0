Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35249 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754393AbcHSBdr (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 21:33:47 -0400
Date: Thu, 18 Aug 2016 18:14:51 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: backport-4.7.c fails due to missing rhashtable.h for target <
 3.17
Message-ID: <20160818161451.GJ3296@wotan.suse.de> (sfid-20160819_033405_865701_480A8843)
References: <trinity-e021195e-a0df-484c-9ba9-6d30922988b8-1470901957548@3capp-gmx-bs55>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <trinity-e021195e-a0df-484c-9ba9-6d30922988b8-1470901957548@3capp-gmx-bs55>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 11, 2016 at 09:52:37AM +0200, Peter Huewe wrote:
> Hi,
> playing around with backports,
> unfortunately the backport code for 4.7 fails to compile if the target kernel is < 3.18.
> 
> make allyesconfig
> make 
> ...
>   CC [M]  /home/peter/linux-3-backport/compat/backport-4.7.o
> In file included from /home/peter/linux-3-backport/backport-include/linux/rhashtable.h:3:0,
>                  from /home/peter/linux-3-backport/compat/backport-4.7.c:14:
> /home/peter/linux-3-backport/include/linux/rhashtable.h:3:35: fatal error: linux/rhashtable.h: No such file or directory.
> compilation terminated.
> 
> 
> The linux/rhashtable was introduced in 3.17,
> 
> The backport-4.7 has however
> #include <linux/export.h>
> #include <linux/list.h>
> #include <linux/rcupdate.h>
> #include <linux/rhashtable.h>
> #include <linux/slab.h>
> #include <linux/spinlock.h>
> 
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> 
> 
> 
> Does the rhashtable.h need to be include-guarded somehow ? (e.g. moving the
> if LINUX_VERSION_CODE up and maybe even changing it to 3.17?).
> 
> Or do we have to add rhashtable.h to the copy-list?

The commit that added the backport is:

commit 0b879b047cd07cdde5bea835493d64c9f214c938
Author: Hauke Mehrtens <hauke@hauke-m.de>
Date:   Sun Jul 10 16:50:27 2016 +0200

    backports: add rhashtable_walk_init()
    
    Since commit 1068c678f "rhashtable: accept GFP flags in
    rhashtable_walk_init" rhashtable_walk_init() takes an additional
    parameter which is also used by the mac80211 code, so backport the
    function. For kernel < 4.1 this is not needed, because we already ship
    a recent version of rhashtable. Add rhashtable_walk_init() instead of
    adding the complete rhashtable to same some space on recent kernel
    versions.
    
    Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

So this backported only rhashtable_walk_init() with a new additional
argument and does so only for kernels >= 4.1 but not that backport-4.7.c
will not be required to be compiled on 4.7 so this is for [ 4.1..4.6 ].

It says that for kernels older than 4.1 this respective backport is not
needed as we ship a recent version of rhashtable for them. Indeed, this
was added via commit ba78c101455b85c58831c808e0f0cf0a12f2c76:

commit ba78c101455b85c58831c808e0f0cf0a12f2c760
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Apr 1 17:31:35 2015 +0200

    backports: include rhashtable
    
    As mac80211 now needs rhashtable, include it in backports.
    For now, it actually depends on mac80211 and is selected
    for kernels < 4.1 -- it existed in previous kernels but
    with different API, so cannot be used from there easily.
    
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

The trick done via backport/compat/Kconfig to use:

+       #h-file linux/rhashtable.h
+       #c-file lib/rhashtable.c


Copies the header and code. It notes that the "current API"
was introduced as of 4.1, as such it only does this for
kernels which require new code added as of 4.1, so kernels
older than 4.1

If you are stuck in between 4.1 and 4.6 you are going to lack
the new added gfp flag, and that is what Hauke provided. It seems
Johannes work provides a full replacement of the rhash table stuff
for older kernels then, so what you describe and suggest seems to be
already done.

If this is failing to compile, indeed that would be an issue, and
is unexpected if it sin a stable releases, issues at compile time
should really only creep up if you are adding new code or are using
a really odd kernel configuration -- the compilation tests run through
ckmake are done with the config from the distribution, in this case
historically backports just relied on Ubuntu's kernel configuration
as Ubuntu was providing Vanilla kernels built, and that made our lives
easier. By using those kernels we then could just extract the kernel
headers and a sensible distro kernel configuration base.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
