Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:38346 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3DLHla (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 03:41:30 -0400
Message-ID: <1365752487.8399.4.camel@jlt4.sipsolutions.net> (sfid-20130412_094133_264342_DB37238E)
Subject: Re: [RFC] backports: redefine srctree
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Fri, 12 Apr 2013 09:41:27 +0200
In-Reply-To: <1365748868-3174-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130412_084117_670590_A3E3A8CE)
References: <1365748868-3174-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130412_084117_670590_A3E3A8CE)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-04-11 at 23:41 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> Drivers may do header sharing in their subsystems by
> not using a full include path. There are different ways
> folks append the include path, one strategy is to use
> srctree as follows:
> 
> ccflags-y += -I$(srctree)/drivers/media/dvb-core/

We also have a patch for net/wireless/Makefile because of this
(patches/collateral-evolutions/network/35-fix-makefile-includes/net_wireless_Makefile.patch

--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -20,6 +20,6 @@ CFLAGS_trace.o := -I$(src)
 ccflags-y += -D__CHECK_ENDIAN__
 
 $(obj)/regdb.c: $(src)/db.txt $(src)/genregdb.awk
-	@$(AWK) -f $(srctree)/$(src)/genregdb.awk < $< > $@
+	@$(AWK) -f $(src)/genregdb.awk < $< > $@
 
 clean-files := regdb.c

> The above gets fixed by the kernel through addtree which
> prefixes -I with $(srctree) if it was not set. To take
> advantage of the kernel's srctree but not break the build
> we must lead it back in to the scripts/Makefile.build,
> we do this by using our own scripts/Makefile.build that
> points back to the kernel's.
> ---
> 
> Note: this breaks the kernel's build scripts that rely on
> srctree so ideally we'd want to modify instead addtree but
> I can't figure out how. Thoughts?

Yeah I was going to say ... does this actually work? It also relies on
the kernel's Makefile.build existing in all versions of the kernel, is
that actually true? Just curious.

I don't see a good way to solve these things other than patching them,
unfortunately.

An alternative might be to have the gentree script replace "$(srctree)"
with "$(backport-sourcetree)" in the copied Makefiles, and then just set
that variable?

johannes

