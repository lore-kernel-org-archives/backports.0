Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:57977 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbbEYVw4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 May 2015 17:52:56 -0400
Message-ID: <556399B7.2040607@hauke-m.de> (sfid-20150525_235258_464845_1F86EF4C)
Date: Mon, 25 May 2015 23:52:55 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
In-Reply-To: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/19/2015 03:42 PM, Emmanuel Grumbach wrote:
> Canonical backported:
> 
> Author: Or Gerlitz <ogerlitz@mellanox.com>
> Date:   Mon Jan 20 13:59:19 2014 +0200
> 
>     net: Add GRO support for UDP encapsulating protocols
> 
> This is commit 2da204a8f67fbe25816cbce8cc8551f03d5b951a in their
> tree.
> Cope with that.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
> Touch compiled only. And I don't really know how the UTS thing goes :)
> ---
>  backport/backport-include/linux/netdevice.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
> index bb3fefb..61ac95c 100644
> --- a/backport/backport-include/linux/netdevice.h
> +++ b/backport/backport-include/linux/netdevice.h
> @@ -81,6 +81,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
>  	dev_kfree_skb_any(skb);
>  }
>  
> +#if (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI < 24)
>  struct pcpu_sw_netstats {
>  	u64     rx_packets;
>  	u64     rx_bytes;
> @@ -88,6 +89,7 @@ struct pcpu_sw_netstats {
>  	u64     tx_bytes;
>  	struct u64_stats_sync   syncp;
>  };
> +#endif
>  
>  #define netdev_tstats(dev)	((struct pcpu_sw_netstats *)dev->ml_priv)
>  #define netdev_assign_tstats(dev, e)	dev->ml_priv = (e);
> 


Thank you for the patch, it was applied and pushed.

I changed it into this:
+#if (LINUX_VERSION_CODE != KERNEL_VERSION(3,13,11) ||
UTS_UBUNTU_RELEASE_ABI < 24)
...
#endif

Hauke
