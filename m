Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51101 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbbHaMy2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 31 Aug 2015 08:54:28 -0400
Message-ID: <1441025664.13980.8.camel@sipsolutions.net> (sfid-20150831_145430_798923_7CD87D71)
Subject: Re: newbie questions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Mon, 31 Aug 2015 14:54:24 +0200
In-Reply-To: <55E44DA7.3000209@linux.intel.com>
References: <55E3A03D.6050607@linux.intel.com>
	 (sfid-20150831_023101_616135_D37C8DBB) <1441006988.13980.3.camel@sipsolutions.net>
	 <55E44DA7.3000209@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-08-31 at 07:50 -0500, Pierre-Louis Bossart wrote:
> 
> > In general, this is possible. Check out the copy-list file. You can
> > edit this, and it'll copy only what's listed there.
> 
> ok. I was thinking of a more automated way that doesn't require me to 
> maintain a branch but that'll do for now.

maintaining a branch of the copy-list is simple though.

> > In order to add sound though, you'll also have to at least change
> > backport/Makefile.kernel and backport/Kconfig.sources to include 
> > the
> > sound directory in the kconfig and build.
> 
> yes that part works fine. I still have to figure out how Kconfig 
> works in the backports, I didn't get the explanations.

You can submit this part upstream btw - it'll just be disabled in the
default copy-list... unless you also submit that upstream.

> humm... What I wanted is backport next-20150731 to v4.1.6. linux-next 
> is checked out to next-20150731.
> which of the two does git-revision refer two? the linux-next origin 
> or the destination?

The *to* version is never relevant. A given backport will compile
against many different *to* versions.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
