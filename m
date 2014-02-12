Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:59600 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaBLXpS (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 12 Feb 2014 18:45:18 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so15365666qaq.29
        for <backports@vger.kernel.org>; Wed, 12 Feb 2014 15:45:18 -0800 (PST)
Date: Wed, 12 Feb 2014 18:44:50 -0500
From: Ido Yariv <ido@wizery.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	backports@vger.kernel.org, Ido Yariv <idox.yariv@intel.com>
Subject: Re: [PATCH] backports: backport ACPI_HANDLE(dev)
Message-ID: <20140212234450.GB25743@WorkStation.amr.corp.intel.com> (sfid-20140213_004521_230304_6306DA78)
References: <1392100808-3075-1-git-send-email-emmanuel.grumbach@intel.com>
 <1392203411.4146.15.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392203411.4146.15.camel@jlt4.sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

On Wed, Feb 12, 2014 at 12:10:11PM +0100, Johannes Berg wrote:
> Hmm, come to think of it...
> 
> On Tue, 2014-02-11 at 08:40 +0200, Emmanuel Grumbach wrote:
> 
> > +++ b/backport/backport-include/linux/acpi.h
> > @@ -0,0 +1,40 @@
> > +#ifndef __BACKPORT_LINUX_ACPI_H
> > +#define __BACKPORT_LINUX_ACPI_H
> > +#include_next <linux/acpi.h>
> > +#include_next <linux/device.h>
> 
> That include_next is probably wrong, if you really need linux/device.h
> you shouldn't use #include_next but a regular #include.

My intention was to load the kernel's device.h and not backport's. The
reason was that some definitions which are now part of acpi.h were
defined by device.h in the past.

That being said, backport's device.h includes the kernel's version, so
this can be modified to a regular #include and work just as well.

Cheers,
Ido.
