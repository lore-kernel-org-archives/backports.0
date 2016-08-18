Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58393 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754248AbcHSAyS (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 20:54:18 -0400
Date: Thu, 18 Aug 2016 19:55:05 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, teg@jklm.no,
        kay@vrfy.org, rusty@rustcorp.com.au, akpm@linux-foundation.org,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        Theodore Ts'o <tytso@mit.edu>, danijons@student.chalmers.se,
        Andrzej Wasowski <wasowski@itu.dk>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
Message-ID: <20160818175505.GM3296@wotan.suse.de> (sfid-20160819_040402_345260_DC13EC8F)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 17, 2016 at 09:26:58PM +0200, Cristina Moraru wrote:

> This patchset implements dynamic pegging of kconfig symbol
> into driver modinfo section

First a little bit of motivation here helps, so let me try to
help fill in some gaps. This may help explain what you have
been working on a bit more.

First, for those that were not Cc'd but curious about this work
so far, you can read the patches here:

Original cover letter:

https://lkml.kernel.org/r/1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com

https://marc.info/?l=linux-kernel&m=147146213519750&w=2 - patch 1
https://marc.info/?l=linux-kernel&m=147146209019744&w=2 - patch 2
https://marc.info/?l=linux-kernel&m=147146211819747&w=2 - patch 3
https://marc.info/?l=linux-kernel&m=147146209119745&w=2 - patch 4
https://marc.info/?l=linux-kernel&m=147146209519746&w=2 - patch 5

There are a few situations in which you may want to extract a
subset of Kconfig CONFIG_* symbols for a system. At least when
only considering modules:

 a) When optimizing build requirements for a kernel for a system.
    That is you boot into a distro kernel and then want to build
    a slim kernel only with sensible kernel configuration options.

 b) When you are on a distribution kernel but the distribution
    kernel provided lacks hardware support for your device, you
    may either want to upgrade the full kernel in which case you
    want to do a) or -- you may want to just a backports release
    which provides just the modules you need, you'd use it on top
    of the distribution kernel.

Are there other *uses* outside of the two above for having a direct
deterministic mapping between module and a kconfig symbol ? What
if we could also do this for built-in code as well ? kconfig-sat [0] is
work that is still being ironed out, but if that was in place and we
handed it a set of required options we want, it should in theory help
resolve the dependencies to give us a functional .config for a kernel.
This of course is a long term possible goal just used as an example
-- but are there other uses?

Another possible gain here is if addressing a deterministic mapping might
help with some of the limitations observed in practice over years with
kconfig and semantics for keconfig. I go into some of this further below.

There are not many options currently available to optimize kernel builds this
way for modules or choose only what kernel kconfig options you need.  One of
the best known efforts is the upstream 'make localmodconfig' added by Steven
years ago to help with a). This has its own set of limitations though. For
backports we also need to address possible kconfig symbol name changes, and the
fact that you may boot a box without a driver loaded and as such not be sure
what new kernel kconfig symbol you may need.

There are shared issues with both goals, addressing shared issues
can ultimately help both. One of the shared known issues is the
lack of a deterministic resolution of a module to a respective
kconfig symbol. Even answering if this is possible or should be
possible requires some work.

The work Cristina has done here for this year's Google Summer of
Code is try to help start looking into addressing the question if
this is possible and then start looking into how we could annotate
such a thing, and later how we'd use it.

[0] https://kernelnewbies.org/KernelProjects/kconfig-sat

> * updates streamline_config.pl to generate the auxiliary file
> scripts/mod/Module.ksymb containing associations of driver file
> names and corresponding kconfig symbols CONFIG_*

Here you make use of existing heuristics -- note however that
heuristics are needed as we have no direct mapping available
nor do we have any rules over how to make such a direct mapping
possible if we wanted this mapping to be deterministic.

> * updates Makefiles to trigger streamline_config.pl call for
> Module.ksymb generation and pass the determined CONFIG_* symbol
> as compilation parameter -D in KBUILD_KSYMB variable

Passing -D for define a new KBUILD_KSYMB when available would be a way to pass
to the build system a config symbol associated with a module, its the right
approach, however re-using streamline_config.pl seems questionable here, and it
seems an optimization might be / should be possible. Likewise we'd need to also
still look into and address *why* some modules don't end up with a respective
kconfig symbol -- and if we wanted to do something about this. Given the stated
goals more importantly would be what the costs are to have a deterministic
mapping.

> * adds kconfig_symb as module attribute

This seems lightweight and follows the logic of the other attributes.
If its too much, this can be a configurable feature.

> * updates modpost to set KBUILD_KSYMB macro as value for
> kbuild_symb attribute

Neat.

> Note: the content of the file Module.ksymb is generated for
> all modules that have only one associate CONFIG option. All
> others are considered to be components linked at the final
> modules but not final modules itselves.

To be clear, you only peg the CONFIG_ option if you are
100% certain of having a direct mapping, is that right ?

> The result of this patchset is the following. All modules from
> /sys expose the correct CONFIG_* symbol in the module attribute
> kconfig_symb with some exceptions. For a total number of 58
> modules, 

What kernel configuration did you use ? What architecture ?
If you use allmodconfig, what do the numbers look like ?

> 4 of them do not:
> 
> snd_seq_midi_event

Takashi, any reason for this to not have a Kconfig symbol ?
If we don't want one, is there perhaps any annotation we
could use to help make a deterministic association if a
respective kconfig symbol is needed ?

> mptscsih

Same thing -- for both I suppose we can infer that these
are just helpers, and can / should be enabled if any of
the devices are found to be present / required.

I can imagine that in certain situations a helper like
the above might really just be optional rather than required,
but I'd hope such an optional nature should be reflected via
Kconfig, the default setting being the recommended option to
assume as safe then, unless input is provided to help fill
in the gap and disable / force enable certain options.

> libahci

In this case libahci is spinkled over a lot of lines on the Makefile,
its a module though, and there is no direct association of dependency
relationship other than the Makefile association. Using a kconfig
symbol would replace the Makefile clutter but make the assocation
and requirement of the dependency explicit through Kconfig. Is
that desirable or should we just make the assumption that in these
cases we could assume one Kconfig symbol that adds a module implicitly
is equivalent as if the module had a kconfig symbol and we had done
"select foo" for each ? Note though that select is heavy handed [1] --
and its over use can lead to issues. For instance its known that
select does not check for dependencies, its a heavy handed way of
enabling options needed by architectures. So using select here may
not be desirable. Using "depends on" here would work but it can hide
from the menu drivers until you have enabled its dependency.

[1] https://kernelnewbies.org/KernelProjects/kconfig-sat#head-d1734174081ec7a1612fb29277bfc850d82ba31e

> mptbase

Same situation as  mptscsih.

> After a short research:
> 
> For mptscsih - ./drivers/message/fusion/Makefile
> obj-$(CONFIG_FUSION_SPI)	+= mptbase.o mptscsih.o mptspi.o
> obj-$(CONFIG_FUSION_FC)		+= mptbase.o mptscsih.o mptfc.o
> obj-$(CONFIG_FUSION_SAS)	+= mptbase.o mptscsih.o mptsas.o
> As appears in the Makefile mptscsi is part of more config
> options so it's excluded because it's not considered a module
> by itself but, somehow gets compiled as module. Same for the
> mptbase. I still have to understand better the Kbuild logic so
> I cannot state that this is loose practice.

Another reason for this loose use could also be that using "select"
in Kconfig is heavy handed and can lead to recursive issues, refer
to commit 1c199f2878f6c1b8c52125ad9805e94fe2dde472 ("kbuild: document recursive
dependency limitation / resolution") for more information and
a clear example of the issue. There is also a list of commits
with possible resolutions to issues, so that can be inspected further
to try to understand if perhaps some of the lack of kconfig symbols
and respective deterministic mapping from module to kconfig is due
to prior issues with select. I doubt it given that otherwise we'd
have at least symbols for these -- but worth taking into consideration
*if* we do then want to add symbols for them, we do not want to lead
to recursive issues if we add these new symbols.

If we add a kconfig symbol for modules lacking them, what is a
strategical way to do so in such a way we avoid known past
issues but also paves the way for the future ?

> For libahci there are multiple CONFIG_ symbols for different
> architectures.
> 
> Although past discussion recommended not to use streamline_config,
> this patchset still relies on it, for the sake of the proof of
> concept. 

OK.

> Although the result is close to the target it still does
> not provide complete correctness. However it can be replaced by
> creating another script

Or C code.

> which tries to determine better the
> module <-> CONFIG associations and output them in auxiliary file
> Module.ksymb. Maybe this way we could also determine all CONFIGs
> for a particular driver, not only the exact one that enables it.
> 
> The auxiliary file is necessary because the Makefile itself does
> not have a mapping. 

Clarification: at least not an easy O(1) quick mapping.

> The makefile includes the config file with
> directive include which creates a series of internal variables
> CONFIG_FOO=y/m/n. Afterwards, when recursively descending into
> other Makefiles, lines like 
> 
> obj-$(CONFIG_FOO) = foo.o 
> 
> are resolved in place to obj-y, obj-m etc according to 'make'
> logic and the association is lost.
> 
> Finally, what does this patchset provide is an infrastructure
> to dinamically peg CONFIG_* options to associate drivers using
> the mapping from Module.ksymb file. Generation of Module.ksymb
> can be replaced but keeping the same format permit the usage of
> the other patches.

OK this makes sense, so as it stands it seems we need a better
way to generate the Module.ksymb and then also address those
modules which lack a current deterministic mapping, and address
a resolution with the community on that.

> This patchset is part of a research project within
> Google Summer of Code of porting 'make localmodconfig'
> for backported drivers. The goal is to enable each
> module to expose in /sys its corresponding CONFIG_* option.
> The value of this attribute will be dynamically pegged by
> modpost without requiring extra work from the driver developers.
> Further, this information will be used by a hardware interogation
> tool to extract build information about the existing devices.

Good stuff!

  Luis

> Cristina Moraru (5):
>   Add generation of Module.symb in streamline_config
>   Add CONFIG symbol to module as compilation parameter
>   Trigger Module.ksymb generation in Makefile
>   Set KCONFIG_KSYMB as value for kconfig_ksymb module attribute
>   Add kconf_symb as kernel module attribute
> 
>  Makefile                             |  4 ++++
>  include/linux/module.h               |  1 +
>  kernel/module.c                      |  2 ++
>  scripts/Makefile.lib                 |  9 ++++++++-
>  scripts/kconfig/streamline_config.pl | 30 +++++++++++++++++++++++++++++-
>  scripts/mod/modpost.c                |  7 +++++++
>  6 files changed, 51 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
