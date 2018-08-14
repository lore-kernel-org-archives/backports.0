Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32178 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729955AbeHNQHO (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 14 Aug 2018 12:07:14 -0400
Date: Tue, 14 Aug 2018 15:19:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Luciano Coelho <luciano.coelho@intel.com>
cc: cocci@systeme.lip6.fr, backports@vger.kernel.org
Subject: Re: [Cocci] New release after 1.0.7?
In-Reply-To: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
Message-ID: <alpine.DEB.2.20.1808141515280.3371@hadrien> (sfid-20180814_152007_774372_35ED45D6)
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Tue, 14 Aug 2018, Luciano Coelho wrote:

> Hi,
>
> Is there a plan for a new release after 1.0.7? 1.0.7 was not tagged and
> no tarballs were released, so I'm not sure what is the status of it.
> Additionally, I've had problems compiling it, and bisected it to this
> commit:
>
> commit 7ab8f01b63d7cdec988e5f05065f3c18fdab7319 (refs/bisect/bad)
> Author:     Thierry Martinez <thierry.martinez@inria.fr>
> AuthorDate: Wed Jun 20 15:46:18 2018 +0200
> Commit:     Thierry Martinez <thierry.martinez@inria.fr>
> CommitDate: Wed Jun 20 15:46:18 2018 +0200
>
>     Allow bytecode compilation for pyml/generate
>
>     This change generalizes a patch submitted by
>       Christopher Zimmermann <chrisz@openbsd.org>
>     for allowing pyml/generate to be compiled by ocamlc if ocamlopt
>     is not available.
>
>     The rules are adapted from pyml-current/Makefile.
>
> Nevertheless, the compilation problem I had seems to be fixed in the
> latest master (commit 97695d059cd5).
>
> We (in the Linux backports project) have made a change to support the
> new attributes style[1], which was supposed to work with 1.0.6, but
> that seems to be broken too.
>
> We don't want to revert to using the pre-1.0.6 versions, so we are
> waiting for new release to choose for our project.  So, my question
> again, can we expect a new stable release any time soon?

Sorry, I'm not sure where 1.0.7 came from.  I think that the compilation
issues should not be resolved, although if someone still sees problems
with the github version please report them.  I'm surprised that the
attributes have degraded, since I don't recall a change with respect to
that recently.  Could you send a .c and .cocci file that shows the
problem?

I would indeed like to make a release now that the compiations issues are
resolved and things seem more stable.

julia


>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/commit/?id=98272f479c2126a135dfcb12484e93d5888164ab
>
> --
> Cheers,
> Luca.
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--
To unsubscribe from this list: send the line "unsubscribe backports" in
