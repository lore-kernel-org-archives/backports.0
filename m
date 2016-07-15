Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55308 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcGOSPq (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 15 Jul 2016 14:15:46 -0400
Message-ID: <1468606541.3640.0.camel@sipsolutions.net> (sfid-20160715_201548_686432_35A36375)
Subject: Re: [PATCH 12/19] patches: make iwlwifi use the old thermal APIs
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Fri, 15 Jul 2016 20:15:41 +0200
In-Reply-To: <1468185285-28265-13-git-send-email-hauke@hauke-m.de> (sfid-20160711_013911_630415_E2AA8EEB)
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
	 <1468185285-28265-13-git-send-email-hauke@hauke-m.de>
	 (sfid-20160711_013911_630415_E2AA8EEB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2016-07-10 at 23:14 +0200, Hauke Mehrtens wrote:
> The thermal API changed in the last kernel versions, make iwlwifi use
> the correct interface for each kernel version.
> 
What's wrong with Luca's approach for this?

I really dislike having to touch the code, even if the amount of code
for the "proper" backport is possibly bigger.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
