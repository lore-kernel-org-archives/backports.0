Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55558 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933640AbaGWW1X (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:27:23 -0400
Message-ID: <53D036C9.7080508@hauke-m.de> (sfid-20140724_002724_962808_CC478F1A)
Date: Thu, 24 Jul 2014 00:27:21 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH] backports: bump minimum kernel version for ADV7604 to
 3.13
References: <1406104682-4529-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1406104682-4529-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/23/2014 10:38 AM, Stefan Assmann wrote:
> While doing a make allmodconfig I noticed the following:
>   CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:31:33: fatal error: linux/gpio/consumer.h: No such file or directory
> 
> linux/gpio/consumer.h cannot be backported currently, as functions rely
> on in-kernel functionality (GPIO_DEVRES). Bumping the minimum required
> kernel version for ADV7604 to 3.13 where the header got introduced.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  dependencies | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dependencies b/dependencies
> index c38098c..119d5ca 100644
> --- a/dependencies
> +++ b/dependencies
> @@ -101,7 +101,7 @@ VIDEO_RENESAS_VSP1 3.4
>  VIDEO_MEM2MEM_DEINTERLACE 3.3
>  MEDIA_TUNER_E4000 3.4
>  DVB_USB_RTL28XXU 3.4
> -VIDEO_ADV7604 3.3
> +VIDEO_ADV7604 3.13
>  
>  BCMA_DRIVER_MIPS 3.3
>  SSB_DRIVER_MIPS 3.3
> 
Thank you for the patch, it was applied and is included in
backports-20140710

Hauke
