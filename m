Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:59573 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab3JUICl (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 04:02:41 -0400
Message-ID: <1382342556.14310.10.camel@jlt4.sipsolutions.net> (sfid-20131021_100243_541511_0249D311)
Subject: Re: [RFC] backports: replace netlink portid by semantic patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Eliad Peller <eliad@wizery.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 21 Oct 2013 10:02:36 +0200
In-Reply-To: <CAB3XZEdzDyanG-3vkbDqyc-pthCPfaBpBL5XH_39qkBUPR9OKQ@mail.gmail.com> (sfid-20131020_153910_943673_9A211158)
References: <1382110139-23344-1-git-send-email-johannes@sipsolutions.net>
	 <5261585F.8020000@hauke-m.de>
	 <1382115154.14393.18.camel@jlt4.sipsolutions.net>
	 <1382120027.14393.20.camel@jlt4.sipsolutions.net>
	 <CAB3XZEdzDyanG-3vkbDqyc-pthCPfaBpBL5XH_39qkBUPR9OKQ@mail.gmail.com>
	 (sfid-20131020_153910_943673_9A211158)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2013-10-20 at 15:39 +0200, Eliad Peller wrote:
> On Fri, Oct 18, 2013 at 9:13 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Fri, 2013-10-18 at 18:52 +0200, Johannes Berg wrote:
> >> On Fri, 2013-10-18 at 17:48 +0200, Hauke Mehrtens wrote:
> >> > How fast would it be when one more semantic patch would be added would
> >> > it increase in the same way? I am wondering if this is a constant
> >> > increase or does it depend on the number of patches.
> >>
> >> I believe it's # of patches because the slowest part seems to be
> >> searching all files for matches.
> >
> > FWIW, I still think it's worth it, especially the nl80211 patch breaks
> > all the time ...
> >
> maybe limit it to specific files/dirs?

Possible, but difficult, everything might use netlink. I suppose we
could grep first but if that's faster spatch should just be made faster
for the initial grep step I guess.

johannes

