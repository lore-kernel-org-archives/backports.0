Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60685 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab3DJRUY (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 13:20:24 -0400
Message-ID: <1365614413.4235.29.camel@jlt4.sipsolutions.net> (sfid-20130410_192031_572517_97204D49)
Subject: Re: [PATCH 06/18] compat: backport ASYNC_DOMAIN_EXCLUSIVE()
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 10 Apr 2013 19:20:13 +0200
In-Reply-To: <CAB=NE6UpP-X1NCTNRnoSdv_bk3ioZdg5bO1zz0U0dqeWVxZdLw@mail.gmail.com> (sfid-20130410_191424_309668_435F8E8F)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-7-git-send-email-mcgrof@do-not-panic.com>
	 <1365600139.4235.4.camel@jlt4.sipsolutions.net>
	 <CAB=NE6UpP-X1NCTNRnoSdv_bk3ioZdg5bO1zz0U0dqeWVxZdLw@mail.gmail.com>
	 (sfid-20130410_191424_309668_435F8E8F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 10:13 -0700, Luis R. Rodriguez wrote:
> On Wed, Apr 10, 2013 at 6:22 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
> >> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> >>
> >> For older kernels this is simply a matter of using
> >> LIST_HEAD.
> >
> > Hmm, how is that useful if it will not have any effect?
> 
> The core of the handling is done in the internal asynch code and
> that's kept hidden from the users of this -- so far.

I guess I'd have to review the async API, but now this wouldn't do
anything? What's the use of just this when you don't have things like
async_schedule_domain() and async_synchronize_full_domain(), regulator
stuff wouldn't compile I think?

I guess I'm a bit confused what kind of effect this has.

johannes

