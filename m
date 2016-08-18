Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754300AbcHSAyZ (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:25 -0400
Date: Thu, 18 Aug 2016 21:02:08 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
        kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
        vegard.nossum@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        backports@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] Add kconf_symb as kernel module attribute
Message-ID: <20160818190208.GL3296@wotan.suse.de> (sfid-20160819_033306_993609_82F12D7D)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-6-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471462023-119645-6-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 17, 2016 at 09:27:03PM +0200, Cristina Moraru wrote:
> Add kconf_symbol attribute to kernel struct module.

Nice, you can describe here what and how this can be
used by userspace, for instance you can mention how
udevadm might use this, etc.

> This patch is part of a research project within
> Google Summer of Code of porting 'make localmodconfig'
> for backported drivers. The goal is to enable each
> module to expose in /sys its corresponding CONFIG_* option.
> The value of this attribute will be dynamically pegged by
> modpost without requiring extra work from the driver developers.
> Further, this information will be used by a hardware interogation
> tool to extract build information about the existing devices.

You can leave this out.

> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> ---
>  include/linux/module.h | 1 +
>  kernel/module.c        | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 3daf2b3..bef5e44 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -353,6 +353,7 @@ struct module {
>  	struct module_attribute *modinfo_attrs;
>  	const char *version;
>  	const char *srcversion;
> +	const char *kconfig_symbol;
>  	struct kobject *holders_dir;
>  
>  	/* Exported symbols */
> diff --git a/kernel/module.c b/kernel/module.c
> index 5f71aa6..bb27300 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -757,6 +757,7 @@ static struct module_attribute modinfo_##field = {                    \
>  
>  MODINFO_ATTR(version);
>  MODINFO_ATTR(srcversion);
> +MODINFO_ATTR(kconfig_symbol);
>  
>  static char last_unloaded_module[MODULE_NAME_LEN+1];
>  
> @@ -1229,6 +1230,7 @@ static struct module_attribute *modinfo_attrs[] = {
>  	&module_uevent,
>  	&modinfo_version,
>  	&modinfo_srcversion,
> +	&modinfo_kconfig_symbol,
>  	&modinfo_initstate,
>  	&modinfo_coresize,
>  	&modinfo_initsize,
> -- 

Do we #ifdef over other features that are optional?

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
