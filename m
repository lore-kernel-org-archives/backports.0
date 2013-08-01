Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48098 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849Ab3HAVHA convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 17:07:00 -0400
Received: by mail-pd0-f172.google.com with SMTP id z11so1712143pdj.17
        for <backports@vger.kernel.org>; Thu, 01 Aug 2013 14:06:59 -0700 (PDT)
From: "Chris R" <chrisrfq@gmail.com>
To: "'Luis R. Rodriguez'" <mcgrof@do-not-panic.com>
Cc: <backports@vger.kernel.org>
References: <000d01ce8e07$80a36430$81ea2c90$@gmail.com> <CAB=NE6WLPxLpGWOP6fj_FEWk_AA4Tz7UQay1tPxsMJfquRnSmg@mail.gmail.com> <007b01ce8eee$cca32e50$65e98af0$@gmail.com> <CAB=NE6Xg_MHwZAaZHHkL841BHJxFzEeu2oMZJdXpqYoGSHjSgQ@mail.gmail.com>
In-Reply-To: <CAB=NE6Xg_MHwZAaZHHkL841BHJxFzEeu2oMZJdXpqYoGSHjSgQ@mail.gmail.com>
Subject: RE: Bug with the website: links are broken
Date: Thu, 1 Aug 2013 14:06:54 -0700
Message-ID: <007d01ce8efb$0e155e60$2a401b20$@gmail.com> (sfid-20130801_230706_057136_DA0C445A)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

> what else can we do to help with this?

Two suggestions come to mind...
  1.  Don't number releases so they look like they correspond to kernel numbers, which implies a need to match.
  2.  Give an example such as:  "In other words, use the current v3.10 release whether you are building for kernel 2.6.32 or 3.10"

Sorry, but although English is my first and preferred language, it can still be deceptively ambiguous.  

How 'bout the following text:

     Backports is an effort to make sure that drivers that are released
     on the newest kernel are also the preferred drivers for use with
     older kernels.  In other words, you can always use the latest stable
     backports release, even on older kernels.  The backports drivers
     are usable back to kernel 2.6.32.

...or something like that.  Whatever the oldest supported kernel is.

Thanks for hitting me up-side the head!

- Chris

-----Original Message-----
From: mcgrof@gmail.com [mailto:mcgrof@gmail.com] On Behalf Of Luis R. Rodriguez
Sent: Thursday, August 01, 2013 12:44 PM
To: Chris R
Cc: backports@vger.kernel.org
Subject: Re: Bug with the website: links are broken

On Thu, Aug 1, 2013 at 12:39 PM, Chris R <chrisrfq@gmail.com> wrote:
>> Its back up...
>
> Thanks very much!
>
>> ...that page has ancient releases, why are you still using them?
>
> I'm stuck at kernel version 2.6.37.

So backports is designed so that you use a backports-3.11 say on 2.6.37. That is you don't have to use a backport-3.10 only on 3.10 in fact that'd be pointless. We backport functionality from a kernel as a base and that base is used as the version name for the release.

A few folks have reported misunderstanding this as well so I'm curious apart from the documentation we have on the wiki [0] what else can we do to help with this?

[0] https://backports.wiki.kernel.org

  Luis

