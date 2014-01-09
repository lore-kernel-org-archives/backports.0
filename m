Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60065 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729AbaAIUzw (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 9 Jan 2014 15:55:52 -0500
Message-ID: <52CF0CCE.3080205@hauke-m.de> (sfid-20140109_215555_676526_694325C4)
Date: Thu, 09 Jan 2014 21:55:42 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH v3 01/11] backports: igb fixes for linux-3.12
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de> <1389177854-24292-2-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1389177854-24292-2-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/08/2014 11:44 AM, Stefan Assmann wrote:
> - refactor u64_stats_sync.h a bit
> - add u64_stats_init define
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  backport/backport-include/linux/u64_stats_sync.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
> index f15116c..ce6b778 100644
> --- a/backport/backport-include/linux/u64_stats_sync.h
> +++ b/backport/backport-include/linux/u64_stats_sync.h
> @@ -1,6 +1,17 @@
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
> +#ifndef __BACKPORT_LINUX_U64_STATS_SYNC_H
> +#define __BACKPORT_LINUX_U64_STATS_SYNC_H
> +
>  #include_next <linux/u64_stats_sync.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
> +#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
> +# define u64_stats_init(syncp)	seqcount_init(syncp.seq)
>  #else
> +# define u64_stats_init(syncp)	do { } while (0)
> +#endif
> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
>  #ifndef _LINUX_U64_STATS_SYNC_H
>  #define _LINUX_U64_STATS_SYNC_H

_LINUX_U64_STATS_SYNC_H could be removed now.

>  
> @@ -141,4 +152,5 @@ static inline bool u64_stats_fetch_retry_bh(const struct u64_stats_sync *syncp,
>  }
>  
>  #endif /* _LINUX_U64_STATS_SYNC_H */
> -#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
> +#endif /* __BACKPORT_LINUX_U64_STATS_SYNC_H */
> 

