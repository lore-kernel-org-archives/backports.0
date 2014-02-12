Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:54427 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaBLLKQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 12 Feb 2014 06:10:16 -0500
Message-ID: <1392203411.4146.15.camel@jlt4.sipsolutions.net> (sfid-20140212_121018_628759_9023F267)
Subject: Re: [PATCH] backports: backport ACPI_HANDLE(dev)
From: Johannes Berg <johannes@sipsolutions.net>
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: backports@vger.kernel.org, Ido Yariv <ido@wizery.com>,
	Ido Yariv <idox.yariv@intel.com>
Date: Wed, 12 Feb 2014 12:10:11 +0100
In-Reply-To: <1392100808-3075-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140211_074217_013735_C640FAA3)
References: <1392100808-3075-1-git-send-email-emmanuel.grumbach@intel.com>
	 (sfid-20140211_074217_013735_C640FAA3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hmm, come to think of it...

On Tue, 2014-02-11 at 08:40 +0200, Emmanuel Grumbach wrote:

> +++ b/backport/backport-include/linux/acpi.h
> @@ -0,0 +1,40 @@
> +#ifndef __BACKPORT_LINUX_ACPI_H
> +#define __BACKPORT_LINUX_ACPI_H
> +#include_next <linux/acpi.h>
> +#include_next <linux/device.h>

That include_next is probably wrong, if you really need linux/device.h
you shouldn't use #include_next but a regular #include.

johannes

