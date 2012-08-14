Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61155 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757307Ab2HNTEe (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 14 Aug 2012 15:04:34 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ4Xkj015384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:04:34 -0400
Date: Tue, 14 Aug 2012 15:03:43 -0400
From: Andy Gospodarek <gospo@redhat.com>
To: Andy Gospodarek <gospo@redhat.com>
Cc: backports@vger.kernel.org
Subject: Re: [PATCH] compat-wireless: only compile optional sdio code on
 2.6.37 and later
Message-ID: <20120814190343.GC2797@quad.redhat.com>
References: <1344970347-12440-1-git-send-email-gospo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344970347-12440-1-git-send-email-gospo@redhat.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

[Subject fixed]

On Tue, Aug 14, 2012 at 02:52:27PM -0400, Andy Gospodarek wrote:
> The pm_runtime routines in wlcore/sdio.c are not included in compat and
> the best alternative is to build them only on kernels 2.6.37 and later.
> 
> Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
> 
> ---
>  config.mk |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/config.mk b/config.mk
> index 93f0738..165a6ad 100644
> --- a/config.mk
> +++ b/config.mk
> @@ -588,7 +588,9 @@ ifdef CONFIG_WL12XX_PLATFORM_DATA
>  ifndef CONFIG_COMPAT_KERNEL_2_6_37
>  export CONFIG_COMPAT_WL1251_SDIO=m
>  endif #CONFIG_COMPAT_KERNEL_2_6_37
> +ifndef CONFIG_COMPAT_KERNEL_2_6_38
>  export CONFIG_WLCORE_SDIO=m
> +endif #CONFIG_COMPAT_KERNEL_2_6_38
>  endif #CONFIG_WL12XX_PLATFORM_DATA
>  endif #CONFIG_CRC7
>  
> -- 
> 1.7.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
