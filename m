Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:46899 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab3C1XYM (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 19:24:12 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so96839lab.8
        for <backports@vger.kernel.org>; Thu, 28 Mar 2013 16:24:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364509206.10397.69.camel@jlt4.sipsolutions.net>
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net> <1364509206.10397.69.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 28 Mar 2013 16:23:49 -0700
Message-ID: <CAB=NE6Xzc2chfWDsAp5gt=HLCQ5rPY+2OY49_CNOsPwuqghy3Q@mail.gmail.com> (sfid-20130329_002417_815427_C4BB3F62)
Subject: Re: compat-drivers wishlist
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 3:20 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>> 1) Ability to copy only some drivers.
>> 2) To make that easier: split all patches per *file* in addition to per change.
>
> You could think that an alternative to these would be for me to
> post-process the sources and remove everything I don't care about.
> However, that gets tricky because my compat package is created from my
> own tree, and there the patches don't always apply. Therefore these
> wishes.
>
> I think for 2), I'd propose the following structure:
>
> patches/collateral-evolutions/network/0001-netdev_ops/
>         -> INFO
>         -> rndis.patch
>         -> usbnet.patch
>         -> ath6kl.patch

That's fine, and in fact with the other long term things I'm looking
at, such as SmPL to exrpress these collateral evolutions, is to
categorize the collateral evolutions into different types and see if
we can get *all* of them implemented in compat alone. That is, strive
to get rid of all patches required.

This requires a study of the different types of collateral evolutions
we have. compat already addresses the ones we can implement without
requiring changing the upstream drivers. I'm now starting to address
-- what is upstream willing to do to help with backports. An example
is the static inlines.

https://lkml.org/lkml/2013/3/28/187

If the above patch is accepted I'd then try to send upstream the
netdev_attach_ops() one, and that would nuke that entire patch from
compat-drivers.

> Since the filename doesn't matter all that much, an automated conversion
> could just split the patch per file and store it in a filename obtained
> as follows:
>         drivers/net/usb/rndis_host.c
> ->      drivers_net_usb_rndis_host.c
>
> Easy :-)

True. I welcome this change if it helps you.

> The script to apply them gets a little more difficult, but I think we
> should start using python for the tree-creation-time scripting which
> will make this easy enough. Just walk the tree, etc.

ACK.

>> 3) Separate the output from the compat-drivers tree.
>
> Should be easy, though it probably requires rewriting admin-update.
> OTOH, admin-refresh etc. all pretty much goes away since you can just rm
> -rf the output directory.
>
>> 4) Kconfig.
>
> So my wishes 1-3 apply at "tree creation" time, which is when the compat
> source tree (and later tarball) is created and patched for the
> backports. I've already suggested to rewrite that scripting in python,
> and I'm willing to invest time in that if it stands a chance of getting
> accepted :-)

I've long said bring it. I'm on the Python bandwagon now, my first
rewrite was ckmake.

> This one is a bit more difficult. On the one hand we need to have all
> the symbols from the kernel, but we don't want to leak them into the
> compat namespace. Right now, for example, we do things like renaming
> CONFIG_USB_NET_RNDIS_HOST to CONFIG_USB_NET_COMPAT_RNDIS_HOST which we
> really should do for everything -- we get into trouble occasionally
> because somebody enables something in the base kernel and then tries to
> disable it in compat, which doesn't work.

True.

> I've been thinking a while about this, and I think I pretty much found a
> solution.

Yay.

> First of all, it's easy to write a small Kconfig program (using the
> existing Kconfig C code of course) that generates a list of all symbols
> present in a given Kconfig tree, even disabled ones. Here's the program,
> you just have to link it with zconf.tab.c and pass a root Kconfig file
> as the only command line argument:
> http://p.sipsolutions.net/3300bc91340ae747.txt
>
> Equipped with a list of config symbols, we can go through the sources
> and Makefiles and replace CONFIG_* with (e.g.) CPTCFG_* (and also
> CONFIG_*_MODULE). We can't just replace CONFIG_ with CPTCFG_ because
> then we get kernel symbols wrong. We could rename all CONFIG_ to CPTCFG_
> and import the kernel symbols, which we have to do for Kconfig anyway,
> but I feel that doing that would make things more brittle. (*)
>
> Now obviously if we have a local Kconfig tree, it's pretty useless. The
> reason is that we'll have things like
>
> config MYDRIVER_PCI
>         tristate "my good PCI driver"
>         depends on PCI && HAS_IOMEM
> config MYDRIVER_USB
>         tristate "my good USB driver"
>         depends on USB
>
> or something like that, and the Kconfig tree we have clearly doesn't
> know about PCI, HAS_IOMEM or USB. We'll have to teach it, which is
> surprisingly easy:
>
> path/to/syms-program Kconfig > local-symbol-list
> sed -i 's/$/=/' local-symbol-list
> grep -v -f local-symbol-list $KLIB_BUILD/.config | dotconf-to-kconf.py > Kconfig.kernel

Neat trick! This doesn't handle the mapping of depdendencies but
certainly already makes good assumptions given that you *have* these
things built. It does not however take into consideration for example
that a user may say -- let me build cfg80211 alone, build it, install
it and now have their 802.11 driver also selected (if they didn't).

> dotconf-to-kconf.py is this little tool: http://p.sipsolutions.net/986bfbd397ad51c5.txt
> (Clearly it has to be rewritten in a different language since this has
> to run at build time, not just at tarball creation time, but that's easy
> to do)

I actually like the simplicity of it in Python and prefer it if we can
live with it, but given that we follow the kernel build system I'd
rather see the kernel first take the bullet on swallowing Python...
not sure, anyway doesn't matter much if its simple.

> Now we can "source Kconfig.kernel" into our local Kconfig tree, and the
> "depends on USB" can magically work the right way. For the symbol walk
> (syms program above) we'll have to include an empty file, but that's not
> terribly difficult either.
>
> Oh, whenever we execute menuconfig/oldconfig/... we set the environment
> variable CONFIG_ to CPTCFG_ -- this will make the tool output CPTCFG_
> instead of CONFIG_ as the prefix for all the output variables.
>
> This is about as far as I got with the implementation. There are a few
> issues left.

Like Kconfig renames that went upstream and mapping them to their
older name on the users's older kernels? This likely could be
addressed by having these maps laid out for each kernel, but would
require manual maintenance. It shouldn't be so hard if we do it
*moving forward*.

The other bigger thing I think is the dependency map output not
existing so it'd let users break a build / existing dep.

> 1) All of the kernel symbols like USB get put into the .config file,
> e.g. CPTCFG_USB. This doesn't actually matter all that much because
> they're prefixed CPTCFG_ and the code we compile still looks for CONFIG_
> for the kernel symbols -- remember that we only renamed the ones we
> found in our local Kconfig tree.
>
> 2) I have no idea how to go from a .config file to a working
> Makefile/autoconf.h system.

Hm, we'd already have the Makefile for each target no? Are you trying
to avoid having to ship each Makefile for each pulled driver?
For autoconf we have our own thingy so far.
Maybe I'm not getting what you mean here.

> 3) If KLIB_BUILD dir or the kernel config changes, this has to be
> regenerated and oldconfig must be run. For instance, if USB was now
> disabled in the base kernel then we shouldn't attempt to build USB
> drivers, etc. This is a bit tricky because we also don't want to redo
> everything for each "make". I'm not sure how much we care about this,
> but we can probably solve it by storing a checksum of
> $KLIB_BUILD/.config and doing the preparation steps only if that
> changes, or so.

Sure.

> 4) This assumes KLIB_BUILD is configured externally, it's not possible
> to configure that through menuconfig since the Kconfig tree needs to be
> built first. I don't think this is a problem, but it looks like Luis
> wanted to put that into Kconfig so I'm saying it won't really work.

I didn't want to put it into Kconfig actually, I was just throwing the
variables on the menuconfig display to ensure the user building is
aware of the sources of everything.

  Luis
