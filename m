Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:39696 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3C1WZH (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 18:25:07 -0400
Received: by mail-la0-f52.google.com with SMTP id fs12so37030lab.25
        for <backports@vger.kernel.org>; Thu, 28 Mar 2013 15:25:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6X9X0apA0tR-f2_f24W-sWXhUVky2OGEQhAO3=ta1Q2pA@mail.gmail.com>
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net> <CAB=NE6X9X0apA0tR-f2_f24W-sWXhUVky2OGEQhAO3=ta1Q2pA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 28 Mar 2013 15:24:44 -0700
Message-ID: <CAB=NE6U=_C72wQLQbXdqN88tudZr7U9Quk_FVeYSgYwEgzeusQ@mail.gmail.com> (sfid-20130328_232511_312472_24B65844)
Subject: Re: compat-drivers wishlist
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 3:15 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Thu, Mar 28, 2013 at 2:49 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
>> 4) Kconfig.
>>    This is a bit conflicting with 1) because a valid Kconfig structure
>> requires
>>    all the sub-Kconfig files exist. Maybe ship all Kconfig files, or
>> automate a
>>    way to remove "source" statements for files that don't exist
>> (probably easy)
>
> I think its possible to remove not desired source code based on
> reading .config. This can be done as a pass if the Kconfig to Makefile
> thing is figured out. Then as a secondary step I think we can remove
> directories that have just a Kconfig / Makefile, but that's
> theoretical, in practice this may be harder, the biggest issue I think
> would be to ensure removal of the calling 'source foo/Kconfig' entry,
> or we extend Kconfig to support Kconfig imports that don't exist, sort
> of with Makefile and the -include foo.mk trick.

Another thing I should mention here about Kconfig.

'make localmodconfig' is great and IMHO something which we should
strive for as well for end users. The issue comes in when you have to
build something for remote systems. For this I wrote a script a while
ago to let us extract only the necessary components from the kernel,
scp to target, and extract back our .config [0]. This is hacky but
something to keep in mind.

[0] https://lkml.org/lkml/2009/11/12/350

  Luis
