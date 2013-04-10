Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60054 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3DJNQg (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:16:36 -0400
Message-ID: <1365599791.8388.16.camel@jlt4.sipsolutions.net> (sfid-20130410_151639_512041_584B524F)
Subject: Re: [PATCH 02/18] compat: backport dev_level_ratelimited()
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:16:31 +0200
In-Reply-To: <1365593728-5720-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133546_274466_444BECF5)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-3-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133546_274466_444BECF5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:

Applied.

> +++ b/backport/include/linux/compat-3.5.h
> @@ -10,6 +10,42 @@
>  
>  #include <net/netlink.h>
>  
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
> +#include <linux/ratelimit.h>

I think, however, that it would be easier to understand if we started
putting less stuff into compat-xyz.h and more into linux/feature.h?
Needs more discussion though I guess.

johannes

