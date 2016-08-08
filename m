Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45834 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbcHHVyI (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Aug 2016 17:54:08 -0400
Date: Mon, 8 Aug 2016 23:54:03 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
	Valentin Rothberg <valentinrothberg@gmail.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-kernel@vger.kernel.org, teg@jklm.no, kay@vrfy.org,
	rusty@rustcorp.com.au, akpm@linux-foundation.org,
	backports@vger.kernel.org, gregkh@linuxfoundation.org,
	Michal Marek <mmarek@suse.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	"rafael.j.wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 2/3] Add generation of Module.ksymb file in
 streamline_config.pl
Message-ID: <20160808215403.GX3296@wotan.suse.de> (sfid-20160808_235411_502354_5FECF7F1)
References: <1469979232-15531-1-git-send-email-cristina.moraru09@gmail.com>
 <1469979232-15531-3-git-send-email-cristina.moraru09@gmail.com>
 <20160808191533.GT3296@wotan.suse.de>
 <alpine.DEB.2.10.1608082230110.3341@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1608082230110.3341@hadrien>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Aug 08, 2016 at 10:32:46PM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 8 Aug 2016, Luis R. Rodriguez wrote:
> 
> > On Sun, Jul 31, 2016 at 05:33:51PM +0200, Cristina Moraru wrote:
> > > Add generation of ./scripts/mod/Module.ksymb file containing
> > > associations of driver file names and corresponding CONFIG_*
> > > symbol.
> > >
> > > This file will be used by modpost to peg kconfig CONFIG_*
> > > symbol to its corresponding module. This information will
> > > be further exposed in userspace for extracting build options
> > > for the required modules.
> > >
> > > This approach faces the following limitations:
> > > * in some cases there are more than one CONFIG_* option
> > > for certain objects. This happens for the objects that are
> > > part of more CONFIGs. Thus, all configs are returned for
> > > this object names. For example, the mapping for clk_div6 is
> > > CONFIG_ARCH_R8A73A4, CONFIG_ARCH_R8A7793 and many others.
> >
> > Ah, indeed so for instance:
> >
> > drivers/clk/renesas/Makefile:
> > ...
> > obj-$(CONFIG_ARCH_R8A73A4)              += clk-r8a73a4.o clk-div6.o
> > obj-$(CONFIG_ARCH_R8A7740)              += clk-r8a7740.o clk-div6.o
> > ...
> >
> > So in this case there is no particular unique CONFIG_* symbols that
> > only associates itself to clk-div6.
> >
> > Given that the purpose here is to help compile a .config that is sufficient to
> > build a kernel with that module, I do believe using both config symbols would
> > be the appropriate solution in this case to ensure a build suffices based only
> > on this information.  This is only possible of course *iff* both symbols are
> > not mutually exclusive, so in this case an issue would be if for instance
> > CONFIG_ARCH_R8A73A4's kconfig entry negates CONFIG_ARCH_R8A7740. They do not
> > in this case so using both suffices. I can imagine doing this secondary logic
> > is cumbersome, so perhaps its best we avoid these sorts of situations as it
> > would imply doing more work going barkwards -- from modules loaded to modules
> > to symbols.
> >
> > I'd bet this would not be the only kconfig issue that could arise from this
> > loose practice in kconfig.
> >
> > Anyway, if we determine that both kconfig options should be enabled for a build
> > to select this driver -- that would increase the build size, perhaps with no
> > need for it. So this strategy of course would not yield optimal builds.
> 
> Do you care?  I guess no one would want clk-div6 for actual execution.  I
> haven't looked at the file, but from the make information, it looks like a
> library that is shared by two drivers and has no independent interest.  If
> the goal is just to be sure that the code is compiled, for sanity checking
> purposes, then wouldn't it be fine to either pick one option, or pick both
> (giving perhaps a little more confidence at a small cost).

Indeed but both kconfig options may be mutually exclusive, in such case a tool
trying to pick what should be enabled must do more work, maybe read some
Kconfig and then understand that language.

I'm a bit more inclined to close the gap and leave this ambiguity out of the
kconfig picture if possible so we have 1-1 mappings for modules at least, then
dependencies are explicit and tools doing backward mapping would not have to
learn kconfig.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
