Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754249AbcHSAyS (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:18 -0400
Date: Thu, 18 Aug 2016 20:59:41 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
        kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
        Steven Rostedt <rostedt@goodmis.org>,
        backports@vger.kernel.org, vegard.nossum@gmail.com
Subject: Re: [RFC PATCH 4/5] Set KCONFIG_KSYMB as value for kconfig_ksymb
 module attribute
Message-ID: <20160818185941.GK3296@wotan.suse.de> (sfid-20160819_040342_440456_23B2B3BA)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-5-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471462023-119645-5-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 17, 2016 at 09:27:02PM +0200, Cristina Moraru wrote:
> Update modpost to add in *.mod.c files generated for each
> module the setting of module attribute kernel_ksymb to
> value given by KBUILD_KSYMB macro.

Please review your patches and update subjects to match what other
types of previous patches look like in terms of format, so
for this patch check changes to scripts/mod/modpost.c and use
similar type of patch prefix.

> 
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
>  scripts/mod/modpost.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 48958d3..a105916 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2245,6 +2245,12 @@ static void add_srcversion(struct buffer *b, struct module *mod)
>  	}
>  }
>  
> +static void add_kconfig_symbol(struct buffer *b, struct module *mod)
> +{
> +	buf_printf(b, "\n");
> +	buf_printf(b, "MODULE_INFO(kconfig_symbol, KBUILD_KSYMB);\n");

What if its not available? What happens?

> +}
> +
>  static void write_if_changed(struct buffer *b, const char *fname)
>  {
>  	char *tmp;
> @@ -2478,6 +2484,7 @@ int main(int argc, char **argv)
>  		add_depends(&buf, mod, modules);
>  		add_moddevtable(&buf, mod);
>  		add_srcversion(&buf, mod);
> +		add_kconfig_symbol(&buf, mod);
>  
>  		sprintf(fname, "%s.mod.c", mod->name);
>  		write_if_changed(&buf, fname);
> -- 
> 2.7.4
> 
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
--
To unsubscribe from this list: send the line "unsubscribe backports" in
