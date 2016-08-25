Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755098AbcHYTw0 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 25 Aug 2016 15:52:26 -0400
Date: Thu, 25 Aug 2016 21:51:28 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Christoph Hellwig <hch@lst.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
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
Message-ID: <20160825195128.GD3296@wotan.suse.de> (sfid-20160825_215314_390293_167635FE)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de>
 <20160825074313.GC18622@lst.de>
 <1472112020.24772.4.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472112020.24772.4.camel@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 25, 2016 at 10:00:20AM +0200, Johannes Berg wrote:
> 
> > The other nice thing is that we could probably fold most of the
> > Makefiles into Kconfig using that methods as well, by listing the
> > objectes required for a module, e.g.
> > 
> > module NVME_TARGET
> > 	tristate "NVMe Target support"
> > 	depends on BLOCK
> > 	depends on CONFIGFS_FS
> > 	name nvmet
> > 	objects core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o
> > 	objects discovery.o
> > 
> 
> If this was going to be a thing, then you might also have
> 
> config NVME_TARGET_FOO
> 	bool "NVMe target supports FOO"
> 	module NVME_TARGET
> 	objects foo.o

You mean this instead of a Makefile:

foo-$(CONFIG_NVME_TARGET_FOO) += foo.o

?

> The "module" would be like a "depends on" plus giving the module for
> generating the Makefile, and now you can really remove most Makefile
> stuff... :)

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
