Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:40077 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab3EPW3U (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 18:29:20 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so1334752lab.29
        for <backports@vger.kernel.org>; Thu, 16 May 2013 15:29:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368703470.8387.3.camel@jlt4.sipsolutions.net>
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
 <1368603799.8359.5.camel@jlt4.sipsolutions.net> <CAB=NE6UiZPP02y126Qxc5c7q1wFer0_9cZLFP_QCQo_Z6uGJmQ@mail.gmail.com>
 <CAB=NE6Ut5CdpistLecYnbzK-t+Rymw-Gzhj=DdhYEcm8DGPBYw@mail.gmail.com>
 <CAB=NE6UrCSYztvoe0HP8fBANki0C4huePhAxxpSb6eV8KnCo6w@mail.gmail.com> <1368703470.8387.3.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 16 May 2013 15:28:59 -0700
Message-ID: <CAB=NE6ULRAH27yF9KnCN8mC7iABOEqh53ZnXC1cf=V6Xj7qd+A@mail.gmail.com> (sfid-20130517_002923_032027_703BF02C)
Subject: Re: [PATCH 0/3] backports: take up up to next-20130426
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 16, 2013 at 4:24 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-15 at 22:44 -0700, Luis R. Rodriguez wrote:
>
>> >> while nouveau fails and uses the later.
>> >
>> > Actually I see now drivers that use either work so this seems to be
>> > nouveau specific.
>>
>> This seems to be because of the new changes that stuffed nouveau files
>> into separate directories:
>>
>> drivers/gpu/drm/nouveau/core/
>> drivers/gpu/drm/nouveau/dispnv04/
>>
>> I've tried this but no luck.
>>
>> --- a/drivers/gpu/drm/nouveau/Makefile
>> +++ b/drivers/gpu/drm/nouveau/Makefile
>> @@ -3,9 +3,9 @@
>>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>>
>>  ccflags-y := -Iinclude/drm
>
> Isn't this part actually the issue?

Yes... thanks. Odd, I thought I tested against that. I'll send patches.

> Are you adding an override ttm_bo_driver.h file? Maybe include_next
> doesn't work right with this -Iinclude/drm?

Nope.

 Luis
