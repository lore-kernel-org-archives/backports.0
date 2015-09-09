Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50064 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbbIIIqY (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Sep 2015 04:46:24 -0400
Message-ID: <1441788366.3316.1.camel@sipsolutions.net> (sfid-20150909_104630_609762_8A534DA0)
Subject: Re: [PATCH] backports: add spatch to handle IFF_NO_QUEUE
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: David Spinadel <david.spinadel@intel.com>
In-Reply-To: <1440572831-6075-1-git-send-email-johannes@sipsolutions.net> (sfid-20150826_090716_826305_AB1821E1)
References: <1440572831-6075-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20150826_090716_826305_AB1821E1)
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Sep 2015 10:46:07 +0200
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-08-26 at 09:07 +0200, Johannes Berg wrote:
> 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
> 
Actually, that needs to be > instead of >= of course.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
