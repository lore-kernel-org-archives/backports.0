Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:59865 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbaATLB2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jan 2014 06:01:28 -0500
Message-ID: <1390215684.4335.17.camel@jlt4.sipsolutions.net> (sfid-20140120_120207_000611_0026CACB)
Subject: Re: [PATCH 1/3] backports: update patch Python library
From: Johannes Berg <johannes@sipsolutions.net>
To: anatoly techtonik <techtonik@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Date: Mon, 20 Jan 2014 12:01:24 +0100
In-Reply-To: <CAPkN8xJjvBFQJHaEu_yUsHaeDybws02NcfegdyXq_+RN-XssOQ@mail.gmail.com> (sfid-20140116_230136_989236_F7A16FC7)
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
	 <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com>
	 <1367933208.8328.11.camel@jlt4.sipsolutions.net>
	 <CAPkN8xJjvBFQJHaEu_yUsHaeDybws02NcfegdyXq_+RN-XssOQ@mail.gmail.com>
	 (sfid-20140116_230136_989236_F7A16FC7)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2014-01-17 at 01:01 +0300, anatoly techtonik wrote:

> Sorry for a long delay. I finally lost my job, so now I can have some continuous
> time piece to concentrate on python-patch.

Oops, sorry to hear that. You make it sound almost positive though.

> > We assume that all patches need one level stripped, but if a patch is a
> > git patch (as indicated by having the "diff" and/or (?) "index" lines),
> > then the patch library will already strip a level. That basically
> > assumes that users use "-p0" on 'plain' patches, which isn't the case,
> > we always use -p1.
> >
> > IOW, this will break dropping git patches (e.g. git
> > diff/show/format-patch) into the patches directory.
> 
> patch.py is smart enough to strip only a/ and b/ prefixes, and do this
> automatically when it is needed.

Well, yes, but it doesn't auto-detect other prefixes. So if I diff
something manually, then the prefixes aren't removed. As a result, I
must generate the patch using git if I want it to work right, or must go
against the -p1 convention when generating it manually. Both of those
are cumbersome and hard to remember.

IOW, you're assuming that a 'real patch' has no prefix, and a 'git
patch' has useless a/ and b/ prefixes. But that relies on a certain
convention about a 'real patch' which isn't true in the Linux community.

> How do you use patch.py?

We use it to apply patches within the backport project, those patches
are stored in the project and applied against upstream Linux code.

> Why do you have to use -p1?

See above.

> > Anatoly, would you be interested in maybe having an option to disable
> > this stripping? If yes, I can do that, otherwise I'm just going to edit
> > it out of our copy of your library again :-)
> 
> Thanks to Google Code editor with no HG or GIT watermark I now also
> implemented a/ and b/ stripping logic in apply function - see here:
> http://code.google.com/p/python-patch/source/browse/trunk/patch.py?spec=svn229&r=229#746
> It will be in first 1.14.x release.

Again, you're assuming that the 'canonical patch' should have no
prefixes. This is simply a matter of convention (whether -p0 or -p1 is
preferred by the project when applying a patch), and that convention
happens to be -p1 for many projects. You're assuming -p0.

Anyway, since the current version of patch.py does what we need, there's
little incentive for us to update/change things. If you consider a
'canonical patch' to be -p0, we'll just keep our changed copy :)

johannes

