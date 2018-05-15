Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:41367 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeEOU0p (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 15 May 2018 16:26:45 -0400
Received: by mail-ot0-f175.google.com with SMTP id t1-v6so1758813oth.8
        for <backports@vger.kernel.org>; Tue, 15 May 2018 13:26:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526414646.4450.13.camel@sipsolutions.net>
References: <CAF_dkJDhJtg95_DZ96OFuYNRtZkS1YWNZSvB9f_UJL0teDK8eQ@mail.gmail.com>
 <1526414646.4450.13.camel@sipsolutions.net>
From: Patrick Doyle <wpdster@gmail.com>
Date: Tue, 15 May 2018 16:26:14 -0400
Message-ID: <CAF_dkJDB077igL5AiySBXo_aam=8wozCg=-Rc-9=7qMqFd4kKA@mail.gmail.com> (sfid-20180515_222647_936505_A691BECD)
Subject: Re: How to use backports?
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello Johannes,
Thank you for your quick reply.
On Tue, May 15, 2018 at 4:04 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>> From reading https://backports.wiki.kernel.org/index.php/Documentation/integration
>> it would appear that I should be able to do something vaguely like:
>>
>> $ ./gentree.py --integrate --clean --gitdebug ../linux-ath-erstrom
>> ../buildroot/build/linux-custom
>
> In theory yes. I can't really recommend --integrate, it's untested. I
> may remove it entirely since nobody is maintaining it.
So, that's all that I see documented at
https://backports.wiki.kernel.org/index.php/Documentation.  That page
describes 2 workflows: "kernel integration mode" and  "package
releases mode".  The link to the "kernel integration mode"
documentation describes how to run gentree.py.  The link to the
"package releases mode" documentation just says to run "make
menuconfig" without giving any details of how to connect the newer
source tree to an older revision.

It turns out, for my project, I would prefer to use the "kernel
integration mode", since I would really like to turn off loadable
modules (not needed for my space-constrained embedded target).  But if
the "too hard" LED comes on, I can let that go.

Anyway... am I looking in the wrong place for documentation?  Should I
be looking elsewhere?

How do folks use backports anyway?

>
>> You need to have installed: spatch >= 1.0.6
>> Try installing the package: coccinelle
>
> Indeed. There was actually a very recent commit (latest commit) that
> would make this require only an earlier version. Reverting that may be
> easier for you.
OK, I'll try that.  Thanks.
(that just failed to find a
../buildroot/build/linux-custom/backports/Kconfig... which smells a
little like bitrot to me).


>> So, first questions first...
>> Should I reasonably expect gentree to run on a 16.04 LTS Ubuntu?  If
>> so, what dependencies should I install?
>
> No idea, sorry.
>
> johannes
>
If folks don't tend to use this tool on Ubuntu LTS releases, what
version of Linux do you use it on?  What is known to work?

--wpd
--
To unsubscribe from this list: send the line "unsubscribe backports" in
