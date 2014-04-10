Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:34696 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758758AbaDJRQo (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 10 Apr 2014 13:16:44 -0400
Received: by mail-la0-f53.google.com with SMTP id b8so2596978lan.12
        for <backports@vger.kernel.org>; Thu, 10 Apr 2014 10:16:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE5JcOUSAQhHR82+M10kOwSaC53RB3B0d8oudwbFDuCPh_rwbA@mail.gmail.com>
References: <CAE5JcOWEv65JjjhV0LyvTSBPYKrEyZem_+Wy07Cz4qaLP7218A@mail.gmail.com>
 <CAB=NE6VnNNfRDO488S65Cjo1JfdonZ7tF6pmqQFE=5y0WhMLwg@mail.gmail.com> <CAE5JcOUSAQhHR82+M10kOwSaC53RB3B0d8oudwbFDuCPh_rwbA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Thu, 10 Apr 2014 10:16:22 -0700
Message-ID: <CAB=NE6UbppvnpFnMtCLCOTnDSm53u+WoEXYQYnAiZ-QTNKT3Cw@mail.gmail.com> (sfid-20140410_191647_886818_ECBA4320)
Subject: Re: Back ports question
To: Shridatt Sugrim <ssugrim@winlab.rutgers.edu>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Apr 10, 2014 at 8:43 AM, Shridatt Sugrim
<ssugrim@winlab.rutgers.edu> wrote:
> Thanks Luis, and Backports :)
>
> I'm pretty sure I've cloned that repo because I was reading the docs from
> back ports wiki. I guess I should build the 3.2.y that's in the similarly
> branch instead of trying to keep my tree?

I'm under the impression you have a backports on a linux-3.2.y branch
(maybe we should rename these branches to backports-3.2.y for emphasis
and to distinguish from Linux names), if so my objective was to try to
convince you that that branch is only for backporting 3.2 kernel code.
In other words it would produce a backports-3.2 sort of release, and
that release can be used for *any* supported kernel below 3.2, it *is
not* mean to be used when you are on the 3.2 kernel on your Debian
box. You want the latest and greatest backports releases, either the
latest stable release or one based on linux-next.

We've struggled with trying to educate a bit better on this buts its
unclear what we can do to help with this mild but very important
difference.

> I'll give the update manager a
> shot and see what happens, if not I'll try to build what is in the 3.2.y
> branch with my running config, and hope that it works.

You don't want to use the 3.2.y branch on either linux or backports,
you want to use the 3.14.y branch on both, or if daring try the master
branch on backports and a respective linux-next tag. That or you can
wait for a public backports-3.14.y release or a new linux-next based
release.

  Luis
