Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:37271 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbbJWJeU (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Oct 2015 05:34:20 -0400
Message-ID: <1445592856.1945.0.camel@sipsolutions.net> (sfid-20151023_113422_594771_923ED8AB)
Subject: Re: [PATCH] backports: add ktime_get_seconds()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>, backports@vger.kernel.org
Date: Fri, 23 Oct 2015 11:34:16 +0200
In-Reply-To: <5629FEB3.6050905@broadcom.com> (sfid-20151023_113239_295482_F75BC0A3)
References: <1445584991-11249-1-git-send-email-johannes@sipsolutions.net>
	 <5629FEB3.6050905@broadcom.com> (sfid-20151023_113239_295482_F75BC0A3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-10-23 at 11:32 +0200, Arend van Spriel wrote:
> On 10/23/2015 09:23 AM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> 
> Already submitted a patch for this. I just did not bother to 
> introduce the timekeeping.h file. So yours may be preferred.
> 

Oh, missed that. Yours is better with time64_t though, so we should
probably merge them...

Adding the timekeeping.h file might be required if, in the future,
somebody includes only it instead of ktime.h

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
