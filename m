Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753370AbcHWTYE (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 23 Aug 2016 15:24:04 -0400
Date: Tue, 23 Aug 2016 21:07:53 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>,
        Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        akpm@linux-foundation.org, backports@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] Add CONFIG symbol to module as compilation
 parameter
Message-ID: <20160823190753.GF3296@wotan.suse.de> (sfid-20160823_212408_084102_8354B6DB)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-3-git-send-email-cristina.moraru09@gmail.com>
 <20160818181007.GN3296@wotan.suse.de>
 <CAGZ2q2yt1NYshNpm5ZCmPXfYxPynttEU7KiiL3RALegGD04nug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGZ2q2yt1NYshNpm5ZCmPXfYxPynttEU7KiiL3RALegGD04nug@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Aug 20, 2016 at 05:11:37PM +0200, Cristina-Gabriela Moraru wrote:
> 2016-08-18 20:10 GMT+02:00 Luis R. Rodriguez <mcgrof@kernel.org>:
> > On Wed, Aug 17, 2016 at 09:27:00PM +0200, Cristina Moraru wrote:
> >> Add  CONFIG symbol to kernel modules as a define via -D
> >
> > Perhaps better worded as:
> >
> > When modules have a direct Kconfig CONFIG_ symbol associated with
> > we want to be able to make it available to the build system when we
> > are building the module.
> >
> > You can then describe you do this with -D.
> >
> >> compilation parameter. The CONFIG_FOO symbol for each
> >> module is determined by the module name, using the
> >> associations from Module.ksymb. This file is loaded
> >> using the 'include' directive, thus run like a regular
> >> makefile. The format of the content of the file is the
> >> following:
> >>
> >> foo_KCONF=CONFIG_FOO
> >>
> >> creating a set of Makefile variables foo_KCONF with the
> >> CONFIG_FOO as values.
> >>
> >> The Makefile then adds this value in the compilation
> >> command with -DKBUILD_KCONF='"CONFIG_FOO"'.
> >
> > Very nice. What would it mean if it lacks this ?
> > This should be explained on the commit log.
> >
> 
> If we lack it then KBUILD_KCONF="" and in /sys the module has the
> kconfig_symbol attribute but with the empty string as content:
> 
> prompt:/sys$ cat ./module/mptbase/kconfig_symbol
> 
> prompt:/sys$
> 
> I will add it into the commit log.

OK -- I do wonder if instead of an empty string leaving the kconfig_symbol
out is better. If its empty then it can be confusing, and so perhaps better
an "unknown" is better. But skipping the attribute then seems best as then
we can focus on just addressing what it *does mean* when we do have a mapping.
This would allow addressing the semantic gap of modules that lack this and
trying to fix those step by step. To fix those we first need to identify
*why* we can't get an attribute pegged to these - document this perhaps on
kernelnewbies.org/KernelProjects/<pick-a-topic-name-for-your-project>
and then your commit log can reference this for a list of known reasons
and pending work.

> >> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> >> index e7df0f5..8ae9b7f 100644
> >> --- a/scripts/Makefile.lib
> >> +++ b/scripts/Makefile.lib
> >> @@ -89,6 +89,10 @@ multi-objs-m       := $(addprefix $(obj)/,$(multi-objs-m))
> >>  subdir-ym    := $(addprefix $(obj)/,$(subdir-ym))
> >>  obj-dirs     := $(addprefix $(obj)/,$(obj-dirs))
> >>
> >> +# Include Module.ksymb which contains the associations of modules' names
> >> +# and corresponding CONFIG_* options
> >> +include Module.ksymb
> >
> > Is this file always generated? If not prefixing the include call with - would
> > be better. If we are going to make this optional, then an ifdef wrapper would
> > suffice as we know it'd be expected only if the new feature was enabled.
> 
> Yes. This file is always generated. In case a 'git pull' happened
> between two 'make' commands, the associations should be updated. Ok. I
> will add a ifdef.
> 
> >
> >> +
> >>  # These flags are needed for modversions and compiling, so we define them here
> >>  # already
> >>  # $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will
> >> @@ -100,6 +104,9 @@ name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
> >>  basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
> >>  modname_flags  = $(if $(filter 1,$(words $(modname))),\
> >>                   -DKBUILD_MODNAME=$(call name-fix,$(modname)))
> >> +ksym-fix = $(squote)$(quote)$($(subst $(comma),_,$(subst -,_,$1))_KCONF)$(quote)$(squote)
> >> +ksymb_flags = $(if $(filter 1,$(words $(modname))),\
> >> +                 -DKBUILD_KSYMB=$(call ksym-fix, $(modname)))
> >
> > Are clashes possible with this formula? Can we end up with two results for instance?
> > If not what prevents current konfig logic and namespace from a clash ? If we do
> > not have anything to prevent a clash, what can we do to help make such clash not
> > possible ?
> 
> I think the fact that modname is unique prevents from having clashes.
> KBUILD_KSYMB is found according to modname.
> Currently there is no clash because I enforced the Module.ksymb to
> have 1-to-1 mapping.
> The only potential clash I can imagine right now it having the same
> module name but architecture specific CONFIG_* symbol. If there is a
> 1-to-1 mapping in Module.ksymb there should be no clash in the
> makefile.

OK thanks.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
