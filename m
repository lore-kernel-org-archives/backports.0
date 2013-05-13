Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:56893 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab3EMRYK (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 13:24:10 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so1006088lbd.20
        for <backports@vger.kernel.org>; Mon, 13 May 2013 10:24:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368446891.8300.25.camel@jlt4.sipsolutions.net>
References: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
 <1368298469-29143-2-git-send-email-mcgrof@do-not-panic.com> <1368446891.8300.25.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 13 May 2013 10:23:48 -0700
Message-ID: <CAB=NE6XGM6HQ=Af1+TNLc2BZGQJUxPHr3BT+mVL51XZVVL77QQ@mail.gmail.com> (sfid-20130513_192413_035494_7FF32B2D)
Subject: Re: [PATCH v2 1/5] backports: backport rfkill properly
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, May 13, 2013 at 5:08 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Sat, 2013-05-11 at 11:54 -0700, Luis R. Rodriguez wrote:
>>   * For kernels >= 2.6.31:
>>         o use the standard
>>                 /dev/rfkill
>>                 /sys/class/rfkill
>
> I think this is wrong. It means that if you build rfkill (e.g. for 3.2)
> then it would conflict with the kernel's rfkill.

It would replace it unless you built it obj-y. What issues are there
with replacing in your example 3.2's rfkill?

> The thing is that *usually*, for >=2.6.31, you just want to use the
> kernel's rfkill. So for that usage, we should backport the rfkill API,
> like we usually backport things.

On second thought I can see this being true given that we don't
backport WiMax, UWB, GPS (although I think this is serial and FM (not
used in the kernel) but the API has remained consistent too so don't
see this breaking those drivers ?

> However, NFC probably requires a backported rfkill, not just backporting
> around rfkill.

Indeed.

> For this we do need it named rfkill_backport though, I
> think.

Using a separate namespace is fine too but that would then require
also changing the module name which I just saw now were only doing
before it seems on compat-drivers, this change got lost on backports
somehow.

> Maybe we can backport the NFC support in some other way?

Using a different module and namespace is possible, we however lost
the Makefile changes even for older kernels.

  Luis
