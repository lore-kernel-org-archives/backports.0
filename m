Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:45540 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab3C2AJI (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 20:09:08 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so130566lab.38
        for <backports@vger.kernel.org>; Thu, 28 Mar 2013 17:09:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364514048.30598.12.camel@jlt4.sipsolutions.net>
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
 <1364509206.10397.69.camel@jlt4.sipsolutions.net> <CAB=NE6Xzc2chfWDsAp5gt=HLCQ5rPY+2OY49_CNOsPwuqghy3Q@mail.gmail.com>
 <1364514048.30598.12.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 28 Mar 2013 17:08:46 -0700
Message-ID: <CAB=NE6X+d01yktZYaQwjUif0TyLPJi+HVMTgWArP+t7perzQ5Q@mail.gmail.com> (sfid-20130329_010911_948233_4F057201)
Subject: Re: compat-drivers wishlist
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 4:40 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Thu, 2013-03-28 at 16:23 -0700, Luis R. Rodriguez wrote:
>
>> This requires a study of the different types of collateral evolutions
>> we have. compat already addresses the ones we can implement without
>> requiring changing the upstream drivers. I'm now starting to address
>> -- what is upstream willing to do to help with backports. An example
>> is the static inlines.
>>
>> https://lkml.org/lkml/2013/3/28/187
>>
>> If the above patch is accepted I'd then try to send upstream the
>> netdev_attach_ops() one, and that would nuke that entire patch from
>> compat-drivers.
>
> Right, this is a goal in itself, but I don't think we'll get rid of all
> patches. Consider things like the completely different API for multicast
> lists, for example.

I am willing to accept perhaps some changes may not be possible and we
may need to live with patches but.. if we do at the very least we can
use SmPL grammar to express it. Whether or not we can express this in
SmPL that's a separate question but to help with that question we need
to start categorizing these types of collateral evolutions.

Julia in case you are interested in exploring the one Johannes
mentioned you can see commit 6dc94f7b9 on compat-drivers or just look
at the file:

patches/collateral-evolutions/network/25-multicast-list_head.patch

>> > Since the filename doesn't matter all that much, an automated conversion
>> > could just split the patch per file and store it in a filename obtained
>> > as follows:
>> >         drivers/net/usb/rndis_host.c
>> > ->      drivers_net_usb_rndis_host.c
>> >
>> > Easy :-)
>>
>> True. I welcome this change if it helps you.
>
> It would help me quite a bit. I suppose I could actually send you
> patches for this soon. OTOH, without addressing my wishlist item 1) I
> probably won't update to a current compat-drivers base ... I heavily
> patch admin-update.sh now.

OK.

>> > path/to/syms-program Kconfig > local-symbol-list
>> > sed -i 's/$/=/' local-symbol-list
>> > grep -v -f local-symbol-list $KLIB_BUILD/.config | dotconf-to-kconf.py > Kconfig.kernel
>>
>> Neat trick! This doesn't handle the mapping of depdendencies but
>> certainly already makes good assumptions given that you *have* these
>> things built.
>
> Are you referring to the "select" issue Hauke pointed out? Or what other
> handling of dependencies are you thinking of? This entire trick exists
> to allow compat's Kconfig to know about the base kernel's Kconfig so the
> user can select the drivers that are actually possible given the base
> kernel. For example, if building for kernel without PCI, you wouldn't be
> able to select PCI drivers, etc.

No I'm concerned about the dependency within compat-drivers itself on
allowing users to build an updated driver that breaks existing stock
drivers that they didn't enable on compat-drivers. One example: say a
user decides to build ath9k, but also has a USB dongle and ath9k_htc
but does not build the ath9k_htc module, only ath9k. Loading ath9k_htc
will fail after he installs that build.

>> It does not however take into consideration for example
>> that a user may say -- let me build cfg80211 alone, build it, install
>> it and now have their 802.11 driver also selected (if they didn't).
>
> That ... no I don't think you can do that. Nor do I think you even want
> to? You can't build cfg80211 from one compat and the driver from
> another, they won't be compatible anyway.

Well of course, I'm just saying -- it'd be possible to do this. But I
guess this is possible to day anyway :)

> So building cfg80211 first and
> then installing it would be useless unless they build their driver from
> the same tree later, but then it doesn't really matter that they still
> have to select cfg80211? Or maybe I'm misunderstanding?

No its fine, its a general build dependency issue but that issue
exists today, we just don't allow for huge different set of
configurations. We allow:

  * build everything
  * driver-select

And these are tested (or at least the ones I maintain are).

Kconfig opens the door for users doing complex configurations and
these could end up being reported as "issues", flooding the lists, and
time on people.

>> I actually like the simplicity of it in Python and prefer it if we can
>> live with it, but given that we follow the kernel build system I'd
>> rather see the kernel first take the bullet on swallowing Python...
>> not sure, anyway doesn't matter much if its simple.
>
> It won't be more difficult even in bash, I'm just faster at writing it
> in python :-)

OK ;)

>> > This is about as far as I got with the implementation. There are a few
>> > issues left.
>>
>> Like Kconfig renames that went upstream and mapping them to their
>> older name on the users's older kernels? This likely could be
>> addressed by having these maps laid out for each kernel, but would
>> require manual maintenance. It shouldn't be so hard if we do it
>> *moving forward*.
>
> Hmm, I never thought about that. Does that happen frequently?

Not *that* frequently but handling that is a fucking bitch. At times I
wish the maintainer would send me a patch but so far only the
contributors to compat have addressed that.

This is not a 'collateral evolution' per se, but certainly something
to consider if we can extract logic from git to address it for us.

> Do you
> have any examples? Presumably, an example of this would be if you have
> e.g. CONFIG_USB_DEVICES in an old kernel, but it's CONFIG_USB in the new
> one, and all drivers that exist now have "depends on USB" while on an
> old kernel USB won't exist, so you wouldn't be able to select such a
> driver?

Typically its not core stuff. Its all driver poo. At times its simply
renames from upstream to downstream mapping issues. compat-drivers
examples:

c5cfdf2d138ba20a648990d9615c44942eef5fd3
8c8113109f6916c4926413aa3416cefffaa5d9b8

> Anyway it seems like we must already maintain such a mapping in a way,
> maybe a bit more implicitly? The way here you'd do it is add something
> like this:
>
> config USB
>         bool
>         default y
>         depends on USB_DEVICES && COMPAT_KERNEL_2_3_4_5
>
> or something like that?

Sure. I think you're trying to automate this though?

BTW I'm trying to move things to BACKPORT_ prefix for poo given that
the kernel does use compat_ already for some poo. Not a big issue,
whatever.

>> The other bigger thing I think is the dependency map output not
>> existing so it'd let users break a build / existing dep.
>
> I think it wouldn't break, worst case you wouldn't be able to select a
> driver that you should be able to select?

Yes perhaps, its wroth for us to try it, likely better than the
current unscalable situation.

>> > 2) I have no idea how to go from a .config file to a working
>> > Makefile/autoconf.h system.
>>
>> Hm, we'd already have the Makefile for each target no? Are you trying
>> to avoid having to ship each Makefile for each pulled driver?
>
> Yes, we do have the makefiles of course, as copied from the kernel
> sources. We want to keep them, obviously. I'm not trying to avoid that.
> I'm saying I have no idea how to get the CONFIG_* or rather CPTCFG_*
> symbols into make when it reads those makefiles.

Ah yes. Can't we assume a direct mapping CONFIG_FOO --> CPTCFG_FOO ?

>> For autoconf we have our own thingy so far.
>
> Yeah, but how do we get the symbols into make? That part isn't clear to
> me at all, even for the regular kernel.

Yeah, never figured that poo out myself... The Makefile somehow has to
end up parsing the .config as a Makefile for variables, how that's
done no sure. For compat-drivers we just used assignments on
config.mk.

>> > 4) This assumes KLIB_BUILD is configured externally, it's not possible
>> > to configure that through menuconfig since the Kconfig tree needs to be
>> > built first. I don't think this is a problem, but it looks like Luis
>> > wanted to put that into Kconfig so I'm saying it won't really work.
>>
>> I didn't want to put it into Kconfig actually, I was just throwing the
>> variables on the menuconfig display to ensure the user building is
>> aware of the sources of everything.
>
> Ok :-)
>
> Here's another issue I haven't really solved yet: All of compat must be
> modules, so selecting Y for any symbol, e.g. CFG80211, must be
> disallowed. This seems a little difficult, maybe the best choice would
> be to simply hack menuconfig/... tool to disallow setting tristate
> options to Y.

If that's 100% true, sure! But say you want to disable a feature, or
enable a new one you didn't have ?

  Luis
