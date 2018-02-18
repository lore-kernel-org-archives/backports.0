Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:23514 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbeBRQKf (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 18 Feb 2018 11:10:35 -0500
Subject: Re: [PATCH 10/10] backport: implement alloc_percpu_gfp() for < 3.18.
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
References: <20180218132459.11011-1-luca@coelho.fi>
 <20180218132459.11011-11-luca@coelho.fi>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4eb11ec9-3d1e-91ee-6585-7c8221454faf@hauke-m.de> (sfid-20180218_171037_235088_D22D7EF7)
Date: Sun, 18 Feb 2018 17:10:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180218132459.11011-11-luca@coelho.fi>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/18/2018 02:24 PM, Luca Coelho wrote:
> From: Sara Sharon <sara.sharon@intel.com>
> 
> mac80211 now uses the alloc_percpu_gfp() function, which doesn't exist
> in kernels older than 3.18.  Backport it accordingly.
> 
> Signed-off-by: Sara Sharon <sara.sharon@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  backport-include/linux/percpu.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 backport-include/linux/percpu.h
> 
> diff --git a/backport-include/linux/percpu.h b/backport-include/linux/percpu.h
> new file mode 100644
> index 000000000000..10be03cba795
> --- /dev/null
> +++ b/backport-include/linux/percpu.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (C) 2018 Intel Corporation
> + */
> +#ifndef __BACKPORT_PERCPU_H
> +#define __BACKPORT_PERCPU_H
> +#include_next <linux/percpu.h>
> +
> +#if LINUX_VERSION_IS_LESS(3,18,0)
> +static inline void __percpu *__alloc_gfp_warn(void)
> +{
> +	WARN(1, "Cannot backport alloc_percpu_gfp");
> +	return NULL;

Is this only called with GFP_KERNEL for now or why is it ok to only show
an error message here?

> +}
> +
> +#define alloc_percpu_gfp(type, gfp) \
> +	({ (gfp == GFP_KERNEL) ? alloc_percpu(type) : __alloc_gfp_warn(); })
> +#endif /* LINUX_VERSION_IS_LESS(3,18,0) */
> +
> +#endif /* __BACKPORT_PERCPU_H */
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
