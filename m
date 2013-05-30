Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:37985 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758467Ab3E3S65 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 May 2013 14:58:57 -0400
Message-ID: <1369940334.8421.4.camel@jlt4.sipsolutions.net> (sfid-20130530_205859_421039_66BD1D1D)
Subject: Re: Question about configuration for alx
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: backports@vger.kernel.org
Date: Thu, 30 May 2013 20:58:54 +0200
In-Reply-To: <51A797A6.5070804@lwfinger.net> (sfid-20130530_201722_981325_81CBAC11)
References: <51A797A6.5070804@lwfinger.net>
	 (sfid-20130530_201722_981325_81CBAC11)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-05-30 at 13:17 -0500, Larry Finger wrote:
> I am trying to help an openSUSE user that needs driver alx for his wired device. 
> I see that backports has the code, but it cannot be configured due to the 
> following statements in drivers/net/wireless/atheros/Kconfig:

I think you mean s/wireless/ethernet/, right?

> config ALX
>          depends on !BACKPORT_KERNEL_2_6_28
>          depends on n
>          tristate "Qualcomm Atheros L1F Gigabit Ethernet support"
>          depends on m
> 
> The "depends on n" is the culprit. Is this deliberate because the driver code is 
> not ready, or is this a bug?

This is an interesting side-effect of how the system works.

The ALX Kconfig is added by a patch
(patches/unified-drivers/network/0002-alx-make-kconfig/alx.patch) but
the *code* itself needs to be copied from an external tree when building
a backport tarball. To do this, the --extra-driver option in gentree.py
exists.

Are you using one of Luis's releases, or building an own backport
tarball?

If the former, Luis should probably include ALX since it's his driver.

For the latter, see also the copy-list.alx file in the backports tree.


Basically, the reason is that ALX isn't part of linux-next (yet), so
needs to be included during the backporting process from another source,
but the Kconfig is actually done in a patch that ships with backports,
which is admittedly a bit confusing.

johannes

