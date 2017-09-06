Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41328 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbdIFWNQ (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 18:13:16 -0400
Subject: Re: [PATCH] backport: add some new kv[mz]alloc function
To: AceLan Kao <acelan.kao@canonical.com>, mcgrof@kernel.org,
        backports@vger.kernel.org
References: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <060d0213-2a3a-9490-b121-39a55e773822@hauke-m.de> (sfid-20170907_001341_070070_298AE28C)
Date: Thu, 7 Sep 2017 00:05:55 +0200
MIME-Version: 1.0
In-Reply-To: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/21/2017 08:55 AM, AceLan Kao wrote:
> add some new kv[mz]alloc functions which introduced after v4.12
> by this commit
> 
> commit a7c3e901a46ff54c016d040847eda598a9e3e653
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Mon May 8 15:57:09 2017 -0700
> 
>     mm: introduce kv[mz]alloc helpers
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  backport/backport-include/linux/mm.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
> index 3234b37..8125310 100644
> --- a/backport/backport-include/linux/mm.h
> +++ b/backport/backport-include/linux/mm.h
> @@ -123,4 +123,20 @@ static inline bool page_is_pfmemalloc(struct page *page)
>  }
>  #endif /* < 4.2 */
>  
> +#if LINUX_VERSION_IS_LESS(4,12,0)
> +extern void *kvmalloc_node(size_t size, gfp_t flags, int node);

Is kvmalloc_node() implemented somewhere? It was added in kernel 4.12
and is not available in older mainline kernel versions.

> +static inline void *kvmalloc(size_t size, gfp_t flags)
> +{
> +	return kvmalloc_node(size, flags, NUMA_NO_NODE);
> +}
> +static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
> +{
> +	return kvmalloc_node(size, flags | __GFP_ZERO, node);
> +}
> +static inline void *kvzalloc(size_t size, gfp_t flags)
> +{
> +	return kvmalloc(size, flags | __GFP_ZERO);
> +}
> +#endif /* < 4.12.0 */
> +
>  #endif /* __BACKPORT_MM_H */
> 

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
