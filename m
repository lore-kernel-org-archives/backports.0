Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:43478 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162581Ab3DET3i (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 15:29:38 -0400
Message-ID: <1365190171.8515.37.camel@jlt4.sipsolutions.net> (sfid-20130405_212939_479284_FF6B41CB)
Subject: Re: [PATCH 0/5] backports: add DRM drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Fri, 05 Apr 2013 21:29:31 +0200
In-Reply-To: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130405_183828_050373_194F1346)
References: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130405_183828_050373_194F1346)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-04-05 at 09:38 -0700, Luis R. Rodriguez wrote:

>   compat: backport dma-buf
>   compat: add HDMI library support

I replaced these two with the new automatic system I created, so all
they need to do is add the Kconfig parts (and a patch for dma-buf). It
works pretty well -- what I haven't done yet though is make it depend on
the drivers you actually have so that hdmi/dma-buf wouldn't be included
if you modify the copy-list to only have wireless drivers -- not a big
deal right now.

>   backports: remove dma-buf patches
>   backports: remove DRM nouveau kconfig patches

Applied.

>   backports: add DRM drivers

I changed the copy-list patch here to remove two redundant
subdirectories under nouveau/ and radeon that you had listed:

+drivers/gpu/drm/nouveau/core/
+drivers/gpu/drm/nouveau/
+drivers/gpu/drm/radeon/reg_srcs/
+drivers/gpu/drm/radeon/

Since copying is recursive, just the core/ and reg_srcs/ lines are
redundant.

Otherwise it's building a ckmake --allyesconfig right now, and if it
doesn't break I'll push it out.

Thanks!

johannes

