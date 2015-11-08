Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:58606 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbbKHTLp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Nov 2015 14:11:45 -0500
Message-ID: <1447009902.19559.0.camel@sipsolutions.net> (sfid-20151108_201147_542921_71FC0CE2)
Subject: Re: [PATCH 04/10] header: add ktime_get_ns()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Sun, 08 Nov 2015 20:11:42 +0100
In-Reply-To: <1446915310-8278-5-git-send-email-hauke@hauke-m.de> (sfid-20151107_175525_215515_2F8EF9A1)
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
	 <1446915310-8278-5-git-send-email-hauke@hauke-m.de>
	 (sfid-20151107_175525_215515_2F8EF9A1)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2015-11-07 at 17:55 +0100, Hauke Mehrtens wrote:
> We also have to add the prototype of ktime_t ktime_get(), because
> including linux/hrtimer.h caused some strange build errors.
> 
Strange, didn't happen here, but I didn't test that many kernel
versions.

Thanks!

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
