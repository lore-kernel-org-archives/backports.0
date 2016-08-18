Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58481 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754301AbcHSAyZ (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:25 -0400
Date: Thu, 18 Aug 2016 20:10:07 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
        kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
        backports@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] Add CONFIG symbol to module as compilation
 parameter
Message-ID: <20160818181007.GN3296@wotan.suse.de> (sfid-20160819_033826_974487_04B65C73)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-3-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471462023-119645-3-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 17, 2016 at 09:27:00PM +0200, Cristina Moraru wrote:
> Add  CONFIG symbol to kernel modules as a define via -D

Perhaps better worded as:

When modules have a direct Kconfig CONFIG_ symbol associated with
we want to be able to make it available to the build system when we
are building the module.

You can then describe you do this with -D.

> compilation parameter. The CONFIG_FOO symbol for each
> module is determined by the module name, using the
> associations from Module.ksymb. This file is loaded
> using the 'include' directive, thus run like a regular
> makefile. The format of the content of the file is the
> following:
> 
> foo_KCONF=CONFIG_FOO
> 
> creating a set of Makefile variables foo_KCONF with the
> CONFIG_FOO as values.
> 
> The Makefile then adds this value in the compilation
> command with -DKBUILD_KCONF='"CONFIG_FOO"'.

Very nice. What would it mean if it lacks this ?
This should be explained on the commit log.

> This patch is part of a research project within
> Google Summer of Code of porting 'make localmodconfig'
> for backported drivers. The goal is to enable each
> module to expose in /sys its corresponding CONFIG_* option.
> The value of this attribute will be dynamically pegged by
> modpost without requiring extra work from the driver developers.
> Further, this information will be used by a hardware interogation
> tool to extract build information about the existing devices.

You can leave this out as its part of the cover letter and
not relevant to the patch. You can however mention you will
use this later to make the define more useful in userspace.

> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> ---
>  scripts/Makefile.lib | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index e7df0f5..8ae9b7f 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -89,6 +89,10 @@ multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
>  subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))
>  obj-dirs	:= $(addprefix $(obj)/,$(obj-dirs))
>  
> +# Include Module.ksymb which contains the associations of modules' names
> +# and corresponding CONFIG_* options
> +include Module.ksymb

Is this file always generated? If not prefixing the include call with - would
be better. If we are going to make this optional, then an ifdef wrapper would
suffice as we know it'd be expected only if the new feature was enabled.

> +
>  # These flags are needed for modversions and compiling, so we define them here
>  # already
>  # $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will
> @@ -100,6 +104,9 @@ name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
>  basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
>  modname_flags  = $(if $(filter 1,$(words $(modname))),\
>                   -DKBUILD_MODNAME=$(call name-fix,$(modname)))
> +ksym-fix = $(squote)$(quote)$($(subst $(comma),_,$(subst -,_,$1))_KCONF)$(quote)$(squote)
> +ksymb_flags = $(if $(filter 1,$(words $(modname))),\
> +                 -DKBUILD_KSYMB=$(call ksym-fix, $(modname)))

Are clashes possible with this formula? Can we end up with two results for instance?
If not what prevents current konfig logic and namespace from a clash ? If we do
not have anything to prevent a clash, what can we do to help make such clash not
possible ?

>  orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(KBUILD_SUBDIR_CCFLAGS) \
>                   $(ccflags-y) $(CFLAGS_$(basetarget).o)
> @@ -162,7 +169,7 @@ endif
>  
>  c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
>  		 $(__c_flags) $(modkern_cflags)                           \
> -		 $(basename_flags) $(modname_flags)
> +		 $(basename_flags) $(modname_flags) $(ksymb_flags)
>  
>  a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
>  		 $(__a_flags) $(modkern_aflags)
> -- 

Other than that looks good!

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
