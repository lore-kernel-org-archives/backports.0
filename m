Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44591 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab3C1Xky (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 19:40:54 -0400
Message-ID: <1364514048.30598.12.camel@jlt4.sipsolutions.net> (sfid-20130329_004057_673281_F9A3D346)
Subject: Re: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 29 Mar 2013 00:40:48 +0100
In-Reply-To: <CAB=NE6Xzc2chfWDsAp5gt=HLCQ5rPY+2OY49_CNOsPwuqghy3Q@mail.gmail.com> (sfid-20130329_002431_636707_116584AA)
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
	 <1364509206.10397.69.camel@jlt4.sipsolutions.net>
	 <CAB=NE6Xzc2chfWDsAp5gt=HLCQ5rPY+2OY49_CNOsPwuqghy3Q@mail.gmail.com>
	 (sfid-20130329_002431_636707_116584AA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-03-28 at 16:23 -0700, Luis R. Rodriguez wrote:

> This requires a study of the different types of collateral evolutions
> we have. compat already addresses the ones we can implement without
> requiring changing the upstream drivers. I'm now starting to address
> -- what is upstream willing to do to help with backports. An example
> is the static inlines.
> 
> https://lkml.org/lkml/2013/3/28/187
> 
> If the above patch is accepted I'd then try to send upstream the
> netdev_attach_ops() one, and that would nuke that entire patch from
> compat-drivers.

Right, this is a goal in itself, but I don't think we'll get rid of all
patches. Consider things like the completely different API for multicast
lists, for example.

> > Since the filename doesn't matter all that much, an automated conversion
> > could just split the patch per file and store it in a filename obtained
> > as follows:
> >         drivers/net/usb/rndis_host.c
> > ->      drivers_net_usb_rndis_host.c
> >
> > Easy :-)
> 
> True. I welcome this change if it helps you.

It would help me quite a bit. I suppose I could actually send you
patches for this soon. OTOH, without addressing my wishlist item 1) I
probably won't update to a current compat-drivers base ... I heavily
patch admin-update.sh now.

> > path/to/syms-program Kconfig > local-symbol-list
> > sed -i 's/$/=/' local-symbol-list
> > grep -v -f local-symbol-list $KLIB_BUILD/.config | dotconf-to-kconf.py > Kconfig.kernel
> 
> Neat trick! This doesn't handle the mapping of depdendencies but
> certainly already makes good assumptions given that you *have* these
> things built.

Are you referring to the "select" issue Hauke pointed out? Or what other
handling of dependencies are you thinking of? This entire trick exists
to allow compat's Kconfig to know about the base kernel's Kconfig so the
user can select the drivers that are actually possible given the base
kernel. For example, if building for kernel without PCI, you wouldn't be
able to select PCI drivers, etc.

> It does not however take into consideration for example
> that a user may say -- let me build cfg80211 alone, build it, install
> it and now have their 802.11 driver also selected (if they didn't).

That ... no I don't think you can do that. Nor do I think you even want
to? You can't build cfg80211 from one compat and the driver from
another, they won't be compatible anyway. So building cfg80211 first and
then installing it would be useless unless they build their driver from
the same tree later, but then it doesn't really matter that they still
have to select cfg80211? Or maybe I'm misunderstanding?

> I actually like the simplicity of it in Python and prefer it if we can
> live with it, but given that we follow the kernel build system I'd
> rather see the kernel first take the bullet on swallowing Python...
> not sure, anyway doesn't matter much if its simple.

It won't be more difficult even in bash, I'm just faster at writing it
in python :-)

> > This is about as far as I got with the implementation. There are a few
> > issues left.
> 
> Like Kconfig renames that went upstream and mapping them to their
> older name on the users's older kernels? This likely could be
> addressed by having these maps laid out for each kernel, but would
> require manual maintenance. It shouldn't be so hard if we do it
> *moving forward*.

Hmm, I never thought about that. Does that happen frequently? Do you
have any examples? Presumably, an example of this would be if you have
e.g. CONFIG_USB_DEVICES in an old kernel, but it's CONFIG_USB in the new
one, and all drivers that exist now have "depends on USB" while on an
old kernel USB won't exist, so you wouldn't be able to select such a
driver?

Anyway it seems like we must already maintain such a mapping in a way,
maybe a bit more implicitly? The way here you'd do it is add something
like this:

config USB
	bool
	default y
	depends on USB_DEVICES && COMPAT_KERNEL_2_3_4_5

or something like that?

> The other bigger thing I think is the dependency map output not
> existing so it'd let users break a build / existing dep.

I think it wouldn't break, worst case you wouldn't be able to select a
driver that you should be able to select?

> > 2) I have no idea how to go from a .config file to a working
> > Makefile/autoconf.h system.
> 
> Hm, we'd already have the Makefile for each target no? Are you trying
> to avoid having to ship each Makefile for each pulled driver?

Yes, we do have the makefiles of course, as copied from the kernel
sources. We want to keep them, obviously. I'm not trying to avoid that.
I'm saying I have no idea how to get the CONFIG_* or rather CPTCFG_*
symbols into make when it reads those makefiles.

> For autoconf we have our own thingy so far.

Yeah, but how do we get the symbols into make? That part isn't clear to
me at all, even for the regular kernel.

> > 4) This assumes KLIB_BUILD is configured externally, it's not possible
> > to configure that through menuconfig since the Kconfig tree needs to be
> > built first. I don't think this is a problem, but it looks like Luis
> > wanted to put that into Kconfig so I'm saying it won't really work.
> 
> I didn't want to put it into Kconfig actually, I was just throwing the
> variables on the menuconfig display to ensure the user building is
> aware of the sources of everything.

Ok :-)

Here's another issue I haven't really solved yet: All of compat must be
modules, so selecting Y for any symbol, e.g. CFG80211, must be
disallowed. This seems a little difficult, maybe the best choice would
be to simply hack menuconfig/... tool to disallow setting tristate
options to Y.

johannes

