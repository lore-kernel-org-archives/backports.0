Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:53273 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935774Ab3DHTeV (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:34:21 -0400
Received: by mail-lb0-f170.google.com with SMTP id x11so6130115lbi.29
        for <backports@vger.kernel.org>; Mon, 08 Apr 2013 12:34:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365416773-12836-5-git-send-email-thierry.escande@linux.intel.com>
References: <1365416773-12836-5-git-send-email-thierry.escande@linux.intel.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Apr 2013 12:33:59 -0700
Message-ID: <CAB=NE6XWEhPAHkMfhp5N3Vc-vk1VVMQ06Egm8Sfe=wwDraQRRw@mail.gmail.com> (sfid-20130408_213430_806496_41FB44BF)
Subject: Re: [PATCH v3 4/8] backport module_i2c_driver helper macro
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
<thierry.escande@linux.intel.com> wrote:
> Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> ---
>  backport/include/linux/compat-3.3.h |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/backport/include/linux/compat-3.3.h b/backport/include/linux/compat-3.3.h
> index 2af4a52..ce7e776 100644
> --- a/backport/include/linux/compat-3.3.h
> +++ b/backport/include/linux/compat-3.3.h
> @@ -371,6 +371,27 @@ module_exit(__driver##_exit);
>  #undef PCI_EXP_TYPE_RC_EC
>  #define  PCI_EXP_TYPE_RC_EC    0xa     /* Root Complex Event Collector */
>
> +
> +/* This backports:
> + *
> + * commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
> + * Author: Lars-Peter Clausen <lars@metafoo.de>
> + * Date:   Wed Nov 16 10:13:36 2011 +0100
> + *
> + *     I2C: Add helper macro for i2c_driver boilerplate
> + */
> +/**
> + * module_i2c_driver() - Helper macro for registering a I2C driver
> + * @__i2c_driver: i2c_driver struct
> + *
> + * Helper macro for I2C drivers which do not do anything special in module
> + * init/exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module_exit()
> + */

#define module_i2c_driver LINUX_BACKPORT(module_i2c_driver)

> +#define module_i2c_driver(__i2c_driver) \
> +       module_driver(__i2c_driver, i2c_add_driver, \
> +                       i2c_del_driver)
> +
>  #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) */

  Luis
