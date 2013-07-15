Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:56356 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237Ab3GOOr3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 15 Jul 2013 10:47:29 -0400
Received: by mail-ve0-f181.google.com with SMTP id db10so9776669veb.40
        for <backports@vger.kernel.org>; Mon, 15 Jul 2013 07:47:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51E403A5.9060607@hauke-m.de>
References: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com>
	<51E3FF49.50301@hauke-m.de>
	<CAOvdn6UmT+gaEgxfrhNt=fYDs-ikKykEJRJ-GbA3VJWdB3MPgg@mail.gmail.com>
	<51E403A5.9060607@hauke-m.de>
Date: Mon, 15 Jul 2013 10:47:28 -0400
Message-ID: <CAOvdn6XLUq1ypCRGfST1zrA1KDsj+nZw_xz=Yt3YF4fHp2Xz+g@mail.gmail.com> (sfid-20130715_164731_382528_7C915400)
Subject: Re: problems building backports-3.10-2
From: Ben Guthro <ben@guthro.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jul 15, 2013 at 10:13 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 07/15/2013 04:01 PM, Ben Guthro wrote:
>> On Mon, Jul 15, 2013 at 9:55 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>> On 07/15/2013 03:08 PM, Ben Guthro wrote:
>>>> I'm struggling to integrate the backports-3.10-2 release into my
>>>> build, and I'm hoping this is the proper venue to get some answers.
>>>>
>>>> 1. The build is complaining about ./gentree.py and local symbols. I
>>>> did not see gentree.py anywhere in the code released.
>>>>
>>>> Even when removing this section of the Makefile, I am able to get a
>>>> bit further, to try to do a 'make menuconfig'
>>>> This does not present the options I expected - offering only the
>>>> following options:
>>>>
>>>> Build all compat code
>>>> Voltage and Current Regulator Support
>>>>
>>>>
>>>> I also tried the some of the defconfigs (like iwlwifi) - but these
>>>> seem to only build the compat.ko, and nothing else.
>>>>
>>>>
>>>> Am I doing something wrong - or is something broken in this release?
>>>
>>> What source are you using?
>>
>> I downloaded the released backports-3.10-2.tar.bz2 file from the
>> stable releases page here:
>> http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/
>>
>
> Could you please post the error messages you get with a unmodified
> version of backports-3.10-2.tar.bz2.

This output is from trying to build against a built, but not installed kernel:

KLIB=/data/home/bguthro/dev/orc-precise/orc-kernel/../linux/build/kernel/lib/modules/3.8.13-orc
\
	KLIB_BUILD=/data/home/bguthro/dev/orc-precise/orc-kernel/../linux/build/kernel
\
	make -j8 EXTRAVERSION= V=1 -C compat-drivers modules
make[1]: Entering directory
`/data/home/bguthro/dev/orc-precise/orc-kernel/compat-drivers'
/--------------
| You shouldn't run make in the backports tree, but only in
| the generated output. This here is only the skeleton code
| copied into the output directory. To use the backport system
| from scratch, go into the top-level directory and run
|	./gentree.py /path/to/linux-next/ /tmp/output
| and then make menuconfig/... in the output directory. See
|	./gentree.py --help
| for more options.
\--


As Johannes posted, I suspect it is something to do with the .local-symbols
However, I'm not sure how this gets built, in the case of a kernel
that is not installed.


Any advice is appreciated.

Ben
