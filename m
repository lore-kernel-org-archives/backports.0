Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:44900 "EHLO
	sipsolutions.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855Ab3KTIUo (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 20 Nov 2013 03:20:44 -0500
Message-ID: <1384935617.14295.1.camel@jlt4.sipsolutions.net> (sfid-20131120_092046_403402_60DBC56F)
Subject: Re: [PATCH] backports: remove obsolete linux/bitops.h header
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Stefan Assmann <sassmann@kpanic.de>, mcgrof@kernel.org,
	backports@vger.kernel.org
Date: Wed, 20 Nov 2013 09:20:17 +0100
In-Reply-To: <528BEB63.3080600@hauke-m.de> (sfid-20131119_235133_050957_98574914)
References: <1384784803-16935-1-git-send-email-sassmann@kpanic.de>
	 <528BEB63.3080600@hauke-m.de> (sfid-20131119_235133_050957_98574914)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-11-19 at 23:51 +0100, Hauke Mehrtens wrote:
> On 11/18/2013 03:26 PM, Stefan Assmann wrote:
> > The header seems to be obsolete. Removing it and running devel/ckmake didn't
> > reveal any errors. Missing parts can always be re-added in the new
> > include_next fashion if necessary.
> > 
> > Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> 
> Some of these functions are needed, because they are not provided by old
> kernel versions.

Overall the idea seems right though - we should have something like

#ifndef __BACKPORT_BITOPS_H
#define __BACKPORT_BITOPS_H
#include_next <linux/bitops.h>

#ifndef for_each_set_bit
#define for_each_set_bit(...) \
	...
#endif

#if kernel_version < 2.6.38
static inline __s32 sign_extend32(...) { ... }
#endif

etc.

#endif /* __BACKPORT_BITOPS_H */

I think.

johannes

