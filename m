Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37715 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGXEC (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 19:04:02 -0400
Message-ID: <5202D1F3.10404@hauke-m.de> (sfid-20130808_010404_868311_C3A47CEF)
Date: Thu, 08 Aug 2013 01:02:11 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH 1/9] backports: fix build errors for old kernel versions
 without PCI support
References: <cover.1375442885.git.patrick.ziegler@fh-kl.de> <51FB981B.6010502@fh-kl.de>
In-Reply-To: <51FB981B.6010502@fh-kl.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/02/2013 01:29 PM, Patrick Ziegler wrote:
> Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
> ---
>  backport/compat/compat-2.6.25.c | 4 ++++
>  backport/compat/compat-2.6.28.c | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/backport/compat/compat-2.6.25.c b/backport/compat/compat-2.6.25.c
> index b3597ea..169a555 100644
> --- a/backport/compat/compat-2.6.25.c
> +++ b/backport/compat/compat-2.6.25.c
> @@ -212,9 +212,13 @@ EXPORT_SYMBOL_GPL(sg_alloc_table);
>   */
>  int pci_enable_device_mem(struct pci_dev *dev)
>  {
> +#ifdef CONFIG_PCI
>  	int bars = pci_select_bars(dev, IORESOURCE_MEM);
>  
>  	return pci_enable_device_bars(dev, bars);
> +#else
> +	return 0;
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(pci_enable_device_mem);
>  

I liked the older patch more where you removed the pci functions when
pci was not configured.

> diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
> index e47626b..2ff6b1e 100644
> --- a/backport/compat/compat-2.6.28.c
> +++ b/backport/compat/compat-2.6.28.c
> @@ -12,6 +12,7 @@
>  #include <linux/usb.h>
>  #include <linux/tty.h>
>  #include <linux/skbuff.h>
> +#include <linux/pci.h>
>  #include <asm/poll.h>
>  
>  /* 2.6.28 compat code goes here */
> 

