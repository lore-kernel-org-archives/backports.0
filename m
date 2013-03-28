Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44414 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab3C1WcT (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 18:32:19 -0400
Message-ID: <1364509929.10397.79.camel@jlt4.sipsolutions.net> (sfid-20130328_233223_816977_2B59FC60)
Subject: Re: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 28 Mar 2013 23:32:09 +0100
In-Reply-To: <CAB=NE6U=_C72wQLQbXdqN88tudZr7U9Quk_FVeYSgYwEgzeusQ@mail.gmail.com> (sfid-20130328_232511_312472_24B65844)
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
	 <CAB=NE6X9X0apA0tR-f2_f24W-sWXhUVky2OGEQhAO3=ta1Q2pA@mail.gmail.com>
	 <CAB=NE6U=_C72wQLQbXdqN88tudZr7U9Quk_FVeYSgYwEgzeusQ@mail.gmail.com>
	 (sfid-20130328_232511_312472_24B65844)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-03-28 at 15:24 -0700, Luis R. Rodriguez wrote:

> Another thing I should mention here about Kconfig.
> 
> 'make localmodconfig' is great and IMHO something which we should
> strive for as well for end users. The issue comes in when you have to
> build something for remote systems. For this I wrote a script a while
> ago to let us extract only the necessary components from the kernel,
> scp to target, and extract back our .config [0]. This is hacky but
> something to keep in mind.

Yes, that's another interesting thing to do. I myself tend to think it's
less important as even building all of compat shouldn't take all that
much time. OTOH, it's clearly a lot more than what you usually want.

The tricky part here is that for those users that have most reason to
use compat, those who need it for new driver modules, it won't work
because they can't already be loaded on the system.

Anyway I don't see why we couldn't just copy the streamline config perl
script, with the Kconfig tree we build it would probably work just fine.

johannes

