Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33434 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbbFSRvt (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jun 2015 13:51:49 -0400
Received: by igbqq3 with SMTP id qq3so21636439igb.0
        for <backports@vger.kernel.org>; Fri, 19 Jun 2015 10:51:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434578988-18411-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434578988-18411-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 19 Jun 2015 10:51:29 -0700
Message-ID: <CAB=NE6UpXMqcb-03wJbXdDKAUjr_GJbsgGHBGPz38GSh5iFq5w@mail.gmail.com> (sfid-20150619_195201_768895_DC8BAD48)
Subject: Re: [PATCH] gentree.py: use Coccinelle's new Parallelism support
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Xavier Clerc <xavier.clerc@inria.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Jun 17, 2015 at 3:09 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> As of coccinelle-1.0.0-rc24 Coccinelle got its own built-in
> parallelism support which does not require use of the separate
> instances to be spawned. Coccinelle's new built-in parallelism
> uses the parmap library for this.
>
> Replace the pycocci script, which is no longer needed. I've
> tested this with the 1.0.0 and 1.0.0-rc24 release and get
> the same results for both releases.
>
> When comparing our old way of doing things (using pycocci)
> vs using the new parallellism support (-j option for spatch)
> I see a general performance boost of at least ~10 seconds
> right on average now when generating code using gentree.py
> on the backports build server.
>
> Cc: Xavier Clerc <xavier.clerc@inria.fr>
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  devel/pycocci | 174 ----------------------------------------------------------
>  gentree.py    |  23 +++++---
>  2 files changed, 16 insertions(+), 181 deletions(-)
>  delete mode 100755 devel/pycocci

I ran into a snag with this feature, I reported it to the cocci
mailing list [0], so for now we can't merge this.

[0] https://systeme.lip6.fr/pipermail/cocci/2015-June/002140.html

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
