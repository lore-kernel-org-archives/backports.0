Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59358 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbcKNN13 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 14 Nov 2016 08:27:29 -0500
Message-ID: <1479130044.12007.3.camel@sipsolutions.net> (sfid-20161114_143109_177605_E3A72011)
Subject: Re: min/max mtu field in struct net_device
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 14 Nov 2016 14:27:24 +0100
In-Reply-To: <57925560-252e-a547-fe09-959362d9dce4@broadcom.com> (sfid-20161114_114608_120567_45CAF6A2)
References: <c4682854-87ce-5e28-d049-545f24d48cab@broadcom.com>
         <1479115859.7899.3.camel@sipsolutions.net>
         <57925560-252e-a547-fe09-959362d9dce4@broadcom.com>
         (sfid-20161114_114608_120567_45CAF6A2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> Me too. This is what I got so far, but the callback is generated
> twice
> for net/mac80211/iface.c for obvious reasons (data and monitor ops).
> These are my first baby steps with spatch so not sure how to solve
> it.

Oh, right, that's problematic - no easy way to link the two and know
which one is which ...

I guess we'll have to carry that as a manual patch. We should probably
also ifdef on the kernel version.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
