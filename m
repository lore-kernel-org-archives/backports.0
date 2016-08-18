Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58483 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754106AbcHSAy0 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:26 -0400
Date: Thu, 18 Aug 2016 20:55:29 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
        linux-kernel@vger.kernel.org, teg@jklm.no, kay@vrfy.org,
        rusty@rustcorp.com.au, akpm@linux-foundation.org,
        backports@vger.kernel.org,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/5] Add CONFIG symbol to module as compilation
 parameter
Message-ID: <20160818185529.GS3296@wotan.suse.de> (sfid-20160819_033832_399691_6A796379)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-3-git-send-email-cristina.moraru09@gmail.com>
 <20160818181007.GN3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818181007.GN3296@wotan.suse.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 18, 2016 at 08:10:07PM +0200, Luis R. Rodriguez wrote:
> On Wed, Aug 17, 2016 at 09:27:00PM +0200, Cristina Moraru wrote:
> 
> > Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> > ---
> >  scripts/Makefile.lib | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index e7df0f5..8ae9b7f 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -89,6 +89,10 @@ multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
> >  subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
> >  obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
> >  
> > +# Include Module.ksymb which contains the associations of modules' names
> > +# and corresponding CONFIG_* options
> > +include Module.ksymb
> 
> Is this file always generated? If not prefixing the include call with - would
> be better. If we are going to make this optional, then an ifdef wrapper would
> suffice as we know it'd be expected only if the new feature was enabled.

The ordering of the patches 2 and 3 seem to be backward, you should first
generate the file otherwise this patch will break the build as the file
is not present.

> > +
> >  # These flags are needed for modversions and compiling, so we define them here
> >  # already
> >  # $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will
> > @@ -100,6 +104,9 @@ name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
> >  basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
> >  modname_flags  = $(if $(filter 1,$(words $(modname))),\
> >                   -DKBUILD_MODNAME=$(call name-fix,$(modname)))
> > +ksym-fix = $(squote)$(quote)$($(subst $(comma),_,$(subst -,_,$1))_KCONF)$(quote)$(squote)
> > +ksymb_flags = $(if $(filter 1,$(words $(modname))),\
> > +                 -DKBUILD_KSYMB=$(call ksym-fix, $(modname)))
> 
> Are clashes possible with this formula? Can we end up with two results for instance?
> If not what prevents current konfig logic and namespace from a clash ? If we do
> not have anything to prevent a clash, what can we do to help make such clash not
> possible ?

To help test this I've added your patches to a development branch on my linux-next
tree to see if 0-day picks up any issues.

Guenter, to be even more thorough can I trouble you for a spin of this branch?

https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160818-gsoc-kconf_symb

Results should help give us an idea of troubling areas if this were to be added
as a new Kconfig feature even for R&D.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
