Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <andy@greyhouse.net>
Date: Wed, 8 May 2013 08:24:23 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Dropping non supported kernels for kernel backports ?
Message-ID: <20130508122423.GC7756@gospo.rdu.redhat.com>
References: <CAB=NE6Wy0dp51wDxKzo74Kz=2F-MQjOnARS1r-z3v+LrOwhn-Q@mail.gmail.com>
 <1367996104.8279.5.camel@jlt4.sipsolutions.net>
 <518A0DA5.4060001@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <518A0DA5.4060001@hauke-m.de>
List-ID: <backports@vger.kernel.org>

On Wed, May 08, 2013 at 10:32:37AM +0200, Hauke Mehrtens wrote:
> On 05/08/2013 08:55 AM, Johannes Berg wrote:
> > On Tue, 2013-05-07 at 16:53 -0700, Luis R. Rodriguez wrote:
> >> Today the backports project provides support to backport down to
> >> 2.6.24 for some subsystems. While this is good for users in practice
> >> for development and maintenance this is quite a bit of overhead. Apart
> >> from older kernels there are also gaps in between stable releases that
> >> are not supported. For example 3.8 and 3.4 are supported but anything
> >> in between is not (3.5, 3.6, 3.7), but we still do support them on the
> >> backports project. At times this may mean a stable fix may get
> >> propagated onto a the linux-3.4.y branch but obviously not the the
> >> linux-3.5.y branch. If backporting expressing this becomes a bit
> >> complex and we have dealt with it. In short, its a pain.
> >>
> >> I'd like to see what folks thought if we went ahead and *only*
> >> supported kernels listed on kernel.org as supported. This would help
> >> with the Linux kernel maintainer effort by also persuading users to
> >> upgrade to stable releases as well as educating around this.
> >>
> >> If v3.10 backported releases are too soon to do this I propose we
> >> seriously consider it for v3.11 releases. Any thoughts?
> > 
> > I'm sure I'd still have to support other kernels random customers might
> > be on (customers, they don't always do the smart thing ;-) ). I could do
> > that myself of course, but then where would I stick the support patches?
> > 
> > Maybe we could do a compromise and drop support for no longer supported
> > kernels, but only a few years later? If we put the cutoff at 3 years now
> > we'd drop everything before 2.6.34, for example.
> > 
> > johannes
> 
> I it is not often that something compat depends on gets backported into
> some longterm kernel. The majority ~90% of backports added to compat are
> not backported to any longterm kernel. If we want to support some kernel
> version I do not think it is a hard task to support the versions in between.
> 
> Instead of supporting everything back to 2.6.34 I would like to got to
> 2.6.32 because this was used in Debian squeeze, RedHat 6 and some Ubuntu
> long term version.

Agreed.

> Dropping support for kernel versions not older than a year but not
> supported any more is a bad idea, because the big distributions often
> pick a non longterm kernel as their distribution kernel. Than we would
> not even support the recent Ubuntu versions for a long time. Ubuntu
> 12.10 uses kernel 3.5 and Ubuntu 13.04 uses 3.8, both are no longterm
> kernel versions.

If most feel that the primary users of these releases are users running
distros rather than self-compiled kernels then we should definitely look
to support only those that are popular on the major distros. 

When you say you want to drop support, would you want to stop checking
against older kernels during the build proces or would you want to
remove the code to support them as well?  Maybe a warning first to those
building on older kernels that their support will soon be abandoned if
they do not speak up?
