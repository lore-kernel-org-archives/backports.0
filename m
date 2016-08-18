Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47194 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbcHRTno (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 18 Aug 2016 15:43:44 -0400
Date: Thu, 18 Aug 2016 20:30:28 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
	kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
	Fengguang Wu <fengguang.wu@intel.com>,
	backports@vger.kernel.org,
	"vegard.nossum@gmail.com" <vegard.nossum@gmail.com>
Subject: Re: [RFC PATCH 3/5] Trigger Module.ksymb generation in Makefile
Message-ID: <20160818183028.GQ3296@wotan.suse.de> (sfid-20160818_214347_601949_99EC3C56)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-4-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471462023-119645-4-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 17, 2016 at 09:27:01PM +0200, Cristina Moraru wrote:
> Trigger the generation of file scripts/Module.ksymb in
> Makefile by calling updated scripts/streamline_config.pl
> with corresponding parameter (--genmodulesymb). The file
> is generated at each compilation considering that
> associations may change after tree updates.

I really like this approach as you make the resolver
configurable, this lets others experiment and consider
alternatives.

make KSYMB_GENERATOR=/path/research/my-config-generator-is-better

The fact that you can do this should be documented as part of
the patch commit log.

You'll want to wrap this generation under a CONFIG option so only
kernels that want generate this file.

> This patch is part of a research project within
> Google Summer of Code of porting 'make localmodconfig'
> for backported drivers. The goal is to enable each
> module to expose in /sys its corresponding CONFIG_* option.
> The value of this attribute will be dynamically pegged by
> modpost without requiring extra work from the driver developers.
> Further, this information will be used by a hardware interogation
> tool to extract build information about the existing devices.

You can leave this out.

> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 393b615..286b949 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -219,6 +219,10 @@ VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
>  
>  export srctree objtree VPATH
>  
> +KSYMB_GENERATOR := $(objtree)/scripts/kconfig/streamline_config.pl
> +ksymb_gen_command = perl $(KSYMB_GENERATOR) --genmoduleksymb $(objtree) $(Kconfig)

$(PERL)

> +ksymb_update := $(shell objtree=$(objtree) srctree=$(srctree) $(ksymb_gen_command))
> +
>  # SUBARCH tells the usermode build what the underlying arch is.  That is set
>  # first, and if a usermode build is happening, the "ARCH=um" on the command
>  # line overrides the setting of ARCH below.  If a native build is happening,
> -- 
> 2.7.4

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
