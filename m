Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36482 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbdGNCig (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Jul 2017 22:38:36 -0400
Received: by mail-wm0-f54.google.com with SMTP id 62so8510705wmw.1
        for <backports@vger.kernel.org>; Thu, 13 Jul 2017 19:38:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713172814.GB21846@wotan.suse.de>
References: <CAFv23QnvFGj3b2GCV=v=mGk8JgGwZRe+W-+m9gxbtAsChySz=Q@mail.gmail.com>
 <59673BA0.20703@broadcom.com> <20170713172814.GB21846@wotan.suse.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Fri, 14 Jul 2017 10:38:34 +0800
Message-ID: <CAFv23QnhCbD9n+JrU3a1sHHjnBHkdcgwNTje8AzSVvKAqyNJ+A@mail.gmail.com> (sfid-20170714_043838_156929_6513D593)
Subject: Re: Adding the BT driver
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes.berg@intel.com>, hauke@hauke-m.de,
        backports@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2017-07-14 1:28 GMT+08:00 Luis R. Rodriguez <mcgrof@kernel.org>:
> On Thu, Jul 13, 2017 at 11:21:36AM +0200, Arend van Spriel wrote:
>> On 7/13/2017 5:07 AM, AceLan Kao wrote:
>> > Hi all,
>> >
>> > I'm working on adding BT driver back to linux backport driver, and got
>> > some questions.
>>
>> I suppose it means you also want to maintain BT support in backports
>> project?
>
> Which has me thinking perhaps the policy we need is a MAINTAINERS.backport file
> or something?

Yes, I'm willing to maintain bt subsystem.

>
>> > 1. Do we still do building the backport driver against all the
>> > supported kernels? I didn't see those reports in git log recently, so
>> > I'm wondering while backporting BT driver, can I skip some old
>> > kernels' support.
>>
>> Well. You could limit the earliest kernel by adding a dependency in the
>> dependencies file.
>>

got it, will try to run ckmake to check how far I can do

>> > 2. Is there a script that can help me to build the backport driver
>> > against certain kernels?
>>
>> Not really. You just run make from the backports package and provide
>> KLIB_BUILD=... on the command line referring to the target kernel headers.
>
> There is documentation:
>
> https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking#Adding_new_driver
>
> I updated it recently as I demo'd adding yet-another new subsystem (not
> upstream, nor patches posted).
Thanks, I'll check the steps carefully to make sure I didn't missing anything.

>
>   Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
