Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:37401 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab3J1QuZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 28 Oct 2013 12:50:25 -0400
Received: by mail-lb0-f179.google.com with SMTP id w6so3134699lbh.10
        for <backports@vger.kernel.org>; Mon, 28 Oct 2013 09:50:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1382969837.17956.20.camel@jlt4.sipsolutions.net>
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
 <1382552852-15916-2-git-send-email-hauke@hauke-m.de> <1382690097.4461.0.camel@jlt4.sipsolutions.net>
 <526AE34E.5020300@hauke-m.de> <CAB=NE6XpXqo09-vpkPaY=qMgpJfywS61oNjZ0nkm1Mpd1PrdHA@mail.gmail.com>
 <1382969837.17956.20.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Mon, 28 Oct 2013 17:50:03 +0100
Message-ID: <CAB=NE6XT7JfWubdZeCiJJMVVVhYtPmd4rYGwrwWLQNoX3Ld5jw@mail.gmail.com> (sfid-20131028_175027_289145_D8653C90)
Subject: Re: [PATCH 1/5] backports: fix kernel dependencies for regulator drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Oct 28, 2013 at 3:17 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Sat, 2013-10-26 at 11:45 +0200, Luis R. Rodriguez wrote:
>
>> > Yes moving the dependencies is easier than backporting the code which
>> > does not work any more. ;-) The problem here is that the regulator core
>> > can not be backported, because it is always build into the kernel and
>> > not as a module.
>
>> As for the issues with some functionality on the regulator
>> drivers requiring functionality from future kernels as its always
>> built-in, that can be addressed if we add support for non-modular
>> solutions on backports.
>
> I don't think that's actually true - the regulator drivers may require
> being built-in,

Sorry I didn't mean to say they require, I mean they are typically
used in that way, the core of the subsystem is built-in and does
require to be built in, but the drivers do not. What I'm saying is
that if we had built-in target support we'd be able to backport a more
rich feature set of the functionality.

> but there are probably good reasons for that like
> multiple other modules accessing them.

Yeap that too.

  So updating them in a backport
> and building them in wouldn't really help since now you'd have two
> identical regulators that conflict and have different users.

Its a great point and sets up the expectations of the requirements for
how to properly backport this -- not only its users but all of the
regulator's users.

> And if you tried to backport it into the tree and make it the only
> regulator driver, you'd now have to forward-port all the remaining
> in-tree users as well, which seems unreasonable too.

I'm not sure that's too unreasonable, what other users are there of
the regulator subsystem for drivers other than media ? Answering that
will answer this question and define the scope of the requirements if
this is desirable.

> The only usage would seem to be building it including *all* users as
> part of the backport, but that seems somewhat unlikely?

Ah, yeap, well that's what I mean. This will depend on motivation if
the architecture we provide helps with someone's requirements. I
contend that backporting in-kernel will be easier given you can
backport more features, the major challenge will be having to also
include something like module namespaces or backport all dependencies
on a core component. Possible -- and IMHO if you look at the way
things are currently backported -- its much worse and the gains of
alternative approaches are frankly dismal. I see long term
architectural gains to just backport automatically, but it does
require a bit of kick off work.

  Luis
