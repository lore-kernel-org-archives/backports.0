Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46138
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501AbbGRRBf (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 Jul 2015 13:01:35 -0400
Date: Sat, 18 Jul 2015 19:01:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: cocci@systeme.lip6.fr, johannes@sipsolutions.net,
	backports@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2 0/4] pycocci: index opts, SmPL patch proof
 support
In-Reply-To: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6> (sfid-20150718_190449_619738_EF07CE45)
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 17 Jul 2015, Luis R. Rodriguez wrote:

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This v2 changes the way we do git tree inference by using
> git rev-parse. While at it, I decided to mesh in SmPL  <--> patch
> equivalence proof support. This is a generalized solution, I
> originally had written for the backports project, we now give
> this instead a proper home and purpose under pycocci.
> 
> If there are no issues I'll merge this soon, in hopes it will
> make it for the coccinelle 1.0.2 release.
> 
> Luis R. Rodriguez (4):
>   pycocci: add requirements class
>   pycocci: add git class
>   pycocci: figure out if to enable --jobs, --use-gitgrep or
>     --use-glimpse

Do you need patches 2 and 3?

julia

>   pycocci: add Coccinelle SmPL patch proof support
> 
>  tools/pycocci | 475 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 462 insertions(+), 13 deletions(-)
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
