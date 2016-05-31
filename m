Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43939 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbcEaUzx (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 31 May 2016 16:55:53 -0400
Message-ID: <1464728148.3076.35.camel@sipsolutions.net> (sfid-20160531_225555_504523_EC9FDBF9)
Subject: Re: [PATCH] backports: add nla_put_u64_64bit()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	backports@vger.kernel.org
Date: Tue, 31 May 2016 22:55:48 +0200
In-Reply-To: <574DE840.4060009@broadcom.com> (sfid-20160531_213843_163887_ED438BDB)
References: <1464703661-10164-1-git-send-email-johannes@sipsolutions.net>
	 <574DE840.4060009@broadcom.com> (sfid-20160531_213843_163887_ED438BDB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2016-05-31 at 21:38 +0200, Arend van Spriel wrote:
> On 31-05-16 16:07, Johannes Berg wrote:
> > 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Backport it simply using nla_put_u64(). This is fine for all the
> > current users, but probably should be fixed.
> I submitted a patch including this a couple of weeks ago titled:
> "backports: netlink: add 64-bit aligned helper functions".
> 

Indeed you did, sorry. Ignore this one then.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
