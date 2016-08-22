Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35587 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbcHVTsg (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Aug 2016 15:48:36 -0400
MIME-Version: 1.0
In-Reply-To: <8e80a77a-7e8f-f5d9-d221-50cddb1926c5@suse.com>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de> <8e80a77a-7e8f-f5d9-d221-50cddb1926c5@suse.com>
From: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Date: Mon, 22 Aug 2016 21:48:33 +0200
Message-ID: <CAGZ2q2yHp97d7mYBMB9bDMc3EOgHwZd7Cgjqvor=8K_jBXMdSg@mail.gmail.com> (sfid-20160822_214839_518056_4BF1CF30)
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To: Michal Marek <mmarek@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
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
        "Theodore Ts'o" <tytso@mit.edu>, danijons@student.chalmers.se,
        Andrzej Wasowski <wasowski@itu.dk>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2016-08-19 11:07 GMT+02:00 Michal Marek <mmarek@suse.com>:
> On 2016-08-18 19:55, Luis R. Rodriguez wrote:
>> On Wed, Aug 17, 2016 at 09:26:58PM +0200, Cristina Moraru wrote:
>>
>>> This patchset implements dynamic pegging of kconfig symbol
>>> into driver modinfo section
>>
>> First a little bit of motivation here helps, so let me try to
>> help fill in some gaps. This may help explain what you have
>> been working on a bit more.
>>
>> First, for those that were not Cc'd but curious about this work
>> so far, you can read the patches here:
>>
>> Original cover letter:
>>
>> https://lkml.kernel.org/r/1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com
>>
>> https://marc.info/?l=linux-kernel&m=147146213519750&w=2 - patch 1
>> https://marc.info/?l=linux-kernel&m=147146209019744&w=2 - patch 2
>> https://marc.info/?l=linux-kernel&m=147146211819747&w=2 - patch 3
>> https://marc.info/?l=linux-kernel&m=147146209119745&w=2 - patch 4
>> https://marc.info/?l=linux-kernel&m=147146209519746&w=2 - patch 5
>>
>> There are a few situations in which you may want to extract a
>> subset of Kconfig CONFIG_* symbols for a system. At least when
>> only considering modules:
>>
>>  a) When optimizing build requirements for a kernel for a system.
>>     That is you boot into a distro kernel and then want to build
>>     a slim kernel only with sensible kernel configuration options.
>>
>>  b) When you are on a distribution kernel but the distribution
>>     kernel provided lacks hardware support for your device, you
>>     may either want to upgrade the full kernel in which case you
>>     want to do a) or -- you may want to just a backports release
>>     which provides just the modules you need, you'd use it on top
>>     of the distribution kernel.
>
> c) Having the mapping in sysfs would allow to simplify
> streamline_config.pl avoid parsing Makefiles in perl. Only if the patch
> did not depend on streamline_config.pl :). One idea would be to generate
> the Module.ksymb in a similar way we generate the modules.builtin file:
> Generate an alternate include/config/*.conf with all CONFIG_FOO=m
> replaced with
>
> CONFIG_FOO=m-CONFIG_FOO
>
> and in the Makefile, iterate over $(filter m-CONFIG_%, $(.VARIABLES)) to
> create the mapping. This would also properly cover cases where we build
> the $(obj-m) list from another list. It would certainly create other
> corner cases, but it's worth trying IMO.
>

That's interesting.

> Another thing is that we do not necessarily need to record this
> information in .modinfo, but we can generate a list in
> /lib/modules/`uname -r`/ for consumption. It could also include drivers
> that are builtin in the current configuration.
>
> Michal

Thank you,

Cristina
--
To unsubscribe from this list: send the line "unsubscribe backports" in
