Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44398 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab3C1WUO (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 18:20:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ULLB4-0001cz-OI
	for backports@vger.kernel.org; Thu, 28 Mar 2013 23:20:11 +0100
Message-ID: <1364509206.10397.69.camel@jlt4.sipsolutions.net> (sfid-20130328_232017_460041_62851092)
Subject: Re: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Thu, 28 Mar 2013 23:20:06 +0100
In-Reply-To: <1364507345.10397.42.camel@jlt4.sipsolutions.net> (sfid-20130328_224915_104660_21BB9723)
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
	 (sfid-20130328_224915_104660_21BB9723)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> 1) Ability to copy only some drivers.
> 2) To make that easier: split all patches per *file* in addition to per change.

You could think that an alternative to these would be for me to
post-process the sources and remove everything I don't care about.
However, that gets tricky because my compat package is created from my
own tree, and there the patches don't always apply. Therefore these
wishes.

I think for 2), I'd propose the following structure:

patches/collateral-evolutions/network/0001-netdev_ops/
	-> INFO
	-> rndis.patch
	-> usbnet.patch
	-> ath6kl.patch

Since the filename doesn't matter all that much, an automated conversion
could just split the patch per file and store it in a filename obtained
as follows:
	drivers/net/usb/rndis_host.c
->	drivers_net_usb_rndis_host.c

Easy :-)

The script to apply them gets a little more difficult, but I think we
should start using python for the tree-creation-time scripting which
will make this easy enough. Just walk the tree, etc.

> 3) Separate the output from the compat-drivers tree.

Should be easy, though it probably requires rewriting admin-update.
OTOH, admin-refresh etc. all pretty much goes away since you can just rm
-rf the output directory.

> 4) Kconfig.

So my wishes 1-3 apply at "tree creation" time, which is when the compat
source tree (and later tarball) is created and patched for the
backports. I've already suggested to rewrite that scripting in python,
and I'm willing to invest time in that if it stands a chance of getting
accepted :-)

This one is a bit more difficult. On the one hand we need to have all
the symbols from the kernel, but we don't want to leak them into the
compat namespace. Right now, for example, we do things like renaming
CONFIG_USB_NET_RNDIS_HOST to CONFIG_USB_NET_COMPAT_RNDIS_HOST which we
really should do for everything -- we get into trouble occasionally
because somebody enables something in the base kernel and then tries to
disable it in compat, which doesn't work.

I've been thinking a while about this, and I think I pretty much found a
solution.

First of all, it's easy to write a small Kconfig program (using the
existing Kconfig C code of course) that generates a list of all symbols
present in a given Kconfig tree, even disabled ones. Here's the program,
you just have to link it with zconf.tab.c and pass a root Kconfig file
as the only command line argument:
http://p.sipsolutions.net/3300bc91340ae747.txt

Equipped with a list of config symbols, we can go through the sources
and Makefiles and replace CONFIG_* with (e.g.) CPTCFG_* (and also
CONFIG_*_MODULE). We can't just replace CONFIG_ with CPTCFG_ because
then we get kernel symbols wrong. We could rename all CONFIG_ to CPTCFG_
and import the kernel symbols, which we have to do for Kconfig anyway,
but I feel that doing that would make things more brittle. (*)

Now obviously if we have a local Kconfig tree, it's pretty useless. The
reason is that we'll have things like

config MYDRIVER_PCI
	tristate "my good PCI driver"
	depends on PCI && HAS_IOMEM
config MYDRIVER_USB
	tristate "my good USB driver"
	depends on USB

or something like that, and the Kconfig tree we have clearly doesn't
know about PCI, HAS_IOMEM or USB. We'll have to teach it, which is
surprisingly easy:

path/to/syms-program Kconfig > local-symbol-list
sed -i 's/$/=/' local-symbol-list
grep -v -f local-symbol-list $KLIB_BUILD/.config | dotconf-to-kconf.py > Kconfig.kernel

dotconf-to-kconf.py is this little tool: http://p.sipsolutions.net/986bfbd397ad51c5.txt
(Clearly it has to be rewritten in a different language since this has
to run at build time, not just at tarball creation time, but that's easy
to do)

Now we can "source Kconfig.kernel" into our local Kconfig tree, and the
"depends on USB" can magically work the right way. For the symbol walk
(syms program above) we'll have to include an empty file, but that's not
terribly difficult either.

Oh, whenever we execute menuconfig/oldconfig/... we set the environment
variable CONFIG_ to CPTCFG_ -- this will make the tool output CPTCFG_
instead of CONFIG_ as the prefix for all the output variables.

This is about as far as I got with the implementation. There are a few
issues left. 

1) All of the kernel symbols like USB get put into the .config file,
e.g. CPTCFG_USB. This doesn't actually matter all that much because
they're prefixed CPTCFG_ and the code we compile still looks for CONFIG_
for the kernel symbols -- remember that we only renamed the ones we
found in our local Kconfig tree.

2) I have no idea how to go from a .config file to a working
Makefile/autoconf.h system.

3) If KLIB_BUILD dir or the kernel config changes, this has to be
regenerated and oldconfig must be run. For instance, if USB was now
disabled in the base kernel then we shouldn't attempt to build USB
drivers, etc. This is a bit tricky because we also don't want to redo
everything for each "make". I'm not sure how much we care about this,
but we can probably solve it by storing a checksum of
$KLIB_BUILD/.config and doing the preparation steps only if that
changes, or so.

4) This assumes KLIB_BUILD is configured externally, it's not possible
to configure that through menuconfig since the Kconfig tree needs to be
built first. I don't think this is a problem, but it looks like Luis
wanted to put that into Kconfig so I'm saying it won't really work.

Thoughts?

johannes

(*) post-scriptum: this can and should actually happen at tree creation
time, not at build time

