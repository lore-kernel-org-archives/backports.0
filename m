Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46429 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756054AbbBGTWM (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Feb 2015 14:22:12 -0500
Message-ID: <54D665E1.5070507@hauke-m.de> (sfid-20150207_202214_827325_D5A83970)
Date: Sat, 07 Feb 2015 20:22:09 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: add IFF_TX_SKB_SHARING
References: <1422638090-20059-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1422638090-20059-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/30/2015 06:14 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This was introduced on kernel version 3.1, so a kernel (3.0) without
> it is still just within the support window. Define this constant if
> it isn't defined.

IFF_TX_SKB_SHARING was already added in long time ago and this patches
doe snot apply on top of current backports.

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/if.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 backport/backport-include/linux/if.h
> 
> diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
> new file mode 100644
> index 000000000000..d471340490ca
> --- /dev/null
> +++ b/backport/backport-include/linux/if.h
> @@ -0,0 +1,9 @@
> +#ifndef __BACKPORT_IF_H
> +#define __BACKPORT_IF_H
> +#include_next <linux/if.h>
> +
> +#ifndef IFF_TX_SKB_SHARING
> +#define IFF_TX_SKB_SHARING 0
> +#endif
> +
> +#endif /* __BACKPORT_IF_H */
> 

