Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55405 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbcGOSkP (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 15 Jul 2016 14:40:15 -0400
Message-ID: <1468608010.3640.3.camel@sipsolutions.net> (sfid-20160715_204017_190483_F79877BC)
Subject: Re: [PATCH 12/19] patches: make iwlwifi use the old thermal APIs
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Fri, 15 Jul 2016 20:40:10 +0200
In-Reply-To: <1468606541.3640.0.camel@sipsolutions.net> (sfid-20160715_201548_686432_35A36375)
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
	 <1468185285-28265-13-git-send-email-hauke@hauke-m.de>
	 (sfid-20160711_013911_630415_E2AA8EEB) <1468606541.3640.0.camel@sipsolutions.net>
	 (sfid-20160715_201548_686432_35A36375)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2016-07-15 at 20:15 +0200, Johannes Berg wrote:
> On Sun, 2016-07-10 at 23:14 +0200, Hauke Mehrtens wrote:
> > The thermal API changed in the last kernel versions, make iwlwifi
> > use
> > the correct interface for each kernel version.
> > 
> What's wrong with Luca's approach for this?
> 
> I really dislike having to touch the code, even if the amount of code
> for the "proper" backport is possibly bigger.
> 

Oh, I see - Luca never sent it out ... I'll test it and do that.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
