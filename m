Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:33129 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056AbbFOHCm (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Jun 2015 03:02:42 -0400
Message-ID: <1434351759.2177.0.camel@sipsolutions.net> (sfid-20150615_090244_083314_13C233FF)
Subject: Re: [PATCH 02/21] patches: deactivate tracing for ath6kl, cfg80211
 and wil6210 only on kernel < 3.4
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Mon, 15 Jun 2015 09:02:39 +0200
In-Reply-To: <1434292162-2261-3-git-send-email-hauke@hauke-m.de> (sfid-20150614_162942_666968_4E02D0D5)
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
	 <1434292162-2261-3-git-send-email-hauke@hauke-m.de>
	 (sfid-20150614_162942_666968_4E02D0D5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2015-06-14 at 16:29 +0200, Hauke Mehrtens wrote:
> On kernel version >= 3.4 we can normally include tracing, only on such
> old kernel we have to deactivate the tracing code.

This is very annoying - why is this needed?

johannes

