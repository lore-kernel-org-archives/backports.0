Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48074 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbbDQR2o (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 17 Apr 2015 13:28:44 -0400
Message-ID: <1429291720.1885.5.camel@sipsolutions.net> (sfid-20150417_192845_996116_0E63EA54)
Subject: Re: Possible to build-in backports modules into kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Petr Vorel <petr.vorel@gmail.com>, backports@vger.kernel.org
Date: Fri, 17 Apr 2015 19:28:40 +0200
In-Reply-To: <5531314D.1000706@lwfinger.net> (sfid-20150417_181411_559997_6D84A8C0)
References: <20150417133004.GC16380@vorel-pc>
	 <5531314D.1000706@lwfinger.net> (sfid-20150417_181411_559997_6D84A8C0)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-04-17 at 11:14 -0500, Larry Finger wrote:

> The short answer is no for the backports code. If you want them built-in, grab 
> the mainline 4.0 or 3.19.4 source, configure, and build a complete new kernel.

Technically this is not true any more - the backports gentree.py script
now supports kernel integration where it copies the backport into
another kernel tree :)

johannes

