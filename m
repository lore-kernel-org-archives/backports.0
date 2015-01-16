Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41330 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbbAPLIK (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Jan 2015 06:08:10 -0500
Message-ID: <1421406483.9214.5.camel@sipsolutions.net> (sfid-20150116_120812_376627_498E565A)
Subject: Re: [PATCH V2] patches: genl-const: fix nl80211.patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Date: Fri, 16 Jan 2015 12:08:03 +0100
In-Reply-To: <1421352942-21625-1-git-send-email-arend@broadcom.com> (sfid-20150115_211552_467265_F71FCF92)
References: <1421352942-21625-1-git-send-email-arend@broadcom.com>
	 (sfid-20150115_211552_467265_F71FCF92)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2015-01-15 at 21:15 +0100, Arend van Spriel wrote:
> nl80211.c recently changed using defined strings instead of hard-coded in
> multi-cast group definitions:
> 
>   commit 71b836eca7f380fbd4c025f8c4371f9a071bc909
>   Author: Johannes Berg <johannes.berg@intel.com>
>   Date:   Tue Dec 23 17:17:38 2014 +0100
> 
>       nl80211: define multicast group names in header
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>

Thanks Arend!

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

