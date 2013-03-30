Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:46942 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3C3Vf2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 30 Mar 2013 17:35:28 -0400
Received: by mail-la0-f51.google.com with SMTP id fo13so1282361lab.10
        for <backports@vger.kernel.org>; Sat, 30 Mar 2013 14:35:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364668250.8398.14.camel@jlt4.sipsolutions.net>
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
 <1364509206.10397.69.camel@jlt4.sipsolutions.net> <CAB=NE6Xzc2chfWDsAp5gt=HLCQ5rPY+2OY49_CNOsPwuqghy3Q@mail.gmail.com>
 <1364514048.30598.12.camel@jlt4.sipsolutions.net> <CAB=NE6X+d01yktZYaQwjUif0TyLPJi+HVMTgWArP+t7perzQ5Q@mail.gmail.com>
 <1364668250.8398.14.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Sat, 30 Mar 2013 14:35:06 -0700
Message-ID: <CAB=NE6V7NPX=s62Apf_gYNRf0M+hY1bHTYwBsQTEECTPSW+SsQ@mail.gmail.com> (sfid-20130330_223532_266802_65EB8F9F)
Subject: Re: compat-drivers wishlist
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Mar 30, 2013 at 11:30 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Thu, 2013-03-28 at 17:08 -0700, Luis R. Rodriguez wrote:
>
>> > Are you referring to the "select" issue Hauke pointed out? Or what other
>> > handling of dependencies are you thinking of? This entire trick exists
>> > to allow compat's Kconfig to know about the base kernel's Kconfig so the
>> > user can select the drivers that are actually possible given the base
>> > kernel. For example, if building for kernel without PCI, you wouldn't be
>> > able to select PCI drivers, etc.
>>
>> No I'm concerned about the dependency within compat-drivers itself on
>> allowing users to build an updated driver that breaks existing stock
>> drivers that they didn't enable on compat-drivers. One example: say a
>> user decides to build ath9k, but also has a USB dongle and ath9k_htc
>> but does not build the ath9k_htc module, only ath9k. Loading ath9k_htc
>> will fail after he installs that build.
>
> Yes. That's unfortunate, but I don't really think we should _force_
> users to enable ath9k_htc? And we can't know what kind of USB devices
> they're going to plug in, so even "make localmodconfig" won't help all
> that much. We could default to all the drivers that the user has
> _installed_, but that'd mean maintaining a Kconfig <-> module mapping
> (though maybe the localmodconfig script has that?) and it wouldn't be
> what many users want? Why build USB drivers just because your distro did
> if you don't own the device, after all...
>
> IOW, I'm not sure what we can do about this.

See commit 8ae9673098 on compat, specifically the reference to Andi
Kleen's module symbol namespace. This would have solved that issue but
also allow, for example, iwlwifi to use say your stock mac80211 while
perhaps ath9k does need the backported wireless. Some distributions
have expressed interest in this as a feature (not specifically this
example, just saying any driver). The usage of the updates/ directory
would still enable us to let the backport driver supersede the older
stock kernel one.

Right now we don't make cfg80211, mac80211 use a prefix for their own
symbols but perhaps we should, that would address this. It would not
incur cost on RAM given that you'd only load the old module if a
device required it, and there is no extra storage cost given that
you'd still install the backport drivers as we do today.

Thoughts?

>> No its fine, its a general build dependency issue but that issue
>> exists today, we just don't allow for huge different set of
>> configurations. We allow:
>>
>>   * build everything
>>   * driver-select
>>
>> And these are tested (or at least the ones I maintain are).
>>
>> Kconfig opens the door for users doing complex configurations and
>> these could end up being reported as "issues", flooding the lists, and
>> time on people.
>
> I'm not all that worried about that, to be honest. We should probably
> default to running something like "allmodconfig", just like we do now.
> Also, the kernel's configuration is much more complex and did you see
> people complain there? :-)

Actually I do, I believe randconfig is used to test builds by some
folks, is how some obscure Kconfig bugs have been found, that is, a
driver developer not testing building under certain Kconfig settings.

Asking users to build everything resolves this in part, and having
users use menuconfig should then be something we have maintainers for
those options. This lets users peg those maintainers on the bug
reports found on those kconfig options. Thoughts?

> In addition, we get the advantage that then people are unable to make
> things that don't build. I for one have in fact gotten plenty of bug
> reports because of wrong or missing ifdefs in config.mk (granted,
> through my own fault) -- e.g. config.mk enabling debugfs when the base
> kernel didn't allow for it, etc. So many issues are also solved by this.

That's indeed awesome, I can't wait!

>> >> Like Kconfig renames that went upstream and mapping them to their
>> >> older name on the users's older kernels? This likely could be
>> >> addressed by having these maps laid out for each kernel, but would
>> >> require manual maintenance. It shouldn't be so hard if we do it
>> >> *moving forward*.
>> >
>> > Hmm, I never thought about that. Does that happen frequently?
>>
>> Not *that* frequently but handling that is a fucking bitch. At times I
>> wish the maintainer would send me a patch but so far only the
>> contributors to compat have addressed that.
>>
>> This is not a 'collateral evolution' per se, but certainly something
>> to consider if we can extract logic from git to address it for us.
>
> I don't really see what we could extract from git. The way I see it, the
> only way to really address it is to add this to compat/Kconfig:
>
> config NEW_SYMBOL_NAME
>         tristate
>         default OLD_SYMBOL_NAME
>
> (or bool, and maybe with "depends on BACKPORT_KERNEL_X_Y_Z" added in)

Well I like the idea :D

It does mean manual work though and upon integration we'd discover
this as a build failure, then we'd fix it.

>> > Do you
>> > have any examples? Presumably, an example of this would be if you have
>> > e.g. CONFIG_USB_DEVICES in an old kernel, but it's CONFIG_USB in the new
>> > one, and all drivers that exist now have "depends on USB" while on an
>> > old kernel USB won't exist, so you wouldn't be able to select such a
>> > driver?
>>
>> Typically its not core stuff. Its all driver poo. At times its simply
>> renames from upstream to downstream mapping issues. compat-drivers
>> examples:
>>
>> c5cfdf2d138ba20a648990d9615c44942eef5fd3
>
> Heh, beating me with my own driver, always a good plan :-)
>
> However this is entirely within the backports package so it's not an
> issue at all?

Sure, in this case, yes.

>> 8c8113109f6916c4926413aa3416cefffaa5d9b8
>
> Ditto here. In fact both of these patches just go away with my Kconfig
> scheme since I prefix CPTCFG_ instead of CONFIG_ and thus kernel symbols
> aren't used any more by the Makefile etc. stuff in backports.

OK neat.

>> > config USB
>> >         bool
>> >         default y
>> >         depends on USB_DEVICES && COMPAT_KERNEL_2_3_4_5
>> >
>> > or something like that?
>
> Heh, almost the same I wrote above...
>
>> Sure. I think you're trying to automate this though?
>
> But no, I don't think I can automate this part.
>
> What I can automate is for drivers that are part of the backports
> package. For *dependencies* those drivers have, like my hypothetical USB
> example, we'll have to maintain it manually. It shouldn't be too
> difficult though.

OK. I think this could be automated if we could script the question:

What dependencies did this module have in the original kernel? depmod
to the rescue.

/lib/modules/$(uname -r)/modules.dep

But that does the inverse, module to symbol lookup (BTW lets be clear
on language, symbol: export symbol, config: CONFIG_ poo), we need
something to query the dependencies based on a given CONFIG_ and I
believe we can get this, just gotta write it up. This can be done
later though for sure :)

>> BTW I'm trying to move things to BACKPORT_ prefix for poo given that
>> the kernel does use compat_ already for some poo. Not a big issue,
>> whatever.
>
> Good plan. I'll make the COMPAT_KERNEL_X_Y_Z symbols
> BACKPORT_KERNEL_X_Y_Z instead, and also the other symbols with COMPAT in
> the name. For the automatic ones I picked CPTCFG_ which is hopefully
> unique enough and has the advantage of having the same length as CONFIG_
> (which is selfish of me, but it helps me maintain the code since we work
> inside a backport package much of the time)

Sure, thanks!

>> >> > 2) I have no idea how to go from a .config file to a working
>> >> > Makefile/autoconf.h system.
>> >>
>> >> Hm, we'd already have the Makefile for each target no? Are you trying
>> >> to avoid having to ship each Makefile for each pulled driver?
>> >
>> > Yes, we do have the makefiles of course, as copied from the kernel
>> > sources. We want to keep them, obviously. I'm not trying to avoid that.
>> > I'm saying I have no idea how to get the CONFIG_* or rather CPTCFG_*
>> > symbols into make when it reads those makefiles.
>>
>> Ah yes. Can't we assume a direct mapping CONFIG_FOO --> CPTCFG_FOO ?
>
> Yes, we can mostly do that, and get rid of all the patches that modify
> symbols.

:D

perl -pi -e 's|CONFIG_|CONFIG_BACKPORT_|g' some/Makefile

But this would also end up renaming dependencies the Makefile might
have on stuff not provided by compat, an example:

ifeq ($(CONFIG_COMPAT),y)
  videodev-objs += v4l2-compat-ioctl32.o
endif

Would end up:

ifeq ($(CONFIG_BACKPORT_COMPAT),y)
  videodev-objs += v4l2-compat-ioctl32.o
endif

Maybe we need to script this to not do the mangle for config options
that are not present and assigned on the existing config.mk or .config
(not sure what these map to exactly on your tree yet).

>> >> For autoconf we have our own thingy so far.
>> >
>> > Yeah, but how do we get the symbols into make? That part isn't clear to
>> > me at all, even for the regular kernel.
>>
>> Yeah, never figured that poo out myself... The Makefile somehow has to
>> end up parsing the .config as a Makefile for variables, how that's
>> done no sure. For compat-drivers we just used assignments on
>> config.mk.
>
> Yeah ... I think the makefile just has to include the .config,

I reached the same conclusion I just never saw it being done, but I
also noticed I had to actually call export on these too.

> I'll have
> to check it out. Shouldn't be too difficult. I think the difficulty with
> the backport system is that it has to call the kernel's Makefile, and
> has to export everything for that ... anyway I'll figure out something,
> can't be too hard.

OK cool.

>> > Here's another issue I haven't really solved yet: All of compat must be
>> > modules, so selecting Y for any symbol, e.g. CFG80211, must be
>> > disallowed. This seems a little difficult, maybe the best choice would
>> > be to simply hack menuconfig/... tool to disallow setting tristate
>> > options to Y.
>>
>> If that's 100% true, sure! But say you want to disable a feature, or
>> enable a new one you didn't have ?
>
> Well everything inside backports that's allowed to be tristate in the
> kernel, must be N or M in backports, selecting Y for a tristate (module)
> doesn't make sense. I'm already doing this now.

Ah tristate, yeah that make sense and would be a good idea to help avoid issues.

 Luis
