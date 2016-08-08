Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41640 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbcHHUF6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Aug 2016 16:05:58 -0400
Date: Mon, 8 Aug 2016 22:05:52 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
	Valentin Rothberg <valentinrothberg@gmail.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
	kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
	backports@vger.kernel.org, gregkh@linuxfoundation.org,
	mmarek@suse.com, mchehab@osg.samsung.com,
	rafael.j.wysocki@intel.com
Subject: Re: [RFC PATCH 3/3] Add dynamic pegging of Kconfig symbol
Message-ID: <20160808200552.GU3296@wotan.suse.de> (sfid-20160808_220601_087481_245AD5D3)
References: <1469979232-15531-1-git-send-email-cristina.moraru09@gmail.com>
 <1469979232-15531-4-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469979232-15531-4-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Jul 31, 2016 at 05:33:52PM +0200, Cristina Moraru wrote:
> Update modpost to add dynamic pegging of CONFIG_* symbol
> from file ./scripts/mod/Module.ksymb into kconfig_symbol
> attribute of struct module. This information will be
> further exposed in userspace for extracting build options
> for the required modules.
> 
> Note: this patch is part of a proof of concept and does
> not represent the final version.
> 
> This patch is part of a research project within
> Google Summer of Code of porting 'make localmodconfig'
> for backported drivers.
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> ---
>  scripts/mod/modpost.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  scripts/mod/modpost.h |  1 +
>  2 files changed, 48 insertions(+)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 48958d3..d80c062 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -42,6 +42,8 @@ static int sec_mismatch_fatal = 0;
>  /* ignore missing files */
>  static int ignore_missing_files;
>  
> +#define MOD_KSYMB_FILENAME "scripts/mod/Module.ksymb"
> +
>  enum export {
>  	export_plain,      export_unused,     export_gpl,
>  	export_unused_gpl, export_gpl_future, export_unknown
> @@ -2245,6 +2247,50 @@ static void add_srcversion(struct buffer *b, struct module *mod)
>  	}
>  }
>  
> +static void get_kconfig_symbol(struct module *mod) {
> +
> +	unsigned long size, pos = 0;
> +	void *file = grab_file(MOD_KSYMB_FILENAME, &size);
> +	char *line, *short_name;
> +
> +	if (!file)
> +		return;
> +
> +	short_name = strrchr(mod->name, '/');
> +	short_name++;
> +
> +	while ((line = get_next_line(&pos, file, size))) {
> +		char *modname, *kconfig_symbol, *p;
> +
> +		modname = line;
> +		if (!(p = strchr(line, ' ')))
> +			goto fail;
> +		*p++ = '\0';
> +		if (!strcmp(short_name, modname)) {

You had mentioned in the last patch that mod->name seemed to
get the respective name used in the struct driver, however
I am not seeing that. At least modpost seems to do this:

MODLISTCMD := find $(MODVERDIR) -name '*.mod' | xargs -r grep -h '\.ko$$' | sort -u

The extra $ is needed since this is part of for the makefile, to run this yourself
after a build do:

find ./ -name '*.mod' | xargs -r grep -h '\.ko$' | sort -u

This is the first step. It hunts for all modules.

Second step is:

cmd_modpost = $(MODLISTCMD) | sed 's/\.ko$$/.o/' | $(modpost) $(MODPOST_OPT) -s -T -

The sed there just swaps the .ko for .o  and then it runs modpost, taking the filenames
from stdin. We help modpost further to highlight that the module list is in stdin by
it using "-T -", this calls read_symbols_from_files("-"). From this it iterates over
each module list and for each it calls read_symbols(). The name is set via

 mod = new_module();

This just strips the .o but the same object build name is used. Perhaps the issue
is more of where the userspace tool you are using is getting the driver name instead?
If that's the issue the tool I think provides still the file path and as such the
object name, so that could be used instead ?

> +			kconfig_symbol = p;
> +			if ((p = strchr(kconfig_symbol, ' ')))
> +				*p = '\0';
> +			strcpy(mod->kconfig_symbol, kconfig_symbol);
> +			break;
> +		}
> +	}
> +	release_file(file, size);
> +	return;
> +fail:
> +	release_file(file, size);
> +	fatal("parse error in Module.ksymb file\n");
> +}
> +
> +static void add_kconfig_symbol(struct buffer *b, struct module *mod)
> +{
> +	get_kconfig_symbol(mod);
> +	if (mod->kconfig_symbol[0]) {
> +		buf_printf(b, "\n");
> +		buf_printf(b, "MODULE_INFO(kconfig_symbol, \"%s\");\n",
> +			   mod->kconfig_symbol);
> +	}
> +}
> +
>  static void write_if_changed(struct buffer *b, const char *fname)
>  {
>  	char *tmp;
> @@ -2478,6 +2524,7 @@ int main(int argc, char **argv)
>  		add_depends(&buf, mod, modules);
>  		add_moddevtable(&buf, mod);
>  		add_srcversion(&buf, mod);
> +		add_kconfig_symbol(&buf, mod);
>  
>  		sprintf(fname, "%s.mod.c", mod->name);
>  		write_if_changed(&buf, fname);
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 6a5e151..1ba48b1 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -119,6 +119,7 @@ struct module {
>  	int has_cleanup;
>  	struct buffer dev_table_buf;
>  	char	     srcversion[25];
> +	char	     kconfig_symbol[50];

Other than that please check for the longest symbol name here, is 50 enough?
Can we add a build warning / compile issue if this is longer than 50 on modpost?
That would in turn avoid possible bugs, and we'd be setting a limit. But really
is 50 the limit we want ?

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
