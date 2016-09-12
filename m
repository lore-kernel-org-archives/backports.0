Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:57241 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752742AbcILJUs (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 12 Sep 2016 05:20:48 -0400
Message-ID: <1473672043.4201.14.camel@sipsolutions.net> (sfid-20160912_112050_083901_B911E91C)
Subject: Re: [PATCH] gentree: create Kconfig.local, use it to restrict compat
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Cc: Jouni Malinen <j@w1.fi>
Date: Mon, 12 Sep 2016 11:20:43 +0200
In-Reply-To: <4d5c9281-7f15-37ec-d0f7-099cc9a12f53@broadcom.com> (sfid-20160912_111757_179592_57A5489D)
References: <1472493101-6058-1-git-send-email-johannes@sipsolutions.net>
         <4d5c9281-7f15-37ec-d0f7-099cc9a12f53@broadcom.com>
         (sfid-20160912_111757_179592_57A5489D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> Excellent. Thanks for this. I have been spending some time on fixing
> that skcipher stuff (attached) although the stuff in my selective
> backport does not need it.
> 
:-)
Yep, precisely why I wanted this as well.

I suppose we should still ultimately fix that backport, but overall we
do want selective backports to be more insulated.

Or perhaps we should just give up on backporting lib80211_* and ipw
drivers. They haven't changed in years anyway, so it's unlikely that
anyone would want use a backport for them, I guess.

Except if you look at a distro-level backport, since they do integrate
cfg80211 and thus can't be used in conjunction with a backport thereof.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
