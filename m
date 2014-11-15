Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36562 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397AbaKOT5w (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Nov 2014 14:57:52 -0500
Message-ID: <5467B03E.9000407@hauke-m.de> (sfid-20141115_205753_937561_39AA2A18)
Date: Sat, 15 Nov 2014 20:57:50 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Felix Fietkau <nbd@openwrt.org>, backports@vger.kernel.org
Subject: Re: [PATCH 1/3] backports: add GENMASK and GENMASK_ULL
References: <1415911780-52533-1-git-send-email-nbd@openwrt.org>
In-Reply-To: <1415911780-52533-1-git-send-email-nbd@openwrt.org>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/13/2014 09:49 PM, Felix Fietkau wrote:
> I intend to use this for a new driver
> 
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> ---
>  backport/backport-include/linux/bitops.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 backport/backport-include/linux/bitops.h
> 
> diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
> new file mode 100644
> index 0000000..d8aec05
> --- /dev/null
> +++ b/backport/backport-include/linux/bitops.h
> @@ -0,0 +1,19 @@
> +#ifndef __BACKPORT_BITOPS_H
> +#define __BACKPORT_BITOPS_H
> +#include_next <linux/bitops.h>
> +#include <linux/version.h>
> +#include <generated/utsrelease.h>

These two includes are not needed.

> +
> +#ifndef GENMASK
> +
> +/*
> + * Create a contiguous bitmask starting at bit position @l and ending at
> + * position @h. For example
> + * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> + */
> +#define GENMASK(h, l)          (((U32_C(1) << ((h) - (l) + 1)) - 1) << (l))
> +#define GENMASK_ULL(h, l)      (((U64_C(1) << ((h) - (l) + 1)) - 1) << (l))

You should use tabs here and not spaces.

> +
> +#endif
> +
> +#endif /* __BACKPORT_BITOPS_H */
> 

