Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56003 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbcHWTSE (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 23 Aug 2016 15:18:04 -0400
Date: Tue, 23 Aug 2016 21:17:59 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
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
Message-ID: <20160823191759.GH3296@wotan.suse.de> (sfid-20160823_211807_172275_CCF4080C)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <CAGZ2q2yFPefFHcNY15O6PkZn2utiEtGuS=qUU5mNQ7LyPDMrnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGZ2q2yFPefFHcNY15O6PkZn2utiEtGuS=qUU5mNQ7LyPDMrnA@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Aug 22, 2016 at 09:35:47PM +0200, Cristina-Gabriela Moraru wrote:
> 2016-08-18 19:55 GMT+02:00 Luis R. Rodriguez <mcgrof@kernel.org>:
> > On Wed, Aug 17, 2016 at 09:26:58PM +0200, Cristina Moraru wrote:
> >
> >> This patchset implements dynamic pegging of kconfig symbol
> >> into driver modinfo section
> >
> > First a little bit of motivation here helps, so let me try to
> > help fill in some gaps. This may help explain what you have
> > been working on a bit more.
> >
> > First, for those that were not Cc'd but curious about this work
> > so far, you can read the patches here:
> >
> > Original cover letter:
> >
> > https://lkml.kernel.org/r/1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com
> >
> > https://marc.info/?l=linux-kernel&m=147146213519750&w=2 - patch 1
> > https://marc.info/?l=linux-kernel&m=147146209019744&w=2 - patch 2
> > https://marc.info/?l=linux-kernel&m=147146211819747&w=2 - patch 3
> > https://marc.info/?l=linux-kernel&m=147146209119745&w=2 - patch 4
> > https://marc.info/?l=linux-kernel&m=147146209519746&w=2 - patch 5
> >
> > There are a few situations in which you may want to extract a
> > subset of Kconfig CONFIG_* symbols for a system. At least when
> > only considering modules:
> >
> >  a) When optimizing build requirements for a kernel for a system.
> >     That is you boot into a distro kernel and then want to build
> >     a slim kernel only with sensible kernel configuration options.
> >
> >  b) When you are on a distribution kernel but the distribution
> >     kernel provided lacks hardware support for your device, you
> >     may either want to upgrade the full kernel in which case you
> >     want to do a) or -- you may want to just a backports release
> >     which provides just the modules you need, you'd use it on top
> >     of the distribution kernel.
> >
> > Are there other *uses* outside of the two above for having a direct
> > deterministic mapping between module and a kconfig symbol ? What
> > if we could also do this for built-in code as well ? kconfig-sat [0] is
> > work that is still being ironed out, but if that was in place and we
> > handed it a set of required options we want, it should in theory help
> > resolve the dependencies to give us a functional .config for a kernel.
> > This of course is a long term possible goal just used as an example
> > -- but are there other uses?
> >
> I can't think of any examples. I will add this ones in the cover
> letter as motivation.

Michal provided one more :) -- which was actually a side goal you had I think.

Very clearly documenting the motivation is very important here, side benefits
that you can think of are (some listed above) should help understand why
we may went to or not do some further enhancements to build system to help
with more deterministic backwards mappings.

> > To be clear, you only peg the CONFIG_ option if you are
> > 100% certain of having a direct mapping, is that right ?
> >
> 
> Yes.

OK but as you clarified in other e-mail then the attribute is added but
its just empty. This is rather ambiguous -- lets instead try to not add
the attribute if one is not available.

> And there are some drivers which have duplicate values in the hash.
> foo.o -> CONFIG_FOO CONFIG_FOO

What is the reason for this ?

> Although this one has one match it's filtered as having 2 CONFIGs.
> 
> >> The result of this patchset is the following. All modules from
> >> /sys expose the correct CONFIG_* symbol in the module attribute
> >> kconfig_symb with some exceptions. For a total number of 58
> >> modules,
> >
> > What kernel configuration did you use ? What architecture ?
> > If you use allmodconfig, what do the numbers look like ?
> >
> 
> I have a virtual machine in which I created the configuration with
> make localmodconfig and installed the new kernel.
> $  uname -a
> Linux ubuntu 4.7.0+ #28 SMP Mon Aug 15 20:39:19 CEST 2016 x86_64
> x86_64 x86_64 GNU/Linux
> 
> Should I send you the .config file ?

This is not needed, I ran your patches through 0-day and it was happy.
Good job !

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
