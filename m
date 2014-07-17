Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:49651 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbaGQUmq (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 17 Jul 2014 16:42:46 -0400
Message-ID: <53C83544.7030306@hauke-m.de> (sfid-20140717_224248_390528_53DDCDE7)
Date: Thu, 17 Jul 2014 22:42:44 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: Re: [PATCH] backports: include gpio consumer.h
References: <1404999110-13791-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1404999110-13791-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/10/2014 03:31 PM, Stefan Assmann wrote:
> While doing a make allmodconfig I noticed the following:
>   CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:31:33: fatal error: linux/gpio/consumer.h: No such file or directory
> 
> Including the header fixes the error.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  copy-list | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/copy-list b/copy-list
> index 7ad8972..b52e9f2 100644
> --- a/copy-list
> +++ b/copy-list
> @@ -107,6 +107,10 @@ drivers/net/ethernet/intel/Kconfig
>  drivers/net/ethernet/intel/Makefile
>  drivers/net/ethernet/intel/igb/
>  
> +# gpio
> +include/linux/gpio/
> +include/linux/gpio/consumer.h
> +
>  # wwan drivers
>  include/uapi/linux/usb/cdc.h
>  include/uapi/linux/usb/cdc-wdm.h
> 
Is this correct? backports does not provide the implementation of the
functions in include/linux/gpio/consumer.h and it will result in hard to
debug problems with some function signature is different in our version
of consumer.h and the version in the kernel.

I am against backporting this and would add an empty version of this header.

Hauke
