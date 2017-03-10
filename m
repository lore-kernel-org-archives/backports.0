Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38336 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdCJGeh (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 10 Mar 2017 01:34:37 -0500
Message-ID: <1489127672.3038.0.camel@sipsolutions.net> (sfid-20170310_073438_948680_5A3529CB)
Subject: Re: [PATCH 1/4] patches: update crypto-ccm.patch for v4.11-rc1
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 10 Mar 2017 07:34:32 +0100
In-Reply-To: <1489064253-3652-2-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140610_645275_5055B3F1)
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
         <1489064253-3652-2-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170309_140610_645275_5055B3F1)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2017-03-09 at 12:57 +0000, Arend van Spriel wrote:
> Since v4.11-rc1 the patch file for crypto/ccm.c, which is
> incorporated
> in the compat module, no longer applies. Update the patch file to fix
> the issue.

I think I want to get rid of this ccm thing entirely, any objections?
As I remember, it doesn't actually work properly anyway.

I suspect that if we really can't do anything else, we'd have to
provide a backport for all of crypto/, but I don't want to go there and
would rather mandate that all the crypto things are enabled in the base
kernel.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
