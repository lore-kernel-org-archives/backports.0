Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:54804 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733AbaATHCH (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jan 2014 02:02:07 -0500
Date: Mon, 20 Jan 2014 08:02:04 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org, Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: Re: [PATCH 2/2] backports: add support for testing only a single
 Coccinelle SmPL patch
In-Reply-To: <1390165721.4336.10.camel@jlt4.sipsolutions.net>
Message-ID: <alpine.DEB.2.02.1401200800010.1971@localhost6.localdomain6> (sfid-20140120_080209_462937_C391F6EC)
References: <1386851914-5241-1-git-send-email-mcgrof@do-not-panic.com>  <1386851914-5241-2-git-send-email-mcgrof@do-not-panic.com>  <52DC063B.4070801@hauke-m.de> (sfid-20140119_180720_012738_EE2F3704) <1390165721.4336.10.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 19 Jan 2014, Johannes Berg wrote:

> On Sun, 2014-01-19 at 18:07 +0100, Hauke Mehrtens wrote:
> 
> > > $ time ./gentree.py --clean --verbose --test-cocci \
> > > 	patches/collateral-evolutions/network/11-dev-pm-ops.cocci \
> > > 	/home/mcgrof/linux-next/ \
> > > 	/home/mcgrof/build/backports-20131206
> 
> I'm not really convinced that adding profile options for spatch is a
> good thing in gentree anyway. It's complicated enough as is, and running
> the spatch manually isn't all that difficult. If you use the --gitdebug
> option to gentree, you could even roll back to just before the patch was
> applied before running it manually.
> 
> Now, I don't want to control what goes into backports, but this way I
> might end up having to rewrite it again ;-)

I'm not sure to understand the issue.  Spatch has a --profile option, but 
I don't see it in the above code.  From my point of view, it could be nice 
if people are somehow encouraged to use that option from time to time, 
because it increases the chance that they will report back on performance 
problems.  But there is no need for it to bein the default execution path.

julia
