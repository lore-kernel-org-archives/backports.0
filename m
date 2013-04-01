Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48569 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756876Ab3DAVSu (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 1 Apr 2013 17:18:50 -0400
Message-ID: <5159F9AA.8060508@hauke-m.de> (sfid-20130401_231854_012420_22FCF67A)
Date: Mon, 01 Apr 2013 23:18:34 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 2/8] compat-drivers: add config option CONFIG_WILINK_PLATFORM_DATA
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de> <1364497938-10646-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/28/2013 08:12 PM, Hauke Mehrtens wrote:
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  config.mk |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/config.mk b/config.mk
> index b2e3d2d..8377278 100644
> --- a/config.mk
> +++ b/config.mk
> @@ -608,14 +608,12 @@ export CONFIG_SSB_SDIOHOST=y
>  export CONFIG_B43_SDIO=y
>  
>  ifdef CONFIG_CRC7
> -ifdef CONFIG_WL12XX_PLATFORM_DATA
>  ifndef CONFIG_COMPAT_KERNEL_2_6_37
>  export CONFIG_COMPAT_WL1251_SDIO=m
>  endif #CONFIG_COMPAT_KERNEL_2_6_37
>  ifndef CONFIG_COMPAT_KERNEL_2_6_38
>  export CONFIG_WLCORE_SDIO=m
>  endif #CONFIG_COMPAT_KERNEL_2_6_38
> -endif #CONFIG_WL12XX_PLATFORM_DATA
>  endif #CONFIG_CRC7
>  
>  export CONFIG_MWIFIEX_SDIO=m
> @@ -677,6 +675,7 @@ endif #CONFIG_COMPAT_KERNEL_2_6_29
>  ifndef CONFIG_COMPAT_KERNEL_2_6_30
>  
>  export CONFIG_WL_TI=y
> +# export CONFIG_WILINK_PLATFORM_DATA=y
>  export CONFIG_WLCORE=m
>  
>  ifdef CONFIG_CRC7
> 

Hi Luis,

Is there any reason you did not apply this patch?

Hauke
