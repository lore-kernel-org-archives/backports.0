Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55234 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560AbaEaNGA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 09:06:00 -0400
Message-ID: <5389D3AE.4000900@hauke-m.de> (sfid-20140531_150604_988211_24124379)
Date: Sat, 31 May 2014 15:05:50 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: provide net_ieee802154_lowpan only when needed
References: <1399293971-8037-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1399293971-8037-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/05/2014 02:46 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If 802.15.4 isn't configured, there's no need to provide the
> network namespace support for it, so don't.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/net/net_namespace.h | 5 ++++-
>  backport/compat/backport-3.15.c               | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
> index 3ea5d4662c27..ad0f03096361 100644
> --- a/backport/backport-include/net/net_namespace.h
> +++ b/backport/backport-include/net/net_namespace.h
> @@ -1,9 +1,11 @@
>  #ifndef _COMPAT_NET_NET_NAMESPACE_H
>  #define _COMPAT_NET_NET_NAMESPACE_H 1
>  
> +#include_next <net/net_namespace.h>
> +
> +#ifdef CPTCFG_IEEE802154_6LOWPAN

You should use this:

#if IS_ENABLED(CPTCFG_IEEE802154_6LOWPAN)

autoconf.h contains:
#define CPTCFG_IEEE802154_6LOWPAN_MODULE 1

>  #include <linux/version.h>
>  #include <net/netns/ieee802154_6lowpan.h>
> -#include_next <net/net_namespace.h>
>  
>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
> @@ -22,5 +24,6 @@ net_ieee802154_lowpan(struct net *net)
>  	return &net->ieee802154_lowpan;
>  }
>  #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
> +#endif /* CPTCFG_IEEE802154_6LOWPAN */
>  
>  #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
> diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
> index 545e0c297ea6..767722e8ac6d 100644
> --- a/backport/compat/backport-3.15.c
> +++ b/backport/compat/backport-3.15.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <net/net_namespace.h>
>  
> +#ifdef CPTCFG_IEEE802154_6LOWPAN
>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
>  /* the above kernel dependency is set to match the dependencies file */
>  struct netns_ieee802154_lowpan ieee802154_lowpan;
> @@ -25,6 +26,7 @@ struct netns_ieee802154_lowpan *net_ieee802154_lowpan(struct net *net)
>  }
>  EXPORT_SYMBOL_GPL(net_ieee802154_lowpan);
>  #endif
> +#endif /* CPTCFG_IEEE802154_6LOWPAN */
>  
>  /**
>   * devm_kstrdup - Allocate resource managed space and
> 

