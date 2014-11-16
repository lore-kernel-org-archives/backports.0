Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41363 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbaKPUIM (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:08:12 -0500
Message-ID: <1416168488.3624.0.camel@sipsolutions.net> (sfid-20141116_210814_054355_7B16D738)
Subject: Re: [PATCH] backport: genl: add __genl_const for new hwsim mcast
 group
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Sun, 16 Nov 2014 21:08:08 +0100
In-Reply-To: <5467AFF9.5060809@hauke-m.de>
References: <1415271730-19194-1-git-send-email-johannes@sipsolutions.net>
	 <5467AFF9.5060809@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2014-11-15 at 20:56 +0100, Hauke Mehrtens wrote:

> > +--- a/drivers/net/wireless/mac80211_hwsim.c
> > ++++ b/drivers/net/wireless/mac80211_hwsim.c
> 
> The last two lines are wrong, now we have to of these in the patch.

Sorry, I guess patch was happy with it nonetheless, probably patching
the file twice...

Thanks for fixing it up.

johannes

