Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:13232 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbeIJPhN (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 10 Sep 2018 11:37:13 -0400
Date: Mon, 10 Sep 2018 12:43:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Luciano Coelho <luciano.coelho@intel.com>, cocci@systeme.lip6.fr,
        backports@vger.kernel.org
Subject: Re: [Cocci] New release after 1.0.7?
In-Reply-To: <1536564277.3224.7.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1809101241150.3655@hadrien> (sfid-20180910_124348_993802_BD3BF01C)
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>  <alpine.DEB.2.20.1808141515280.3371@hadrien>  (sfid-20180814_152007_774372_35ED45D6) <1536564277.3224.7.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Mon, 10 Sep 2018, Johannes Berg wrote:

> Julia,
>
> On Tue, 2018-08-14 at 15:19 +0200, Julia Lawall wrote:
>
> > Sorry, I'm not sure where 1.0.7 came from. [...]
>
> > I would indeed like to make a release now that the compiations issues are
> > resolved and things seem more stable.
>
> Were you able to clear this up?
>
> I see now that the website advertises the 1.0.7 release, however
>
>  * it's not tagged in git(hub) - all previous releases have a tag
>  * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
>    the website
>  * it *looks* like the actual 1.0.7 release was cut from a much newer
>    git commit, likely with the fix?

I'm still somewhat lost about it.  There is now a 1.0.7 source code on the
web site, which is the proper 1.0.7.  But the binaries on the web site are
still 1.0.6.  The previous thing that seemed to be 1.0.7 was an accidental
side effect of a test of the release script.  I think that my engineer was
waiting me to confirm something before putting a tag in github, but I'm
not sure what I was to confirm.  I will try to clear everything up.  But
the source code on the Coccinelle website is the official 1.0.7.

julia
--
To unsubscribe from this list: send the line "unsubscribe backports" in
