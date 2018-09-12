Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:1160 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbeILPSm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 12 Sep 2018 11:18:42 -0400
Date: Wed, 12 Sep 2018 12:14:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Luciano Coelho <luciano.coelho@intel.com>, cocci@systeme.lip6.fr,
        backports@vger.kernel.org
Subject: Re: [Cocci] New release after 1.0.7?
In-Reply-To: <1536564277.3224.7.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1809121214160.31876@hadrien> (sfid-20180912_121453_878702_F0296E31)
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

There is now a tag for the official release of 1.0.7 in github.

julia
--
To unsubscribe from this list: send the line "unsubscribe backports" in
