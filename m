Return-path: <backports-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42703 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758281AbcHYHpa (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 25 Aug 2016 03:45:30 -0400
Date: Thu, 25 Aug 2016 09:43:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
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
Message-ID: <20160825074313.GC18622@lst.de> (sfid-20160825_094748_923246_B1A112AD)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com> <20160818175505.GM3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818175505.GM3296@wotan.suse.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The idea seems useful, but I reallt don't like the 'reverse-engineering'
approach.

If we want to this properly from the ground up we should just split out
our CONFIG_ SYMBOLS into

MODULE_* - builds exactly one module (tristate, or maybe also as a built-in
only one, then like a bool)

CONFIG_* - just bool, MODULE_ may depend on it, too.

The other nice thing is that we could probably fold most of the Makefiles
into Kconfig using that methods as well, by listing the objectes required
for a module, e.g.

module NVME_TARGET
	tristate "NVMe Target support"
	depends on BLOCK
	depends on CONFIGFS_FS
	name nvmet
	objects core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o
	objects discovery.o

module NVME_TARGET_LOOP
	tristate "NVMe loopback device support"
	depends on BLK_DEV_NVME
	depends on NVME_TARGET
	select NVME_FABRICS
	select SG_POOL
	name nvme-loop
	objects loop.o
--
To unsubscribe from this list: send the line "unsubscribe backports" in
