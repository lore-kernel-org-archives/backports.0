Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38486 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935467Ab3DHTaM (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Apr 2013 15:30:12 -0400
Message-ID: <51631ABB.4000102@hauke-m.de> (sfid-20130408_213022_268085_19360B4E)
Date: Mon, 08 Apr 2013 21:30:03 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Thierry Escande <thierry.escande@linux.intel.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH v3 7/8] build: enable NFC build
References: <1365416773-12836-8-git-send-email-thierry.escande@linux.intel.com>
In-Reply-To: <1365416773-12836-8-git-send-email-thierry.escande@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/08/2013 12:26 PM, Thierry Escande wrote:
> Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> ---
>  backport/Kconfig         |    2 ++
>  backport/Makefile.kernel |    2 ++
>  dependencies             |    4 ++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/backport/Kconfig b/backport/Kconfig
> index 8a38d61..6ab0991 100644
> --- a/backport/Kconfig
> +++ b/backport/Kconfig
> @@ -36,3 +36,5 @@ source drivers/ssb/Kconfig
>  source drivers/bcma/Kconfig
>  
>  source drivers/gpu/drm/Kconfig
> +
> +source net/nfc/Kconfig

Isn't this missing here?
source drivers/nfc/Kconfig

> diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
> index 8aa3e4a..4d00bda 100644
> --- a/backport/Makefile.kernel
> +++ b/backport/Makefile.kernel
> @@ -23,3 +23,5 @@ obj-$(CPTCFG_SSB) += drivers/ssb/
>  obj-$(CPTCFG_BCMA) += drivers/bcma/
>  obj-$(CPTCFG_ETHERNET) += drivers/net/ethernet/
>  obj-$(CPTCFG_DRM) += drivers/gpu/drm/
> +obj-$(CPTCFG_NFC) += net/nfc/
> +obj-$(CPTCFG_NFC) += drivers/nfc/
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

