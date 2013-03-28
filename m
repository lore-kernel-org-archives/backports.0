Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44504 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3C1W7f (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 18:59:35 -0400
Message-ID: <1364511560.10397.94.camel@jlt4.sipsolutions.net> (sfid-20130328_235937_082532_E9522B14)
Subject: Re: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Thu, 28 Mar 2013 23:59:20 +0100
In-Reply-To: <5154C6D8.3040603@hauke-m.de>
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
	  (sfid-20130328_224915_104660_21BB9723) <1364509206.10397.69.camel@jlt4.sipsolutions.net>
	 <5154C6D8.3040603@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-03-28 at 23:40 +0100, Hauke Mehrtens wrote:
> > Now we can "source Kconfig.kernel" into our local Kconfig tree, and the
> > "depends on USB" can magically work the right way. For the symbol walk
> > (syms program above) we'll have to include an empty file, but that's not
> > terribly difficult either.
> 
> We also have to change all the select SOME_KERNEL_OPTION into a depends
> SOME_KERNEL_OPTION, because the options of the used kernel can not be
> changed.

Huh, good point. I didn't think about that, and it probably doesn't even
exist? But yeah, I agree, we need to do this. It's not terribly
difficult though -- after we have a list of local symbols we can go
through and rewrite "select NONLOCAL" to "depends on NONLOCAL".

> compat should be changed in this way to not always backport any e.g. all
> USB stuff and depend on USB stuff if the USB subsystem was not
> activated. I think this should be modularized to have one *.ko for the
> USB stuff, one for the PCMCIA stuff and so on.
> Currently compat.ko depends on USB for some kernel versions.

I don't think compat backports USB/PCMCIA/...? I was under the
impression that it was necessary to be from the base kernel anyway, but
I don't really know. In theory I agree, anything that's backported in
compat needs to be included into the Kconfig somehow, particularly
things like this.

Actually, I guess we do have things like that now, just not USB/PCMCIA:

CONFIG_COMPAT_FIRMWARE_CLASS
CONFIG_COMPAT_NET_SCH_CODEL
CONFIG_COMPAT_NET_SCH_FQ_CODEL
CONFIG_COMPAT_KFIFO
CONFIG_COMPAT_CORDIC
CONFIG_COMPAT_CRC8

and something about CONFIG_GENERIC_ATOMIC64 on non-64 bit platforms.

This is interesting! It probably means we need to generate a Kconfig
file for the kernel versions as well, at build time:

config COMPAT_KERNEL_2_6_26
	def_bool y

Obviously then compat relies more on compat-drivers to actually build?
It could have its own Kconfig file, and probably best if the creation of
this Kconfig.compat file is done through a script there.

Anyway this is special. So we can treat it specially, and do something
like

config COMPAT_CORDIC
	bool
	default !CORDIC

which should work just fine since we imported the symbols from the base
kernel. We'll then get a CPTCFG_COMPAT_CORDIC symbol that we can use to
build (or not) the cordic code.

For something that depends on a specific kernel version it's just as
simple:

config COMPAT_FIRMWARE_CLASS
	tristate
	default m if COMPAT_KERNEL_2_6_33 && !COMPAT_RHEL_6_1

or so.

johannes

