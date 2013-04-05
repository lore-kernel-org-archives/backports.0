Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49075 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107Ab3DECTD (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 4 Apr 2013 22:19:03 -0400
Date: Thu, 4 Apr 2013 22:12:59 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Phil Perry <phil@pendre.co.uk>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [ANN] new backports project
Message-ID: <20130405021259.GM27415@gospo.rdu.redhat.com> (sfid-20130405_041907_256420_A88C91F8)
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>
 <1364923241.8204.15.camel@jlt4.sipsolutions.net>
 <515B4994.3030309@pendre.co.uk>
 <1364937780.8204.18.camel@jlt4.sipsolutions.net>
 <CAB=NE6VDAekd_a--iFocHGWxdzhVXbQrBcV1HD+kHvbL68r4iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB=NE6VDAekd_a--iFocHGWxdzhVXbQrBcV1HD+kHvbL68r4iw@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 02, 2013 at 02:42:56PM -0700, Luis R. Rodriguez wrote:
> On Tue, Apr 2, 2013 at 2:23 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> > I only addressed what compat-drivers-... had a few days ago.
> >
> > However, I simplified the system a bit. I don't have any snapshot, but I
> > did announce the git tree. Grab that, run ./gentree.py against
> > linux-next and you should get something. Then you will have to hack up
> > the Kconfig (backport/compat/Kconfig) and include files
> > (backport/include/*), presumably.
> 
> Or you can wait until we merge. At this point I'm freezing development
> on compat and compat-drivers to merge all this work onto Johannes'
> tree.
> 
> > If you're interested in alx, you'd have to add that -- look at the
> > copy-list.alx file for that.
> 
> Johannes already committed a few things here, I'll be sure to test it as well.
> 
> > I hope that soon enough Luis might cut some testing releases from this
> > though.
> 
> Absolutely, full steam ahead, just give us a few days.
> 
> I should note that RHEL / SUSE / Debian all had the same issues --
> running into symbols we are exporting with the same upstream name. The
> move to use LINUX_BACKPORT() should help cure these issues in general
> moving forward. Additionally if you really want to help in this area
> please review commit 8ae96730 on compat.git specifically Andi Kleen's
> work on module namespace. If we can figure out to support module
> namespace *ourselves*, ie, without Linus having to carry this crap
> around, then we'd solve all these issues easily, I believe we wouldn't
> have to rely on LINUX_BACKPORT() and in fact that would also mean
> renaming our *driver* symbols. This means for instance you can run one
> drivers with your stock mac80211, another with the backported version,
> should you ever have to support such crazy environement.
> 

As I was watching the patches for LINUX_BACKPORT fly past over the last
few weeks and making changes to allow RHEL to work with compat, I
wondered, "Why not add the LINUX_BACKPORT macro to each one of the
symbols backported?"

Of course that seems extremely tedious, but is there a compelling reason
why something like this should not be done -- other than possibly doing
as Luis suggests and finding a way to resurrect Andi Kleen's proposal
for module symbol namespaces -- then I think the option to begin a more
liberal use of the LINUX_BACKPORT macro is worth considering.
