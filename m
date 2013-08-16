Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:41109 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab3HQAJL (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 16 Aug 2013 20:09:11 -0400
Message-ID: <1376680966.15299.33.camel@jlt4.sipsolutions.net> (sfid-20130817_020916_509112_219B2299)
Subject: Re: [PATCH 08/13] backports: revert the sysfs api change
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Date: Fri, 16 Aug 2013 21:22:46 +0200
In-Reply-To: <520E699F.8040601@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
	  <1376674003-5801-8-git-send-email-hauke@hauke-m.de>
	  (sfid-20130816_192740_585582_63BCDE6E) <1376674550.15299.27.camel@jlt4.sipsolutions.net>
	 <520E699F.8040601@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-08-16 at 20:04 +0200, Hauke Mehrtens wrote:

> This is done to eliminate these warnings:

Fair enough.

> I do not like this whole patch that much, do you have a better idea to
> backport this change:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=f0bc99c84349ce87af5b35839d19bfb17bb9b27f

I played with it a bit, and came up with this:

http://p.sipsolutions.net/e3140c53fb57f9ed.txt

It has the small advantage that the patch is smaller and doesn't need to
know about the attributes ... A disadvantage is the runtime overhead on
module load and the extra memory.

As we discussed on IRC, the #else part is only needed to not have to
#ifdef the init_ieee80211_attrs() call, it might very well be better to
ifdef that and get rid of the #else part to avoid having to copy part of
the ATTRIBUTE_GROUPS definition. Not really sure.

johannes

