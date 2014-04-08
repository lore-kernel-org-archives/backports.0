Return-path: <backports-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:63523 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643AbaDHQVQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 8 Apr 2014 12:21:16 -0400
Received: by mail-bk0-f48.google.com with SMTP id mx12so704861bkb.7
        for <backports@vger.kernel.org>; Tue, 08 Apr 2014 09:21:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53441C3D.8060509@iki.fi>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
 <1396927943-25589-9-git-send-email-mcgrof@do-not-panic.com>
 <20140408094352.202fabb3@samsung.com> <53441C3D.8060509@iki.fi>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 8 Apr 2014 09:20:54 -0700
Message-ID: <CAB=NE6W=1xyU1QqpmsaeX0x7EqkhN2Et9RtsGsn5w-1gaMbVhA@mail.gmail.com> (sfid-20140408_182118_592570_567FCB58)
Subject: Re: [PATCH 08/12] backports: disable DVB_RTL2832 and DVB_USB_RTL28XXU
To: Antti Palosaari <crope@iki.fi>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 8, 2014 at 8:56 AM, Antti Palosaari <crope@iki.fi> wrote:
> On 08.04.2014 15:43, Mauro Carvalho Chehab wrote:
>> Em Mon, 07 Apr 2014 20:32:19 -0700
>> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> escreveu:
>>>
>>> Commit bcf43393 as of linux-next next-20140320 added this Makefile
>>> header extension:
>>>
>>> ccflags-y += -I$(srctree)/drivers/staging/media/rtl2832u_sdr
>>>
>>> This ends up calling a staging exported symbol rtl2832_sdr_attach().
>>> Let's not pollute driver code with staging code or dependencies.
>>>
>>> Folks, can this be cleaned up? This sets a precedent for doing more
>>> of this, and this can get hairy. Its also not fair for folks who
>>> don't want to carry over any staging code. This forces them to, and
>>> its not just a header file, its a full exported symbol. What about
>>> synchronization with differen trees? Was this addressed with Greg?

<-- snip -->

>> The SDR code is at staging not because it has low quality, but because
>> we're still testing the SDR API before setting it into a stone.

I see, so there is no guarantee to userspace on API if the kernel
moves up? Its an interesting usage case for staging, perhaps one of
the better ones :)

>> Antti, please correct if I'm wrong, but the rtl2832u_tuner_attach()
>> code seems to not expect that the attach code succeeds. So, the only thing
>> that will happen DVB_RTL2832_SDR is disabled is that warning saying that
>> SDR is disabled will be sent to dmesg.
>
> That is what happen and IIRC I tested it too once.

I wasn't concerned over compilation but rather setting the precedent
of non staging code depending on staging headers, if this wasn't done
already.

>> So, I don't see why to disable the entire driver due to that. Instead,
>> Just revert changeset bcf43393579e at the backport trees should be enough,
>> if don't want to backport the SDR driver.
>
>
> I will look if I can make mainline rtl28xxu driver compile without a staging
> directory (as that new SDR extension is on staging directory currently).

That'd be swell! While this is one of the best use cases for staging I
am just concerned over abuse over it.

  Luis
