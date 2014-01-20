Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:59462 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaATIoY (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jan 2014 03:44:24 -0500
Message-ID: <1390207455.4335.1.camel@jlt4.sipsolutions.net> (sfid-20140120_094426_841127_7AE965FB)
Subject: Re: [PATCH 2/2] backports: add support for testing only a single
 Coccinelle SmPL patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org, Peter Senna <peter.senna@gmail.com>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Date: Mon, 20 Jan 2014 09:44:15 +0100
In-Reply-To: <alpine.DEB.2.02.1401200800010.1971@localhost6.localdomain6>
References: <1386851914-5241-1-git-send-email-mcgrof@do-not-panic.com>
	  <1386851914-5241-2-git-send-email-mcgrof@do-not-panic.com>
	  <52DC063B.4070801@hauke-m.de>
	 (sfid-20140119_180720_012738_EE2F3704) <1390165721.4336.10.camel@jlt4.sipsolutions.net>
	 <alpine.DEB.2.02.1401200800010.1971@localhost6.localdomain6>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2014-01-20 at 08:02 +0100, Julia Lawall wrote:

> > > > $ time ./gentree.py --clean --verbose --test-cocci \
> > > >   patches/collateral-evolutions/network/11-dev-pm-ops.cocci \
> > > >   /home/mcgrof/linux-next/ \
> > > >   /home/mcgrof/build/backports-20131206
> > 
> > I'm not really convinced that adding profile options for spatch is a
> > good thing in gentree anyway. It's complicated enough as is, and running
> > the spatch manually isn't all that difficult. If you use the --gitdebug
> > option to gentree, you could even roll back to just before the patch was
> > applied before running it manually.

> I'm not sure to understand the issue.  Spatch has a --profile option, but 
> I don't see it in the above code.  From my point of view, it could be nice 
> if people are somehow encouraged to use that option from time to time, 
> because it increases the chance that they will report back on performance 
> problems.  But there is no need for it to bein the default execution path.

I'm just saying that making 'gentree' the kitchen sink of backports
generation, spatch profiling, patch refreshing, etc. will just make for
really messy code (it's not particularly clean as is) and that I don't
see the need for adding everything into it since running spatch
--profile or other such manually isn't terribly difficult (so there's
little reason to add it to gentree.)

johannes


