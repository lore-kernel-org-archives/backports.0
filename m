Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:47174 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752313AbdIFV6o (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 17:58:44 -0400
Subject: Re: [PATCH 08/21] header: backport devm_acpi_dev_add_driver_gpios()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <20170821222817.17376-9-hauke@hauke-m.de>
 <1504710103.23905.12.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <c5f48794-8d4c-b4e2-bfac-7d5473490756@hauke-m.de> (sfid-20170906_235845_889202_8C3430A4)
Date: Wed, 6 Sep 2017 23:58:38 +0200
MIME-Version: 1.0
In-Reply-To: <1504710103.23905.12.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/06/2017 05:01 PM, Johannes Berg wrote:
> On Tue, 2017-08-22 at 00:28 +0200, Hauke Mehrtens wrote:
>> This is used by some NFC drivers to get information from the ACPI.
>> This was added in kernel 4.13, but backporting it to older kernel
>> versions than 3.19 is hard because such old kernel versions do not
>> even
>> have struct acpi_gpio_mapping. This only adds the empty version of
>> this
>> function as this normally needed some extra support in the generic
>> ACPI
>> code and I do not care about this functionality.
> 
> 
>> +#if LINUX_VERSION_IN_RANGE(3,19,0, 4,13,0)
> 
> This I don't understand - you said it's hard to do for <3.19, and then
> make a simple no-op for all, but don't do it for <3.19 at all?
> 
> Why not just LINUX_VERION_LESS(4,13,0)?

struct acpi_gpio_mapping was added to kernel 3.19. We could add here a
dummy struct acpi_gpio_mapping, but the drivers anyway need more
adjustments to compile properly.

>> +#define devm_acpi_dev_add_driver_gpios
>> LINUX_BACKPORT(devm_acpi_dev_add_driver_gpios)
>> +static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
>> +			      const struct acpi_gpio_mapping *gpios)
>> +{
>> +	return -ENXIO;
>> +}
>> +#endif /* LINUX_VERSION_IN_RANGE(4,19,0, 4,13,0) */

This should be
+#endif /* LINUX_VERSION_IN_RANGE(3,19,0, 4,13,0) */

> 
> Also, typo here.
> 
> johannes
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
