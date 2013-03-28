Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44513 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab3C1XBw (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 19:01:52 -0400
Message-ID: <1364511704.10397.96.camel@jlt4.sipsolutions.net> (sfid-20130329_000154_574043_2A14A587)
Subject: Re: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 29 Mar 2013 00:01:44 +0100
In-Reply-To: <5154CA3A.2010901@hauke-m.de>
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
	  <CAB=NE6X9X0apA0tR-f2_f24W-sWXhUVky2OGEQhAO3=ta1Q2pA@mail.gmail.com>
	  (sfid-20130328_231602_638862_02D2B887) <1364509642.10397.76.camel@jlt4.sipsolutions.net>
	 <5154CA3A.2010901@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-03-28 at 23:54 +0100, Hauke Mehrtens wrote:

> > Ah, what's that for? Refreshing patches? I've never seen dependencies in
> > the compat patches so mostly I refresh manually, but yeah, the refresh
> > part is something I'd have to think about. Though, to be honest, when
> > you can just blow away your output directory and try again I'm not too
> > worried about this. Trying to apply the patches could just leave it in
> > the state you're in, and then you modify them until it works?
> 
> Refreshing patches should not be a problem. Normally I use
> "./scripts/admin-refresh.sh -n -p -c -u refresh" to refresh the patches
> and this should work with some minor changes with the proposal you made.

Ok. I have no idea what that does, since most of the time my
"refreshing" isn't really refreshing but making them apply again, and I
do that manually.

> > Basically I'm saying the .config file only exists on the target build
> > system, while the selective copying/pruning needs to be done on the
> > tarball creation system.
> 
> How do you want to make the tar generation being configurable? The build
> time Kconfig options should be generated from the Kconfig files provided
> by the kernel and not by some own files.

Right, the build time Kconfig should just be copied as other source
files.

> I think some manual edited config file with the directories or files to
> be included sounds good. This function would not be used by the normal
> user so that should be good enough.

Indeed, that's what I was thinking. Sorry for not making that clear.

johannes

