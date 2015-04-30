Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:47444 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbbD3HIz (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 30 Apr 2015 03:08:55 -0400
Message-ID: <1430377731.1963.0.camel@sipsolutions.net> (sfid-20150430_090857_056743_E7498972)
Subject: Re: trouble building ath10k on newer versions
From: Johannes Berg <johannes@sipsolutions.net>
To: Peter Sabat <pete@sablalik.us>
Cc: backports@vger.kernel.org
Date: Thu, 30 Apr 2015 09:08:51 +0200
In-Reply-To: <D166E367.18190A%pete@sablalik.us> (sfid-20150430_023826_856464_5621F96E)
References: <D166E367.18190A%pete@sablalik.us>
	 (sfid-20150430_023826_856464_5621F96E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-04-29 at 19:37 -0400, Peter Sabat wrote:
> Just wondering if something has changed since backports-20150129 that
> would only allow compat and cfg80211 build ?
> 
> I noticed that mac80211 isn¹t in the menuconfig now, but the build worked
> fine before.
> 
> 
> 
> I do have CONFIG_CRYPTO_CCM in my kernel config :

You also need _GCM now.

johannes

