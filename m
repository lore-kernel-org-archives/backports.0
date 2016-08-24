Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755817AbcHXQdl (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 24 Aug 2016 12:33:41 -0400
Date: Wed, 24 Aug 2016 18:33:33 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        teg@jklm.no, kay@vrfy.org, rusty@rustcorp.com.au,
        akpm@linux-foundation.org, backports@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <20160824163333.GR3296@wotan.suse.de> (sfid-20160824_183344_653588_84668A44)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <8e80a77a-7e8f-f5d9-d221-50cddb1926c5@suse.com>
 <20160823213224.GK3296@wotan.suse.de>
 <761025cd-cc36-c53f-b9cc-fe37a918644c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <761025cd-cc36-c53f-b9cc-fe37a918644c@suse.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 24, 2016 at 01:05:04PM +0200, Michal Marek wrote:
> On 2016-08-23 23:32, Luis R. Rodriguez wrote:
> > On Fri, Aug 19, 2016 at 11:07:36AM +0200, Michal Marek wrote:
> >> On 2016-08-18 19:55, Luis R. Rodriguez wrote:
> >>> On Wed, Aug 17, 2016 at 09:26:58PM +0200, Cristina Moraru wrote:
> >>>
> >>>> This patchset implements dynamic pegging of kconfig symbol
> >>>> into driver modinfo section
> >>>
> >>> First a little bit of motivation here helps, so let me try to
> >>> help fill in some gaps. This may help explain what you have
> >>> been working on a bit more.
> >>>
> >>> First, for those that were not Cc'd but curious about this work
> >>> so far, you can read the patches here:
> >>>
> >>> Original cover letter:
> >>>
> >>> https://lkml.kernel.org/r/1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com
> >>>
> >>> https://marc.info/?l=linux-kernel&m=147146213519750&w=2 - patch 1
> >>> https://marc.info/?l=linux-kernel&m=147146209019744&w=2 - patch 2
> >>> https://marc.info/?l=linux-kernel&m=147146211819747&w=2 - patch 3
> >>> https://marc.info/?l=linux-kernel&m=147146209119745&w=2 - patch 4
> >>> https://marc.info/?l=linux-kernel&m=147146209519746&w=2 - patch 5
> >>>
> >>> There are a few situations in which you may want to extract a
> >>> subset of Kconfig CONFIG_* symbols for a system. At least when
> >>> only considering modules:
> >>>
> >>>  a) When optimizing build requirements for a kernel for a system.
> >>>     That is you boot into a distro kernel and then want to build
> >>>     a slim kernel only with sensible kernel configuration options.
> >>>
> >>>  b) When you are on a distribution kernel but the distribution
> >>>     kernel provided lacks hardware support for your device, you
> >>>     may either want to upgrade the full kernel in which case you
> >>>     want to do a) or -- you may want to just a backports release
> >>>     which provides just the modules you need, you'd use it on top
> >>>     of the distribution kernel.
> >>
> >> c) Having the mapping in sysfs would allow to simplify
> >> streamline_config.pl avoid parsing Makefiles in perl.
> > 
> > Indeed, this was actually a side possible goal here :) only it seems
> > we totally forgot about it while addressing the work.
> > 
> >> Only if the patch did not depend on streamline_config.pl :)
> > 
> > Indeed, lets get rid of that dependency.
> > 
> >> One idea would be to generate
> >> the Module.ksymb in a similar way we generate the modules.builtin file:
> >> Generate an alternate include/config/*.conf with all CONFIG_FOO=m
> >> replaced with
> >>
> >> CONFIG_FOO=m-CONFIG_FOO
> >>
> >> and in the Makefile, iterate over $(filter m-CONFIG_%, $(.VARIABLES)) to
>                                        should be obj-m-CONFIG_%
> 
> >> create the mapping. This would also properly cover cases where we build
> >> the $(obj-m) list from another list. It would certainly create other
> >> corner cases, but it's worth trying IMO.
> > 
> > Neat, would that cover lib-m then as well or other targets that would generate 
> > modules ?
> 
> This would have to be handled as well by the patch. Obviously it's not
> going to be as simple as described in a single paragraph of text :).

Ah OK, it was not clear to me if your suggestion captured all modules already.
There may still be a way. We just have to look harder. Then what precise
target was used would be irrelevant.

> >> Another thing is that we do not necessarily need to record this
> >> information in .modinfo, but we can generate a list in
> >> /lib/modules/`uname -r`/ for consumption. It could also include drivers
> >> that are builtin in the current configuration.
> > 
> > Well so one future use would be for instance a 'make udevconfig' which
> > in theory should be able then to scrape all possible related needed
> > device CONFIG_'s and then give you an optimal kernel configuration.
> > It'd be nice to be able to extract this from the kernel and modules
> > without needing build sources in /lib/modules/`uname -r`/.
> 
> I meant that the file can be installed by modules_install. Like you have
> /lib/modules/`uname -r`/modules.builtin with recent kernels and recent
> distro packages.

Got it.

> But really, it's a minor issue how the information is
> presented to userspace.

To us perhaps, but to userspace and users this is a big deal. It'd be nice
to be able to construct a kernel config only with what CONFIG's your hardware
needs, doing this should mean trying to expose enough information in a way
userspace is easily able to handle. The reason to go with the mod section stuff
was this was already being picked up by udevadm for its own hardware db info,
so this seemed like a logical evolution, and it would not require your
kernel sources installed.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
