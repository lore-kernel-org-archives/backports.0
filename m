Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:15146 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbINIQ3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 14 Sep 2015 04:16:29 -0400
Message-ID: <55F68256.4090405@broadcom.com> (sfid-20150914_101632_628324_3FEA9A44)
Date: Mon, 14 Sep 2015 10:16:22 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, <backports@vger.kernel.org>
Subject: Re: [PATCH 06/10] patches: add additional include to brcmfmac
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de> <1442216922-3318-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1442216922-3318-7-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/14/2015 09:48 AM, Hauke Mehrtens wrote:
> brcmfmac uses atomic_or(), but does not include linux/atomic.h which
> causes problems on kernel 3.0

Hi Hauke,

Will you also submit the actual patch upstream?

Regards,
Arend

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   .../network/0013-fix-makefile-includes/brcmfmac.patch          | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>   create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
>
> diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
> new file mode 100644
> index 0000000..0e0a96c
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
> @@ -0,0 +1,10 @@
> +--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
> ++++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
> +@@ -15,6 +15,7 @@
> +  */
> +
> + #include <linux/types.h>
> ++#include <linux/atomic.h>
> + #include <linux/kernel.h>
> + #include <linux/kthread.h>
> + #include <linux/printk.h>
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
