Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757184AbcHYUxn (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 25 Aug 2016 16:53:43 -0400
Date: Thu, 25 Aug 2016 22:19:19 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org,
        teg@jklm.no, kay@vrfy.org, rusty@rustcorp.com.au,
        akpm@linux-foundation.org, backports@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
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
Message-ID: <20160825201919.GE3296@wotan.suse.de> (sfid-20160825_225508_261813_0C332186)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160825074313.GC18622@lst.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 25, 2016 at 09:43:13AM +0200, Christoph Hellwig wrote:
> The idea seems useful, but I reallt don't like the 'reverse-engineering'
> approach.
> 
> If we want to this properly from the ground up we should just split out
> our CONFIG_ SYMBOLS into
> 
> MODULE_* - builds exactly one module (tristate, or maybe also as a built-in
> only one, then like a bool)
> 
> CONFIG_* - just bool, MODULE_ may depend on it, too.

Curious what does the split buy us if the real meaningful input is the value
assigned to the config ? Ie, MODULE_FOO=m would be the modules we want to
check for.

> The other nice thing is that we could probably fold most of the Makefiles
> into Kconfig using that methods as well, by listing the objectes required
> for a module, e.g.

OK If the Kconfig file has the objects listed I can see the gain of using
Kconfig then to more easily map out to a symbol, given doing this on Makefiles
is not straight forward.

> module NVME_TARGET
> 	tristate "NVMe Target support"
> 	depends on BLOCK
> 	depends on CONFIGFS_FS
> 	name nvmet
> 	objects core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o
> 	objects discovery.o
> 
> module NVME_TARGET_LOOP
> 	tristate "NVMe loopback device support"
> 	depends on BLK_DEV_NVME
> 	depends on NVME_TARGET
> 	select NVME_FABRICS
> 	select SG_POOL
> 	name nvme-loop
> 	objects loop.o

I can see a huge win of having a direct specification that provides as a
feature two way mapping from CONFIG <--> module (objects) and backwards again
easily and clearly without hacks, specially if upon boot then we can then
provide the precise kernel configuration you need, for both built-in and
modules. The above could help with modules -- for built-in reverse mapping
we'd need something else, perhaps a configurable option to keep tabs on
inits called with associated configs.

The above would be a pretty intrusive change though, in comparison to
Cristina's original approach. The reverse-engineering object --> config
aspect of her work and of the old scripts/kconfig/streamline_config.pl
explains why it was hard. I'd be curious to learn of other gains possible
other than those listed so far, if we had this.

Re-iterating gains of having a simple two way CONFIG <--> module (objects)
mapping (following the above proposal now):

a) When optimizing build requirements for a kernel for a system.                                                                                                           
   That is you boot into a distro kernel and then want to build                                                                                                            
   a slim kernel only with sensible kernel configuration options.                                                                                                          

b) When you are on a distribution kernel but the distribution                                                                                                              
   kernel provided lacks hardware support for your device, you                                                                                                             
   may either want to upgrade the full kernel in which case you                                                                                                            
   want to do a) or -- you may want to just a backports release                                                                                                            
   which provides just the modules you need, you'd use it on top                                                                                                           
   of the distribution kernel.                                                                                                                                             

c) Having the mapping in sysfs would allow to simplify                                                                                                                       
   streamline_config.pl avoid parsing Makefiles in perl. (From Michal)

d) Fold most of the Makefiles into Kconfig

In retrospect c) still seems related to a) as we'd do away with
the hacks completely needed by streamline_config.pl, a) can be
augmented if we figure out a built-in solution as well.

d) Just seems like collateral of a more precise mapping than
what a Makefile provides. Anything else ?

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
