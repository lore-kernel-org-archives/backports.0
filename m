Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:45989 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaEOJZv (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 15 May 2014 05:25:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <johannes@sipsolutions.net>)
	id 1WkrvC-0001dN-1D
	for backports@vger.kernel.org; Thu, 15 May 2014 11:25:50 +0200
Message-ID: <1400145942.4146.0.camel@jlt4.sipsolutions.net> (sfid-20140515_112553_428358_3720CDB3)
Subject: Re: [PATCH] backport: CCM: set correct dependencies
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Thu, 15 May 2014 11:25:42 +0200
In-Reply-To: <1400145726-16520-1-git-send-email-johannes@sipsolutions.net> (sfid-20140515_112220_823082_F95EE84B)
References: <1400145726-16520-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20140515_112220_823082_F95EE84B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-05-15 at 11:22 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If these aren't actually compiled in, then the mac80211
> code will fail at runtime. Add these dependencies so we
> at least get a warning at compile time about this.

The possibly preferable alternative would be to rip out the CCM backport
again - if we want to have all those dependencies we'll quickly end up
including the entire crypto subsystem (which would probably even be
possible!) but it doesn't seem worth it.

johannes

