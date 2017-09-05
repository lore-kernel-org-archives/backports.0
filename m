Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60846 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbdIEJAU (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 5 Sep 2017 05:00:20 -0400
Message-ID: <1504602018.12380.3.camel@sipsolutions.net> (sfid-20170905_110022_670993_0F1633D4)
Subject: Re: [PATCH 00/21] backports: multiple changes for kernel 3.13-rc6
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Tue, 05 Sep 2017 11:00:18 +0200
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de> (sfid-20170822_002853_183210_AA20A23A)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         (sfid-20170822_002853_183210_AA20A23A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Hauke,

> This was build tested with kernel 3.18, 4.4 and 4.9. and runtime
> tested with iwlwifi on kernel 4.9.

Cool.

> Are you planing to to releases in a tar?

Not personally, no. I barely have time to do any maintenance here to
start with, and still haven't set up any infrastructure to allow others
to really help out significantly.

> Which kernel versions are currently support by backports?

I think we didn't really change anything, so should be 3.0+

> patches/0079-netdev-destructor.cocci takes very long to apply, about
> 3 times longer all others together.

I doubt we can do anything about that.

> Should we remove ssb and bcma from backports and use the in kernel 
> versions instead? I do not expect so many changes any more affecting
> the wifi drivers.

I have no opinion either way.

> Is the compat wireless build server still being used?

It's still *there*, but I haven't really used it in a long time. I was
planning to set up some kind of auto-builder but haven't gotten around
to it.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
