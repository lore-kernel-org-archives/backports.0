Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41400 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759193AbcHYIaU (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 25 Aug 2016 04:30:20 -0400
Message-ID: <1472112020.24772.4.camel@sipsolutions.net> (sfid-20160825_103040_411309_68EBF8E4)
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@lst.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Cristina Moraru <cristina.moraru09@gmail.com>,
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
Date: Thu, 25 Aug 2016 10:00:20 +0200
In-Reply-To: <20160825074313.GC18622@lst.de>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
         <20160818175505.GM3296@wotan.suse.de> <20160825074313.GC18622@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> The other nice thing is that we could probably fold most of the
> Makefiles into Kconfig using that methods as well, by listing the
> objectes required for a module, e.g.
> 
> module NVME_TARGET
> 	tristate "NVMe Target support"
> 	depends on BLOCK
> 	depends on CONFIGFS_FS
> 	name nvmet
> 	objects core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o
> 	objects discovery.o
> 

If this was going to be a thing, then you might also have

config NVME_TARGET_FOO
	bool "NVMe target supports FOO"
	module NVME_TARGET
	objects foo.o

The "module" would be like a "depends on" plus giving the module for
generating the Makefile, and now you can really remove most Makefile
stuff... :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
