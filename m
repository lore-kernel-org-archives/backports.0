Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60736 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbdIHJZk (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 05:25:40 -0400
Message-ID: <1504862738.6177.18.camel@sipsolutions.net> (sfid-20170908_112541_179205_041F014E)
Subject: Re: [PATCH 08/21] header: backport devm_acpi_dev_add_driver_gpios()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Fri, 08 Sep 2017 11:25:38 +0200
In-Reply-To: <c5f48794-8d4c-b4e2-bfac-7d5473490756@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-9-hauke@hauke-m.de>
         <1504710103.23905.12.camel@sipsolutions.net>
         <c5f48794-8d4c-b4e2-bfac-7d5473490756@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-09-06 at 23:58 +0200, Hauke Mehrtens wrote:
> 
> > This I don't understand - you said it's hard to do for <3.19, and
> > then
> > make a simple no-op for all, but don't do it for <3.19 at all?
> > 
> > Why not just LINUX_VERION_LESS(4,13,0)?
> 
> struct acpi_gpio_mapping was added to kernel 3.19. We could add here
> a dummy struct acpi_gpio_mapping, but the drivers anyway need more
> adjustments to compile properly.

Ok.

> > > +#define devm_acpi_dev_add_driver_gpios
> > > LINUX_BACKPORT(devm_acpi_dev_add_driver_gpios)
> > > +static inline int devm_acpi_dev_add_driver_gpios(struct device
> > > *dev,
> > > +			      const struct acpi_gpio_mapping
> > > *gpios)
> > > +{
> > > +	return -ENXIO;
> > > +}
> > > +#endif /* LINUX_VERSION_IN_RANGE(4,19,0, 4,13,0) */
> 
> This should be
> +#endif /* LINUX_VERSION_IN_RANGE(3,19,0, 4,13,0) */

Right. I'll fix this and apply then.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
