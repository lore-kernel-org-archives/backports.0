Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:51082 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab3C3VsP (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 30 Mar 2013 17:48:15 -0400
Message-ID: <1364680091.8398.22.camel@jlt4.sipsolutions.net> (sfid-20130330_224818_432064_55CF5E5A)
Subject: Re: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Date: Sat, 30 Mar 2013 22:48:11 +0100
In-Reply-To: <CAB=NE6V7NPX=s62Apf_gYNRf0M+hY1bHTYwBsQTEECTPSW+SsQ@mail.gmail.com> (sfid-20130330_223528_834723_2103473A)
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
	 <1364509206.10397.69.camel@jlt4.sipsolutions.net>
	 <CAB=NE6Xzc2chfWDsAp5gt=HLCQ5rPY+2OY49_CNOsPwuqghy3Q@mail.gmail.com>
	 <1364514048.30598.12.camel@jlt4.sipsolutions.net>
	 <CAB=NE6X+d01yktZYaQwjUif0TyLPJi+HVMTgWArP+t7perzQ5Q@mail.gmail.com>
	 <1364668250.8398.14.camel@jlt4.sipsolutions.net>
	 <CAB=NE6V7NPX=s62Apf_gYNRf0M+hY1bHTYwBsQTEECTPSW+SsQ@mail.gmail.com>
	 (sfid-20130330_223528_834723_2103473A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-03-30 at 14:35 -0700, Luis R. Rodriguez wrote:

> See commit 8ae9673098 on compat, specifically the reference to Andi
> Kleen's module symbol namespace. This would have solved that issue but
> also allow, for example, iwlwifi to use say your stock mac80211 while
> perhaps ath9k does need the backported wireless. Some distributions
> have expressed interest in this as a feature (not specifically this
> example, just saying any driver). The usage of the updates/ directory
> would still enable us to let the backport driver supersede the older
> stock kernel one.
> 
> Right now we don't make cfg80211, mac80211 use a prefix for their own
> symbols but perhaps we should, that would address this. It would not
> incur cost on RAM given that you'd only load the old module if a
> device required it, and there is no extra storage cost given that
> you'd still install the backport drivers as we do today.
> 
> Thoughts?

Ok yes, this is still an interesting thing that we might consider doing.
I consider it orthogonal to my current work though.

Tackling this would be tricky though, you don't want to patch all the
different uses of a symbol, so you'd have to do something like module
symbol namespaces, and teach the build environment about it, or
something like that. Maybe it could be done with the linker's symbol
versioning.

Anyway -- this is interesting but not my (primary) goal right now.

> Actually I do, I believe randconfig is used to test builds by some
> folks, is how some obscure Kconfig bugs have been found, that is, a
> driver developer not testing building under certain Kconfig settings.

Yes, of course, this happens all the time, but it's just a bug.

> Asking users to build everything resolves this in part, and having
> users use menuconfig should then be something we have maintainers for
> those options. This lets users peg those maintainers on the bug
> reports found on those kconfig options. Thoughts?

Users can attach their backport .config file to the bug report, so this
should be fairly easy to identify in the bug. Also, this is really not
much different from getting a "build failed with these options" bug on
the kernel. It's different, of course, but many such issues would
probably replicate in the kernel as well.

> > config NEW_SYMBOL_NAME
> >         tristate
> >         default OLD_SYMBOL_NAME
> >
> > (or bool, and maybe with "depends on BACKPORT_KERNEL_X_Y_Z" added in)
> 
> Well I like the idea :D
> 
> It does mean manual work though and upon integration we'd discover
> this as a build failure, then we'd fix it.

Yes. We don't get to magically avoid porting work :-)

> > What I can automate is for drivers that are part of the backports
> > package. For *dependencies* those drivers have, like my hypothetical USB
> > example, we'll have to maintain it manually. It shouldn't be too
> > difficult though.
> 
> OK. I think this could be automated if we could script the question:
> 
> What dependencies did this module have in the original kernel? depmod
> to the rescue.
> 
> /lib/modules/$(uname -r)/modules.dep
> 
> But that does the inverse, module to symbol lookup (BTW lets be clear
> on language, symbol: export symbol, config: CONFIG_ poo), we need
> something to query the dependencies based on a given CONFIG_ and I
> believe we can get this, just gotta write it up. This can be done
> later though for sure :)

Yeah, agree, later.

> >> Ah yes. Can't we assume a direct mapping CONFIG_FOO --> CPTCFG_FOO ?
> >
> > Yes, we can mostly do that, and get rid of all the patches that modify
> > symbols.
> 
> :D
> 
> perl -pi -e 's|CONFIG_|CONFIG_BACKPORT_|g' some/Makefile
[...]
> Maybe we need to script this to not do the mangle for config options
> that are not present and assigned on the existing config.mk or .config
> (not sure what these map to exactly on your tree yet).

Yes. I did pretty much exactly that. There's no config.mk, I only have
a .config file and that's generated at build time via the kconfig
mechanism.

> > Yeah ... I think the makefile just has to include the .config,
> 
> I reached the same conclusion I just never saw it being done, but I
> also noticed I had to actually call export on these too.

include .config
export

works for me. Just "export" means export all.

johannes

