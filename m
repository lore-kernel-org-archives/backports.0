Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38657 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbcHHTPl (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Aug 2016 15:15:41 -0400
Date: Mon, 8 Aug 2016 21:15:33 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
	Valentin Rothberg <valentinrothberg@gmail.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
	kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
	backports@vger.kernel.org, gregkh@linuxfoundation.org,
	Michal Marek <mmarek@suse.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	"rafael.j.wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 2/3] Add generation of Module.ksymb file in
 streamline_config.pl
Message-ID: <20160808191533.GT3296@wotan.suse.de> (sfid-20160808_214402_586962_9F082074)
References: <1469979232-15531-1-git-send-email-cristina.moraru09@gmail.com>
 <1469979232-15531-3-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469979232-15531-3-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Jul 31, 2016 at 05:33:51PM +0200, Cristina Moraru wrote:
> Add generation of ./scripts/mod/Module.ksymb file containing
> associations of driver file names and corresponding CONFIG_*
> symbol.
> 
> This file will be used by modpost to peg kconfig CONFIG_*
> symbol to its corresponding module. This information will
> be further exposed in userspace for extracting build options
> for the required modules.
> 
> This approach faces the following limitations:
> * in some cases there are more than one CONFIG_* option
> for certain objects. This happens for the objects that are
> part of more CONFIGs. Thus, all configs are returned for
> this object names. For example, the mapping for clk_div6 is
> CONFIG_ARCH_R8A73A4, CONFIG_ARCH_R8A7793 and many others.

Ah, indeed so for instance:

drivers/clk/renesas/Makefile:
...
obj-$(CONFIG_ARCH_R8A73A4)              += clk-r8a73a4.o clk-div6.o             
obj-$(CONFIG_ARCH_R8A7740)              += clk-r8a7740.o clk-div6.o  
...

So in this case there is no particular unique CONFIG_* symbols that
only associates itself to clk-div6.

Given that the purpose here is to help compile a .config that is sufficient to
build a kernel with that module, I do believe using both config symbols would
be the appropriate solution in this case to ensure a build suffices based only
on this information.  This is only possible of course *iff* both symbols are
not mutually exclusive, so in this case an issue would be if for instance
CONFIG_ARCH_R8A73A4's kconfig entry negates CONFIG_ARCH_R8A7740. They do not
in this case so using both suffices. I can imagine doing this secondary logic
is cumbersome, so perhaps its best we avoid these sorts of situations as it
would imply doing more work going barkwards -- from modules loaded to modules
to symbols.

I'd bet this would not be the only kconfig issue that could arise from this
loose practice in kconfig.

Anyway, if we determine that both kconfig options should be enabled for a build
to select this driver -- that would increase the build size, perhaps with no
need for it. So this strategy of course would not yield optimal builds. So we
should just expand the kconfig documentation indicating pitfalls of this use
of kconfig, given the deterministic gains we want of mapping between modules
to config symbols.

It'd be curious to see metrically how many symbols we have like this which are
modules and if there is a benefit to add a respective first class config symbol
to each. Is that too much to ask to hunt quantitatively ? Based on this we can
determine if a tree-wide cleaning is in order. If folks already know this is
outright dumb please let me know. Additionally -- are there other areas in the
kernel that suffer from the lack of direct deterministic relationship between
modules and a kconfig symbol ? Or how about the other way around: is there any
valid hard requirement to enable this loose practice on the kernel ? If we
remove this loose semantic, do we loose anything ? So far I see only gains:

 o Once you have modules loaded, have the ability to do a deterministic
   set of .config symbol entries you know you need for an optimal smaller build
   for your device. If you have a direct mapping a tool that scrapes this
   list can be kconfig language stupid, and does not need to inspect your other
   symbols or upstream Kconfig entry for issues with other symbols

 o Having a direct mapping means selecting only the real configuration options
   needed

 o Forcing a bit of documenting (through the configuration menu) more clearly
   what this module does

> * in some cases the driver file name does not match the
> registered name for the module. For example:
> 
> Driver filename		Module name
> -----------------------------------
> lineage-pem[.o]		lineage_pem
>
> phy-ab8500-usb[.o]	abx5x0-usb
>
> ehci-mxc[.o]		mxc-ehci
> etc.

To be clear you mean here for instance:

drivers/usb/phy/phy-ab8500-usb.c
...
static struct platform_driver ab8500_usb_driver = {                             
        .probe          = ab8500_usb_probe,                                     
        .remove         = ab8500_usb_remove,                                    
        .id_table       = ab8500_usb_devtype,                                   
        .driver         = {                                                     
                .name   = "abx5x0-usb",                                         
        },                                                                      
};  
...

The .ko filename should I think typically match the respective principle
object filename, would that help? So for instance while the name above
is abx5x0-usb, the ko file should still be drivers/usb/phy/phy-ab8500-usb.ko

There may be some exceptions to this but this probably is not that common?

> There is no naming rule / standard between the driver
> name and the registered module name.

This seems true. In this case the module name should match the
target object typically.

> This patch is part of a research project within
> Google Summer of Code of porting 'make localmodconfig'
> for backported drivers.
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> ---
>  scripts/kconfig/streamline_config.pl | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/scripts/kconfig/streamline_config.pl b/scripts/kconfig/streamline_config.pl
> index b8c7b29..4833ede 100755
> --- a/scripts/kconfig/streamline_config.pl
> +++ b/scripts/kconfig/streamline_config.pl
> @@ -147,6 +147,7 @@ my %objects;
>  my $var;
>  my $iflevel = 0;
>  my @ifdeps;
> +my @drv_objs;
>  
>  # prevent recursion
>  my %read_kconfigs;
> @@ -341,6 +342,10 @@ foreach my $makefile (@makefiles) {
>  		    # The objects have a hash mapping to a reference
>  		    # of an array of configs.
>  		    $objects{$1} = \@arr;
> +		    # Save objects corresponding to driver Makefiles
> +		    if (index($makefile, "./drivers/") == 0) {
> +			    push(@drv_objs, substr($obj, 0, -2));
> +			}
>  		}
>  	    }
>  	}
> @@ -348,6 +353,21 @@ foreach my $makefile (@makefiles) {
>      close($infile);
>  }
>  
> +sub gen_module_kconfigs {
> +
> +	my $module_ksymb = $ENV{'objtree'}."/scripts/mod/Module.ksymb";
> +	my $key;
> +
> +	open(my $ksymbfile, '>', $module_ksymb) || die "Can not open $module_ksymb for writing";
> +
> +	foreach (@drv_objs) {
> +		print $ksymbfile "$_ " . "@{$objects{$_}}\n";
> +	}
> +	close $ksymbfile;
> +}
> +
> +gen_module_kconfigs();
> +
>  my %modules;
>  my $linfile;

It would be good to see how we could not rely on scripts/kconfig/streamline_config.pl
for this purpose. That should only be used for helping with localmodconfig. In this
case we want to make the kconfig symbol available to all modules when possible, so
we do not want to depend on scripts/kconfig/streamline_config.pl generically.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
