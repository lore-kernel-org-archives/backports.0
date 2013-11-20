Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:44964 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3KTIgh (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 20 Nov 2013 03:36:37 -0500
Message-ID: <1384936585.14295.2.camel@jlt4.sipsolutions.net> (sfid-20131120_093639_368795_ACD04545)
Subject: Re: [PATCH] backports: remove obsolete linux/bitops.h header
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@kernel.org,
	backports@vger.kernel.org
Date: Wed, 20 Nov 2013 09:36:25 +0100
In-Reply-To: <528C7302.5030501@kpanic.de>
References: <1384784803-16935-1-git-send-email-sassmann@kpanic.de>
	 <528BEB63.3080600@hauke-m.de> <528C7302.5030501@kpanic.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-11-20 at 09:29 +0100, Stefan Assmann wrote:
> On 19.11.2013 23:51, Hauke Mehrtens wrote:
> > On 11/18/2013 03:26 PM, Stefan Assmann wrote:
> >> The header seems to be obsolete. Removing it and running devel/ckmake didn't
> >> reveal any errors. Missing parts can always be re-added in the new
> >> include_next fashion if necessary.
> >>
> >> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> > 
> > Some of these functions are needed, because they are not provided by old
> > kernel versions.
> 
> Let me know what's a good way of figuring out what's still needed and
> I'll replace the old header the way that Johannes suggested.

Easiest is probably to try compiling against the oldest kernel we still
support - that would be 2.6.25 - until all the drivers compile :)

johannes

