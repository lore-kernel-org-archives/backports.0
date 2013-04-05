Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58841 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab3DEPjF (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 11:39:05 -0400
Message-ID: <515EF012.6070301@hauke-m.de> (sfid-20130405_173909_275427_9016806E)
Date: Fri, 05 Apr 2013 17:38:58 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Thierry Escande <thierry.escande@linux.intel.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH v2 2/5] backports: Add NFC core and drivers
References: <1365175014-6028-2-git-send-email-thierry.escande@linux.intel.com>
In-Reply-To: <1365175014-6028-2-git-send-email-thierry.escande@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/05/2013 05:16 PM, Thierry Escande wrote:
> This grabs NFC core and drivers files from your linux tree.
> NFC build is disabled for now.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> ---
>  backport/Kconfig         |    2 ++
>  backport/Makefile.kernel |    2 ++
>  copy-list                |   16 ++++++++++++++++
>  dependencies             |    4 ++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/backport/Kconfig b/backport/Kconfig
> index d0ae17f..87e3869 100644
> --- a/backport/Kconfig
> +++ b/backport/Kconfig
> @@ -34,3 +34,5 @@ source drivers/net/ethernet/Kconfig
>  
>  source drivers/ssb/Kconfig
>  source drivers/bcma/Kconfig
> +
> +# source net/nfc/Kconfig

Instead of adding this here you should better add this Kconfig and
Makefile related changes in  "build: enable NFC build" and here just the
copy-list.

> diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
> index a599ad7..ac58225 100644
> --- a/backport/Makefile.kernel
> +++ b/backport/Makefile.kernel
> @@ -22,3 +22,5 @@ obj-$(CPTCFG_BT) += drivers/bluetooth/
>  obj-$(CPTCFG_SSB) += drivers/ssb/
>  obj-$(CPTCFG_BCMA) += drivers/bcma/
>  obj-$(CPTCFG_ETHERNET) += drivers/net/ethernet/
> +obj-$(CPTCFG_NFC) += net/nfc/
> +obj-$(CPTCFG_NFC) += drivers/nfc/
> diff --git a/copy-list b/copy-list
> index 4243619..82e21b1 100644
> --- a/copy-list
> +++ b/copy-list
> @@ -114,3 +114,19 @@ drivers/net/ethernet/broadcom/Kconfig
>  drivers/net/ethernet/broadcom/Makefile
>  drivers/net/ethernet/broadcom/b44.c
>  drivers/net/ethernet/broadcom/b44.h
> +
> +# NFC
> +net/nfc/
> +net/nfc/hci/
> +net/nfc/llcp/
> +net/nfc/nci/
> +include/net/nfc/
> +include/linux/socket.h
> +include/uapi/linux/nfc.h
> +include/uapi/linux/socket.h

include/uapi/linux/socket.h contains headers for kernel internal apis
which are not backported, do not copy the header into backports when you
do not add the implementation of the defined functions in backports,
which you probably do not want.

> +
> +# NFC drivers
> +drivers/nfc/
> +drivers/nfc/microread/
> +drivers/nfc/pn544/
> +include/linux/platform_data/pn544.h
> diff --git a/dependencies b/dependencies
> index 7c79449..e9aaa2e 100644
> --- a/dependencies
> +++ b/dependencies
> @@ -83,3 +83,7 @@ BRCMDBG 2.6.30
>  # backport it, but I can't test that and this is a
>  # lot easier right now.
>  BT_HIDP 2.6.33
> +
> +# NFC core needs PF_NFC defined in socket.h which was
> +# only introduced in kernel 3.1
> +NFC 3.1
> 

