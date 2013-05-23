Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35014 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759629Ab3EWP0C (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 May 2013 11:26:02 -0400
Message-ID: <1369322755.12002.21.camel@jlt4.sipsolutions.net> (sfid-20130523_172628_439424_FC398794)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 23 May 2013 17:25:55 +0200
In-Reply-To: <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com> (sfid-20130523_023807_543343_5F45C44D)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com>
	 <1369224306.8207.7.camel@jlt4.sipsolutions.net>
	 <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com>
	 (sfid-20130523_023807_543343_5F45C44D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-22 at 17:37 -0700, Luis R. Rodriguez wrote:
> On Wed, May 22, 2013 at 5:05 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
> >> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> >>
> >> This cleans sanitizes a source tree and ensures
> >> no content is present from what was intended.
> >
> > All of this (including the previous patches) makes me think
> > "--git-revision HEAD" should just be the default instead of trying to
> > muck with the working directory of the kernel tree too much?
> 
> Not sure I follow, but in any case, I just want to start being able to
> start making daily releases daily and fast, can we address this later?

I'm suggesting that you use --git-revision to do so, then you only have
to verify the tag you passed to --git-revision is signed and not have to
muck around with the tree. Technically, all the stuff you'd been doing
there is racy too, if you edit the checkout while the script is running,
and I think it's a bit pointless. I doubt it's even faster than using
--git-revision if it checks everything.

IOW, why go to all this complexity? I'd say all you need to do is
require that not passing --git-revision when --kup is passed is an
error. Then you can make --kup verify the tag passed to --git-revision
by just calling "git tag -v ..." for the --git-revision argument. This
will error out if it's not a tag.

Basically this means you only need patch 4, 6, 7 and a modified version
of 8.

johannes

