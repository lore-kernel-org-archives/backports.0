Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57947 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaBMHpA (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Feb 2014 02:45:00 -0500
Message-ID: <1392277496.4150.1.camel@jlt4.sipsolutions.net> (sfid-20140213_084502_067974_005B95E9)
Subject: Re: [PATCH] backports: backport ACPI_HANDLE(dev)
From: Johannes Berg <johannes@sipsolutions.net>
To: Ido Yariv <ido@wizery.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	backports@vger.kernel.org, Ido Yariv <idox.yariv@intel.com>
Date: Thu, 13 Feb 2014 08:44:56 +0100
In-Reply-To: <20140212234450.GB25743@WorkStation.amr.corp.intel.com> (sfid-20140213_004520_016197_E022346B)
References: <1392100808-3075-1-git-send-email-emmanuel.grumbach@intel.com>
	 <1392203411.4146.15.camel@jlt4.sipsolutions.net>
	 <20140212234450.GB25743@WorkStation.amr.corp.intel.com>
	 (sfid-20140213_004520_016197_E022346B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-02-12 at 18:44 -0500, Ido Yariv wrote:

> > > +#include_next <linux/device.h>
> > 
> > That include_next is probably wrong, if you really need linux/device.h
> > you shouldn't use #include_next but a regular #include.
> 
> My intention was to load the kernel's device.h and not backport's. The
> reason was that some definitions which are now part of acpi.h were
> defined by device.h in the past.
> 
> That being said, backport's device.h includes the kernel's version, so
> this can be modified to a regular #include and work just as well.

Right. I just think it seems odd in terms of backport header style, and
occasionally some backport header depends on some other backported
thing, so a plain #include is the right thing at least in those cases.
Not to mention that #include_next is a gcc-specific hack :)

johannes

