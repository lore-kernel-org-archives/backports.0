Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53170 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006Ab3LFQPk (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 6 Dec 2013 11:15:40 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so843246wgh.11
        for <backports@vger.kernel.org>; Fri, 06 Dec 2013 08:15:39 -0800 (PST)
Date: Fri, 6 Dec 2013 17:15:31 +0100
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH v3] backports: add support for prandom_bytes
Message-ID: <20131206161531.GB8196@cerro.do-not-panic.com> (sfid-20131206_171542_576304_21B189D9)
References: <1386079852-8248-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386079852-8248-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Dec 03, 2013 at 03:10:52PM +0100, Johannes Berg wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> This was added in 3.8 and not used until now.
> Since it it being used by the wireless stack, backport it.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/random.h |  3 +++
>  backport/compat/compat-3.8.c             | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
> index 812ce7f..e915106 100644
> --- a/backport/backport-include/linux/random.h
> +++ b/backport/backport-include/linux/random.h
> @@ -8,6 +8,9 @@
>  #define prandom_seed(_seed)		srandom32(_seed)
>  #define prandom_u32()			random32()
>  #define prandom_u32_state(_state)	prandom32(_state)
> +/* backport 6582c665d6b882dad8329e05749fbcf119f1ab88 */
> +#define prandom_bytes LINUX_BACKPORT(prandom_bytes)
> +void prandom_bytes(void *buf, int bytes);
>  #endif
>  
>  #endif /* __BACKPORT_RANDOM_H */
> diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
> index d43d386..70d3375 100644
> --- a/backport/compat/compat-3.8.c
> +++ b/backport/compat/compat-3.8.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include "hid-ids.h"
>  #include <linux/netdevice.h>
> +#include <linux/random.h>
>  
>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
>  void netdev_set_default_ethtool_ops(struct net_device *dev,
> @@ -419,6 +420,37 @@ int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long
>  }
>  EXPORT_SYMBOL_GPL(vm_iomap_memory);
>  
> +/**
> + *	prandom_bytes - get the requested number of pseudo-random bytes
> + *	@buf: where to copy the pseudo-random bytes to
> + *	@bytes: the requested number of bytes
> + */
> +void prandom_bytes(void *buf, int bytes)
> +{
> +	unsigned char *p = buf;
> +	int i;
> +
> +	for (i = 0; i < round_down(bytes, sizeof(u32)); i += sizeof(u32)) {
> +		u32 random = random32();
> +		int j;
> +
> +		for (j = 0; j < sizeof(u32); j++) {
> +			p[i + j] = random;
> +			random >>= BITS_PER_BYTE;
> +		}
> +	}
> +
> +	if (i < bytes) {
> +		u32 random = random32();
> +
> +		for (; i < bytes; i++) {
> +			p[i] = random;
> +			random >>= BITS_PER_BYTE;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(prandom_bytes_state);

Where is prandom_bytes_state defined? Did you mean prandom_bytes ?
This breaks compilation right now.

  Luis
