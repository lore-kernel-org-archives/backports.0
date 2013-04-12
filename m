Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:38844 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3DLLDi (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 07:03:38 -0400
Message-ID: <1365764614.8399.5.camel@jlt4.sipsolutions.net> (sfid-20130412_130341_003152_CA2C758B)
Subject: Re: [PATCH] backports: add support for backport_srctree
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 12 Apr 2013 13:03:34 +0200
In-Reply-To: <CAB=NE6WCw=C+N6nodHSV1orxDwrfmR65mscsCeA7uM5zcSMf0w@mail.gmail.com> (sfid-20130412_124344_867802_8C388C13)
References: <1365760927-7379-1-git-send-email-mcgrof@do-not-panic.com>
	 <CAB=NE6WCw=C+N6nodHSV1orxDwrfmR65mscsCeA7uM5zcSMf0w@mail.gmail.com>
	 (sfid-20130412_124344_867802_8C388C13)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-04-12 at 03:43 -0700, Luis R. Rodriguez wrote:
> On Fri, Apr 12, 2013 at 3:02 AM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> >
> > The Linux kernel uses srctree to help prefix header files
> > and scripts. When backporting we want to be able to override
> > driver's Makefiles' usage of srctree with our own. Since we
> > can't easily and sanely override the srctree itself without
> > causing a lot of issues just use the python generator to
> > do the change for us on the target Makefiles. This addresses
> > the srctree usage case and where ccflags was used without
> > prefixing any parent directory when used with drivers, the
> > kernel tends to fix that with addtree command.
> >
> > Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> > ---
> >
> > Running ckmake now too so you can either apply or wait.
> >
> >  backport/Makefile.kernel |    2 ++
> >  gentree.py               |    4 +++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
> > index 91e7dd6..76202f8 100644
> > --- a/backport/Makefile.kernel
> > +++ b/backport/Makefile.kernel
> > @@ -15,6 +15,8 @@ NOSTDINC_FLAGS := \
> >         $(BACKPORTS_GIT_TRACKER_DEF) \
> >         $(CFLAGS)
> >
> > +backport_srctree = $(M)
> 
> this needs to be just srctree as the gen script will add the backport
> prefix for us.

I'd probably be a little more careful in teh regex and just replace
"$(srctree)" (needs escaping for regex)?

johannes

