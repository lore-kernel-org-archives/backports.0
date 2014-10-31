Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:1458 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646AbaJaT0w (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 31 Oct 2014 15:26:52 -0400
Message-ID: <5453E279.4080508@broadcom.com> (sfid-20141031_202653_968358_7BF0A4D6)
Date: Fri, 31 Oct 2014 20:26:49 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Renato <renatoriolino@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: compat-drivers-3.8.3-2-snpu with kernel 2.6.24
References: <CAG_2TMdYXqO5bRC7gmjY-yZzw-KJQDc2bzsGKj6cdygYPGW1Jw@mail.gmail.com>	<5453DCF4.9040101@broadcom.com> <CAG_2TMdhykKiZDKLNVxcYkcZRXTQON6tAZ2SMdf0c4JgAk+Rgg@mail.gmail.com>
In-Reply-To: <CAG_2TMdhykKiZDKLNVxcYkcZRXTQON6tAZ2SMdf0c4JgAk+Rgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

+ backport list

Please keep the list in the loop.

On 10/31/14 20:08, Renato wrote:
> Arend,
>
> After doing a make install, only compat.ko and
> compat_firmware_class.ko was generated.
>
> I thought it was an unified driver and because of that no alx.ko was needed.
>
> Searching on source tree for "alx*", only the source code was found on
> ./drivers/net/ethernet/atheros/alx (no kernel module).
>
> Before making, I've called the script driver-select with alx as parameter.
>
> Do you hane any ideia why the alx.ko module was not build them?

It has been a while since I used the "old" compat-drivers stuff. I guess 
you need to for 2.6.24 support. You should check 
drivers/net/ethernet/atheros/Makefile.

Gr. AvS

> Thanks
>
> 2014-10-31 17:03 GMT-02:00 Arend van Spriel<arend@broadcom.com>:
>> On 10/31/14 19:40, Renato wrote:
>>>
>>> Hi,
>>>
>>> I have and old Linux system built from scratch based on kernel 2.6.24
>>> and I need to add support on it for an Atheros ethernet card that
>>> doesnt have driver for kernel 2.6.24.
>>>
>>> Unfortunately we can't update the kernel because my client has a
>>> control hardware that only have binary e propertery driver for 2.6.24.
>>>
>>> Because of that, I'm trying to use compat-drivers to do that.
>>>
>>> What I did so far was:
>>>
>>> Downloaded compat-drivers-3.8.3-2-snpu and extraceted it.
>>> Compiled it using:
>>>
>>> ./scripts/driver-select alx
>>> make
>>> make install
>>>
>>> After rebooting, I loaded the compat driver with:
>>>
>>> modprobe compat
>>>
>>> I can see the following on dmesg:
>>>
>>> Compat-drivers backport release: compat-drivers-v3.8.3-2-snpu
>>> Backport based on linux-stable.git v3.8.3
>>> compat.git: linux-stable.git
>>>
>>> Nothing more. And no eth yet.
>>>
>>> What I am missing?
>>
>>
>> After loading compat you have the glue layer in place to load the actual
>> 3.8.3 drivers on 2.6.24. So your next step would be to modprobe the alx
>> driver or whatever it is called.
>>
>> Regards,
>> Arend
>>>
>>> Thanks
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

