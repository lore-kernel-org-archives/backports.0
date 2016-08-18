Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754246AbcHSAyS (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:18 -0400
Date: Thu, 18 Aug 2016 20:22:36 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
        kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
        backports@vger.kernel.org,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>
Subject: Re: [RFC PATCH 1/5] Add generation of Module.symb in
 streamline_config
Message-ID: <20160818182236.GO3296@wotan.suse.de> (sfid-20160819_040407_175425_34C55C83)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-2-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471462023-119645-2-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 17, 2016 at 09:26:59PM +0200, Cristina Moraru wrote:
> Add generation of ./scripts/Module.ksymb file containing
> associations of driver file names and corresponding CONFIG_*
> symbol:
> 
> foo_KCONF=CONFIG_FOO
> 
> This file will be further loaded by the Makefile as a
> configuration file: all foo_KCONF will be considered variables
> and all CONFIG_FOO will be their associate values.

Will the file generated always work? What are the current
restrictions on kconfig variable names?

> The suffix
> is added to be able to differentiate the new variables from
> all existing variables in the Makefile system. Each kernel
> module will receive its CONFIG_FOO option as macro in the
> compilation command (-D parameter) and will expose it along
> with other module attributes (attributes of struct module).

This is done later so this description does not belong here.
You want to describe what this patch does alone, if it has
potential for the future just mention basics, and that will will
be done later.

> Note: this patch is built on the assumption that each driver
> has exactly one associate CONFIG_FOO symbol.

This should note be a note, it should be an important aspect of
your changes -- you should try to describe when a direct mapping
is possible and when it is not.

> CONFIG_* options
> that are required by CONFIG_FOO are not included. They can be
> found by SAT resolvers.

You can leave this out.

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
>  scripts/kconfig/streamline_config.pl | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/streamline_config.pl b/scripts/kconfig/streamline_config.pl
> index b8c7b29..686d02a 100755
> --- a/scripts/kconfig/streamline_config.pl
> +++ b/scripts/kconfig/streamline_config.pl
> @@ -128,9 +128,11 @@ my @config_file = read_config;
>  # Parse options
>  my $localmodconfig = 0;
>  my $localyesconfig = 0;
> +my $genmoduleksymb = 0;
>  
>  GetOptions("localmodconfig" => \$localmodconfig,
> -	   "localyesconfig" => \$localyesconfig);
> +	   "localyesconfig" => \$localyesconfig,
> +	   "genmoduleksymb" => \$genmoduleksymb);
>  
>  # Get the build source and top level Kconfig file (passed in)
>  my $ksource = ($ARGV[0] ? $ARGV[0] : '.');
> @@ -147,6 +149,7 @@ my %objects;
>  my $var;
>  my $iflevel = 0;
>  my @ifdeps;
> +my @drv_objs;
>  
>  # prevent recursion
>  my %read_kconfigs;
> @@ -348,6 +351,31 @@ foreach my $makefile (@makefiles) {
>      close($infile);
>  }
>  
> +foreach my $obj_key ( keys %objects )
> +{
> +	my @config_options = @{$objects{$obj_key}};
> +	# Last index of array is 0 is equivalent to array's size is 1
> +	if ( $#config_options == 0) {
> +		push(@drv_objs, $obj_key);
> +	}
> +}
> +
> +sub gen_module_kconfigs {
> +	my $module_ksymb = $ENV{'srctree'}."/scripts/Module.ksymb";
> +
> +	open(my $ksymbfile, '>', $module_ksymb) || die "Can not open $module_ksymb for writing";
> +
> +	foreach (@drv_objs) {
> +		print $ksymbfile "$_" . "_KCONF=" . "@{$objects{$_}}\n";
> +	}
> +	close($ksymbfile);
> +}
> +
> +if ($genmoduleksymb) {
> +	gen_module_kconfigs();
> +	exit(0);
> +}
> +
>  my %modules;
>  my $linfile;

This is nice for experimentation, however as you note we want
to evaluate a better way to do this. While at it, can you describe
what algorithm currently is used by scripts/kconfig/streamline_config.pl
to collect %objects and the associated CONFIG symbol ? Can you think
of possible flaws to it ?

The generation here is also forced, we want to enable this to be optional
so please consider adding a Kconfig entry for this as a feature, just as
the module versioning stuff has one.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
