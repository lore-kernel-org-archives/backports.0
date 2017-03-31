Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43016 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753154AbdCaH3v (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 31 Mar 2017 03:29:51 -0400
Message-ID: <1490945388.6288.0.camel@sipsolutions.net> (sfid-20170331_092952_323089_961680CA)
Subject: Re: [PATCH 0/4] backports: fixes for wireless-testing
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 31 Mar 2017 09:29:48 +0200
In-Reply-To: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140611_729182_C316A114)
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170309_140611_729182_C316A114)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2017-03-09 at 12:57 +0000, Arend van Spriel wrote:
> This series fixes backport issues found backporting the wireless-
> testing
> tree that moved to 4.11-rc1.
> 
> Arend van Spriel (4):
>   patches: update crypto-ccm.patch for v4.11-rc1
>   backports: add backport for idr_remove
>   backports: introduce new definition for DECLARE_EWMA macro
>   backports: add dummy include/linux/sched/signal.h

Applied, except I replaced the average.h by just copying that file

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
