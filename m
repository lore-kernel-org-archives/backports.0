Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37145 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbaKPNO1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 08:14:27 -0500
Message-ID: <5468A330.70802@hauke-m.de> (sfid-20141116_141430_694335_0BBAABFB)
Date: Sun, 16 Nov 2014 14:14:24 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Felix Fietkau <nbd@openwrt.org>, backports@vger.kernel.org
Subject: Re: [PATCH 3/3] backports: backport devm_kmemdup
References: <1415911780-52533-1-git-send-email-nbd@openwrt.org> <1415911780-52533-3-git-send-email-nbd@openwrt.org>
In-Reply-To: <1415911780-52533-3-git-send-email-nbd@openwrt.org>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/13/2014 09:49 PM, Felix Fietkau wrote:
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> ---
>  backport/backport-include/linux/device.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
> index 41f06c3..429df37 100644
> --- a/backport/backport-include/linux/device.h
> +++ b/backport/backport-include/linux/device.h
> @@ -177,4 +177,20 @@ static inline void *devm_kmalloc_array(struct device *dev,
>  }
>  #endif
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)

devm_kmemdup() is not available in kernel 3.15, you should use
#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)

> +#define devm_kmemdup LINUX_BACKPORT(devm_kmemdup)
> +static inline void *devm_kmemdup(struct device *dev, const void *src,
> +				 size_t len, gfp_t gfp)
> +{
> +	void *p;
> +
> +	p = devm_kmalloc(dev, len, gfp);
> +	if (p)
> +		memcpy(p, src, len);
> +
> +	return p;
> +}
> +#endif
> +
> +
>  #endif /* __BACKPORT_DEVICE_H */
> 

