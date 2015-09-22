Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52724 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933703AbbIVVXb (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 22 Sep 2015 17:23:31 -0400
Subject: Re: [PATCH 01/10] headers: add linux/bcm47xx_nvram.h
To: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	arend@broadcom.com
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
 <1442873243-15490-2-git-send-email-hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5601C6D1.7080305@hauke-m.de> (sfid-20150922_232333_717771_5BD6EA62)
Date: Tue, 22 Sep 2015 23:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <1442873243-15490-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/22/2015 12:07 AM, Hauke Mehrtens wrote:
> This is used by the brcmfmac driver since mainline commit 4e70f214.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  backport/backport-include/linux/bcm47xx_nvram.h | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 backport/backport-include/linux/bcm47xx_nvram.h
> 
> diff --git a/backport/backport-include/linux/bcm47xx_nvram.h b/backport/backport-include/linux/bcm47xx_nvram.h
> new file mode 100644
> index 0000000..0e50fcf
> --- /dev/null
> +++ b/backport/backport-include/linux/bcm47xx_nvram.h
> @@ -0,0 +1,27 @@
> +#ifndef __BACKPORTS_BCM47XX_NVRAM_H
> +#define __BACKPORTS_BCM47XX_NVRAM_H
> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
> +#include_next <linux/bcm47xx_nvram.h>
> +#else
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#endif
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
> +
> +#ifndef CONFIG_BCM47XX_NVRAM

I removed this ifndef so it will also compile on bcm47 devices.
OpenWrt will take care that it will also work with older kernel versions
there.

> +static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
> +{
> +	return NULL;
> +}
> +
> +static inline void bcm47xx_nvram_release_contents(char *nvram)
> +{
> +}
> +#endif
> +
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
> +
> +#endif /* __BACKPORTS_BCM47XX_NVRAM_H */
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
