Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35518 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbcFCTWv (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 3 Jun 2016 15:22:51 -0400
Received: by mail-yw0-f173.google.com with SMTP id o16so89540315ywd.2
        for <backports@vger.kernel.org>; Fri, 03 Jun 2016 12:22:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464980268.2224.8.camel@sipsolutions.net>
References: <1464702541-20621-1-git-send-email-johannes@sipsolutions.net>
	<1464703413.3076.31.camel@sipsolutions.net>
	<67751df1-34ee-6e9f-3dd5-7b9a8400f25e@broadcom.com>
	<1464979700.2224.7.camel@sipsolutions.net>
	<5751D2C9.6080301@broadcom.com>
	<1464980268.2224.8.camel@sipsolutions.net>
Date: Fri, 3 Jun 2016 21:22:50 +0200
Message-ID: <CAF7Mx6rJ-J36YCB3VmXr6=4Q5+=mAe-9G3LYRo+WF-DNERNxoQ@mail.gmail.com> (sfid-20160603_212253_615396_74A3ACD6)
Subject: Re: [PATCH] backports: update devcoredump patch
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jun 3, 2016 at 8:57 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
>
>> I guess I could take your patch as I only need it to build but have
>> to remove -Werror option for that. My nightly testing does not invoke
>> the devcoredump explicitly. It will when our 802.11 psm hangs.
>>
>
> Well, then you don't really need to do anything - the only problem
> would be with drivers that need the new method (none yet); the compiler
> warning about the prototype mismatch is actually harmless (a function
> that used to take a "const void *" now gets a "void *")

That might be true, but I still get error below preparing the backports package:

Failed to apply changes from backport-adjustments/devcoredump.patch
> patching file compat/drivers-base-devcoredump.c
> Hunk #1 succeeded at 31 (offset 1 line).
> Hunk #2 succeeded at 41 with fuzz 1 (offset 1 line).
> Hunk #3 succeeded at 74 (offset 1 line).
> Hunk #4 succeeded at 86 (offset 1 line).
> Hunk #5 succeeded at 122 (offset 1 line).
> Hunk #6 succeeded at 134 (offset 1 line).
> Hunk #7 succeeded at 179 (offset 1 line).
> Hunk #8 succeeded at 325 (offset 44 lines).
> Hunk #9 succeeded at 372 with fuzz 2 (offset 65 lines).
> patching file include/linux/backport-devcoredump.h
> Hunk #1 FAILED at 5.
> Hunk #2 succeeded at 100 with fuzz 2 (offset 70 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file include/linux/backport-devcoredump.h.rej

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
