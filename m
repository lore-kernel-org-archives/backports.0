Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:43864 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751335AbbGUGLo (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 21 Jul 2015 02:11:44 -0400
Date: Tue, 21 Jul 2015 08:11:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: cocci@systeme.lip6.fr, backports@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3 0/5] pycocci: few updates and add to install
 target
In-Reply-To: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <alpine.DEB.2.02.1507210811190.2065@localhost6.localdomain6> (sfid-20150721_081146_599802_08916E19)
References: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 20 Jul 2015, Luis R. Rodriguez wrote:

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This v3 addresses the changes noted by Julia. Since this is extending
> features to help with SmPL patch development, in particular --show-proof,
> and since we're using quite a bit of heuristics useful to users of Coccinelle
> depending on their version installed document all this on a proper man page
> for pycocci and also add pycocci into the install target.
> 
> In the future we should probably just let pycocci read ini type of file
> on say your ~/.pycocci which will let you specify and customize further
> defaults we'd inherit depending on your target. Then you can further
> customize your options per project. Each upstream project can then also
> have their own .pycocci perhaps which promotes a set of options to use.
> For instance right now Linux scripts/coccinelle/ lets scripts gather
> options to use per SmPL patch. We shoul standardize on a format format
> for that and to enable project specific tuned variables.
> 
> If there are no issues with this v3 I'll merge soon.

I'm OK with the concept of all of these.

julia


> Luis R. Rodriguez (5):
>   pycocci: add requirements class
>   pycocci: add git class
>   pycocci: figure out if to enable --jobs, --use-gitgrep or
>     --use-glimpse
>   pycocci: add Coccinelle SmPL patch proof support
>   pycocci: add man page and promote pycocci to install target
> 
>  Makefile       |   3 +
>  docs/pycocci.1 | 217 ++++++++++++++++++++++++++
>  tools/pycocci  | 486 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 687 insertions(+), 19 deletions(-)
>  create mode 100644 docs/pycocci.1
> 
> -- 
> 2.3.2.209.gd67f9d5.dirty
> 
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
