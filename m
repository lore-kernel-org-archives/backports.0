Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:53595 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161883AbaKNUy2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 14 Nov 2014 15:54:28 -0500
Message-ID: <1415998465.1847.4.camel@sipsolutions.net> (sfid-20141114_215446_582863_BDCA895D)
Subject: Re: [PATCH v3 00/21] backports: add kernel integration support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yann E. MORIN" <yann.morin.1998@free.fr>,
	Michal Marek <mmarek@suse.cz>,
	Stefan Assmann <sassmann@kpanic.de>
Date: Fri, 14 Nov 2014 21:54:25 +0100
In-Reply-To: <CAB=NE6X_d68Wc=CFAMb_suWJJQgSOSNafHiMwAmC6YhJFEtP1w@mail.gmail.com> (sfid-20141114_215317_746640_45CFB1A7)
References: <1415693712-23743-1-git-send-email-mcgrof@do-not-panic.com>
	 <1415998228.1847.3.camel@sipsolutions.net>
	 <CAB=NE6X_d68Wc=CFAMb_suWJJQgSOSNafHiMwAmC6YhJFEtP1w@mail.gmail.com>
	 (sfid-20141114_215317_746640_45CFB1A7)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2014-11-14 at 12:52 -0800, Luis R. Rodriguez wrote:
> On Fri, Nov 14, 2014 at 12:50 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Tue, 2014-11-11 at 00:14 -0800, Luis R. Rodriguez wrote:
> >> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >>
> >> This third series should hopefully address all pending feedback.
> >> I've split out patches even more, but more importantly have
> >> made the parser simpler by both integrating the logic required
> >> to understand a backport by identifying the backport by type
> >> and strategy, sharing that, and then providing ignore lists on
> >> the parsers.
> >
> > I think from a code change POV I should be OK with this, but I'll
> > definitely want to run it and see the differences. I'll have to do that
> > next week, it's getting late here.
> 
> OK. So I shouldn't merge yet?

I would prefer you didn't, but OTOH we can always fix up issues later as
well.

johannes

