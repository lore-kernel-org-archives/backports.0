Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43028 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753661AbdCaHaT (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 31 Mar 2017 03:30:19 -0400
Message-ID: <1490945417.6288.1.camel@sipsolutions.net> (sfid-20170331_093020_525068_DCA17ACA)
Subject: Re: [PATCH] backports: provide backport for setup_deferrable_timer()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 31 Mar 2017 09:30:17 +0200
In-Reply-To: <1489140070-29878-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170310_110147_921141_BC86D9EB)
References: <1489140070-29878-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170310_110147_921141_BC86D9EB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-03-10 at 10:01 +0000, Arend van Spriel wrote:
> Since commit f8f118ceaa56 ("mac80211: Use setup_timer instead of
> init_timer") mac80211 needs setup_deferrable_timer() which is not
> available in older kernels. Provide a backport in linux/timer.h.
> Really need two flavors of backport to support up to 3.0 kernel.
> 
Applied.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
