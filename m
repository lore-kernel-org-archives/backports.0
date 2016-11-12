Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:42652 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966699AbcKLVH3 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 12 Nov 2016 16:07:29 -0500
Message-ID: <1478984842.4226.1.camel@sipsolutions.net> (sfid-20161112_220731_357735_75E66460)
Subject: Re: [PATCH 3/3] backports: empty define for __ro_after_init
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Sat, 12 Nov 2016 22:07:22 +0100
In-Reply-To: <1478981923-12298-3-git-send-email-arend.vanspriel@broadcom.com> (sfid-20161112_212539_146779_9220B565)
References: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com>
         <1478981923-12298-3-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20161112_212539_146779_9220B565)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2016-11-12 at 20:18 +0000, Arend van Spriel wrote:
> nl80211 now uses section qualifier __ro_after_init. However, this
> is not available in kernels before v4.6. Neither is the section
> itself hence adding an empty define in backports.

> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
> +#define __ro_after_init
> +#endif

Due to how __ro_after_init works, it *has* to be a macro originally, so
you could just ifndef on itself:

#ifndef __ro_after_init
#define __ro_after_init
#endif

and be slightly more compatible in case somebody ever backports it.

Don't think it really matters much, but why not.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
