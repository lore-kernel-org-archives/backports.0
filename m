Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57299 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbaASVIr (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 19 Jan 2014 16:08:47 -0500
Message-ID: <1390165721.4336.10.camel@jlt4.sipsolutions.net> (sfid-20140119_220849_520140_F0245518)
Subject: Re: [PATCH 2/2] backports: add support for testing only a single
 Coccinelle SmPL patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org, Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Date: Sun, 19 Jan 2014 22:08:41 +0100
In-Reply-To: <52DC063B.4070801@hauke-m.de> (sfid-20140119_180720_012738_EE2F3704)
References: <1386851914-5241-1-git-send-email-mcgrof@do-not-panic.com>
	 <1386851914-5241-2-git-send-email-mcgrof@do-not-panic.com>
	 <52DC063B.4070801@hauke-m.de> (sfid-20140119_180720_012738_EE2F3704)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2014-01-19 at 18:07 +0100, Hauke Mehrtens wrote:

> > $ time ./gentree.py --clean --verbose --test-cocci \
> > 	patches/collateral-evolutions/network/11-dev-pm-ops.cocci \
> > 	/home/mcgrof/linux-next/ \
> > 	/home/mcgrof/build/backports-20131206

I'm not really convinced that adding profile options for spatch is a
good thing in gentree anyway. It's complicated enough as is, and running
the spatch manually isn't all that difficult. If you use the --gitdebug
option to gentree, you could even roll back to just before the patch was
applied before running it manually.

Now, I don't want to control what goes into backports, but this way I
might end up having to rewrite it again ;-)

johannes

