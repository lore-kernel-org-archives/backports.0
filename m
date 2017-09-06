Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54286 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932737AbdIFPBp (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 11:01:45 -0400
Message-ID: <1504710103.23905.12.camel@sipsolutions.net> (sfid-20170906_170218_148105_8F1FAC39)
Subject: Re: [PATCH 08/21] header: backport devm_acpi_dev_add_driver_gpios()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Wed, 06 Sep 2017 17:01:43 +0200
In-Reply-To: <20170821222817.17376-9-hauke@hauke-m.de> (sfid-20170822_002845_485339_DE72ECAB)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-9-hauke@hauke-m.de>
         (sfid-20170822_002845_485339_DE72ECAB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-08-22 at 00:28 +0200, Hauke Mehrtens wrote:
> This is used by some NFC drivers to get information from the ACPI.
> This was added in kernel 4.13, but backporting it to older kernel
> versions than 3.19 is hard because such old kernel versions do not
> even
> have struct acpi_gpio_mapping. This only adds the empty version of
> this
> function as this normally needed some extra support in the generic
> ACPI
> code and I do not care about this functionality.


> +#if LINUX_VERSION_IN_RANGE(3,19,0, 4,13,0)

This I don't understand - you said it's hard to do for <3.19, and then
make a simple no-op for all, but don't do it for <3.19 at all?

Why not just LINUX_VERION_LESS(4,13,0)?

> +#define devm_acpi_dev_add_driver_gpios
> LINUX_BACKPORT(devm_acpi_dev_add_driver_gpios)
> +static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
> +			      const struct acpi_gpio_mapping *gpios)
> +{
> +	return -ENXIO;
> +}
> +#endif /* LINUX_VERSION_IN_RANGE(4,19,0, 4,13,0) */

Also, typo here.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
