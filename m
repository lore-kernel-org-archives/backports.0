Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:57144 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbcKNJbH (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 14 Nov 2016 04:31:07 -0500
Message-ID: <1479115859.7899.3.camel@sipsolutions.net> (sfid-20161114_103115_079579_A2F63BC8)
Subject: Re: min/max mtu field in struct net_device
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 14 Nov 2016 10:30:59 +0100
In-Reply-To: <c4682854-87ce-5e28-d049-545f24d48cab@broadcom.com> (sfid-20161114_095807_156709_13DD77F5)
References: <c4682854-87ce-5e28-d049-545f24d48cab@broadcom.com>
         (sfid-20161114_095807_156709_13DD77F5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2016-11-14 at 09:49 +0100, Arend Van Spriel wrote:
> Just wondering. Does anyone have any ideas on how to backport the two
> patches below. The struct net_device now holds mtu range which
> network subsystem checks. For a number of drivers and mac80211 it
> means they no longer have .ndo_change_mtu callback. My guess is that
> we need patches in backport of some sort to tackle this.

Yeah, I kinda saw this coming. Since in almost all cases using the new
min/max the ndo_change_mtu was actually removed, perhaps we can come up
with a way to spatch it back in?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
