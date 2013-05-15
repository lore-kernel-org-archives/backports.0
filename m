Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:53767 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981Ab3EOHmj (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 May 2013 03:42:39 -0400
Message-ID: <1368603754.8359.4.camel@jlt4.sipsolutions.net> (sfid-20130515_094241_800313_BD3A28B7)
Subject: Re: [PATCH v2 0/5] backports: move us up to next-20130423
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 15 May 2013 09:42:34 +0200
In-Reply-To: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_205437_850298_6D52E76E)
References: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130511_205437_850298_6D52E76E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-05-11 at 11:54 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> I've addressed backporting rfkill here in a way that
> I think is more suitable. Let me know what you think.

I've replaced the rfkill with my patch, and added the
vb2_mmap_pfn_range() patch that I had that was causing me trouble. Then
I applied your patches 2-5.

johannes

