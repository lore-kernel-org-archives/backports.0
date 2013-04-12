Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:59123 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab3DLJQT (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 05:16:19 -0400
Received: by mail-la0-f48.google.com with SMTP id fq12so2285685lab.21
        for <backports@vger.kernel.org>; Fri, 12 Apr 2013 02:16:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365752487.8399.4.camel@jlt4.sipsolutions.net>
References: <1365748868-3174-1-git-send-email-mcgrof@do-not-panic.com> <1365752487.8399.4.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 12 Apr 2013 02:15:57 -0700
Message-ID: <CAB=NE6XjtSPEFqnJ0PbB9D7Z3HBJbhoK_W+iMbiJMVBiFvXYEQ@mail.gmail.com> (sfid-20130412_111640_613864_247FE6CB)
Subject: Re: [RFC] backports: redefine srctree
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 12, 2013 at 12:41 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Thu, 2013-04-11 at 23:41 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> Drivers may do header sharing in their subsystems by
>> not using a full include path. There are different ways
>> folks append the include path, one strategy is to use
>> srctree as follows:
>>
>> ccflags-y += -I$(srctree)/drivers/media/dvb-core/
>
> We also have a patch for net/wireless/Makefile because of this
> (patches/collateral-evolutions/network/35-fix-makefile-includes/net_wireless_Makefile.patch
>
> --- a/net/wireless/Makefile
> +++ b/net/wireless/Makefile
> @@ -20,6 +20,6 @@ CFLAGS_trace.o := -I$(src)
>  ccflags-y += -D__CHECK_ENDIAN__
>
>  $(obj)/regdb.c: $(src)/db.txt $(src)/genregdb.awk
> -       @$(AWK) -f $(srctree)/$(src)/genregdb.awk < $< > $@
> +       @$(AWK) -f $(src)/genregdb.awk < $< > $@
>
>  clean-files := regdb.c
>
>> The above gets fixed by the kernel through addtree which
>> prefixes -I with $(srctree) if it was not set. To take
>> advantage of the kernel's srctree but not break the build
>> we must lead it back in to the scripts/Makefile.build,
>> we do this by using our own scripts/Makefile.build that
>> points back to the kernel's.
>> ---
>>
>> Note: this breaks the kernel's build scripts that rely on
>> srctree so ideally we'd want to modify instead addtree but
>> I can't figure out how. Thoughts?
>
> Yeah I was going to say ... does this actually work? It also relies on
> the kernel's Makefile.build existing in all versions of the kernel, is
> that actually true? Just curious.

I tried ckmake --allyesconfig and its looked actually fine for the
older kernels, for the newer ones it started messing up due to some
perl script that was being looked up via srctree.

> I don't see a good way to solve these things other than patching them,
> unfortunately.

So what if we had instead of obj-m backport-m ? We might have to
reinvent a lot of the while but all I think we'd need is to add a
backport_addtree for the header hack.

> An alternative might be to have the gentree script replace "$(srctree)"
> with "$(backport-sourcetree)" in the copied Makefiles, and then just set
> that variable?

Sexy. Thanks Python.

  Luis
