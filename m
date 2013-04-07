Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:46968 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757982Ab3DGRjF (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 7 Apr 2013 13:39:05 -0400
Received: by mail-lb0-f176.google.com with SMTP id y8so4984641lbh.7
        for <backports@vger.kernel.org>; Sun, 07 Apr 2013 10:39:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365355372.9172.1.camel@jlt4.sipsolutions.net>
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
 <1365301322-19327-4-git-send-email-mcgrof@do-not-panic.com> <1365355372.9172.1.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 7 Apr 2013 10:38:42 -0700
Message-ID: <CAB=NE6Um5uJ2XJ9T-BDy2jU7xfKhQ7B0aH0hjfZG49B9nXagZg@mail.gmail.com> (sfid-20130407_193909_675775_4DC97F78)
Subject: Re: [PATCH 4/9] compat: backport EPROBE_DEFER value
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Apr 7, 2013 at 10:22 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Sat, 2013-04-06 at 19:21 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> Grant added the ability to the driver core to return
>> EPROBE_DEFER at device driver probe time and for that to
>> trigger a later deferred probe through a workqueue. It
>> seems we could in theory backport this functionality but
>> that requires quite a bit of work. For now just pass on
>> the EPROBE_DEFER definition safely and for older kernels
>> than 3.4 the EPROBE_DEFER would be treated as a regular
>> probe error.
>
>> +#define EPROBE_DEFER   517     /* Driver requests probe retry */
>
> I'm not convinced this is useful, particularly not with that error
> number?
>
> If a driver returns -EPROBE_DEFER it will not work correctly, so why not
> just require it to be disabled (via the dependencies list) for kernels
> before 3.4?
>
> Also, if you return -517 userspace might get somewhat confused?

Sure.

  Luis
