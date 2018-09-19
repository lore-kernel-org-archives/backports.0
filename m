Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:28434
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731025AbeISO0Z (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 19 Sep 2018 10:26:25 -0400
Date: Wed, 19 Sep 2018 10:49:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Hauke Mehrtens <hauke@hauke-m.de>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] 0079-netdev-destructor.cocci very slow
In-Reply-To: <1537346626.10305.2.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1809191047200.4106@hadrien> (sfid-20180919_104936_292426_34F1BC41)
References: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de> <1537262543.2957.19.camel@sipsolutions.net> <c823a257-4a1e-f3d0-d5a4-4face3c0c85a@hauke-m.de> <1537346626.10305.2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Wed, 19 Sep 2018, Johannes Berg wrote:

> On Tue, 2018-09-18 at 23:52 +0200, Hauke Mehrtens wrote:
>
> > > spatch should already try that internally, but perhaps with some extra
> > > knowledge we can do a better job ...
>
> > Yes we talked about this topic some months ago in IRC.
> > If there is really no better solution, then I will grep in all files for
> > needs_free_netdev and priv_destructor and only apply this to the files
> > which are matching. This list should be pretty short.
>
> Right. No objection to that. Perhaps we should have some sort of special
> comment header for our spatches that the script can consume?
>
> Something like
>
> // restrict-files: grep -qE 'needs_free_netdev|priv_destructor'
>
> and we'd run that on all files? Or perhaps the API should be more a la
> "grep -lE" so we can run it on many files and get a list of matching
> files out?
>
> > It looks like coccinelle already does such a grep when I remove the <--
> > --> from the patch, because this is about 100 times faster.
>
> Good point, not sure why it doesn't do that with the <... ...>?

Because <... ...> means 0 or more of what is inside.  <+... ...+> looks
for one or more and may be faster.  On the other hand, it ensures that
there is one or more, which can also be expensive.

It could be better to just have a rule:

@worthwhile@
@@

(
functions(...)
|
you(...)
|
like(...)
)

and then have the <... ...> rule depend on worthwhile.

julia
--
To unsubscribe from this list: send the line "unsubscribe backports" in
