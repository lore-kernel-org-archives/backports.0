Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:62338 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaKCMV2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 3 Nov 2014 07:21:28 -0500
Received: by mail-qa0-f43.google.com with SMTP id j7so8129247qaq.16
        for <backports@vger.kernel.org>; Mon, 03 Nov 2014 04:21:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5453E279.4080508@broadcom.com>
References: <CAG_2TMdYXqO5bRC7gmjY-yZzw-KJQDc2bzsGKj6cdygYPGW1Jw@mail.gmail.com>
	<5453DCF4.9040101@broadcom.com>
	<CAG_2TMdhykKiZDKLNVxcYkcZRXTQON6tAZ2SMdf0c4JgAk+Rgg@mail.gmail.com>
	<5453E279.4080508@broadcom.com>
Date: Mon, 3 Nov 2014 10:21:27 -0200
Message-ID: <CAG_2TMe2QJMqC3OLS-s9o=vdSVQk1U9OktN4mPjGQXSosh737w@mail.gmail.com> (sfid-20141103_132130_233258_6D90367D)
Subject: Re: compat-drivers-3.8.3-2-snpu with kernel 2.6.24
From: Renato <renatoriolino@gmail.com>
To: Arend van Spriel <arend@broadcom.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I checked the Makefile and found that it was not getting called.

Looking at ./include/linux/compat_autoconf.h I found the following:

#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
#ifndef CONFIG_ATL1C
#define CONFIG_ATL1C 1
#endif /* CONFIG_ATL1C */
#ifndef CONFIG_ALX
#define CONFIG_ALX 1
#endif /* CONFIG_ALX */
#ifndef CONFIG_COMPAT_MDIO
#define CONFIG_COMPAT_MDIO 1
#endif /* CONFIG_COMPAT_MDIO */
#endif /* CONFIG_COMPAT_KERNEL_2_6_28 */

Does it means that ALX driver is only supported with kernel 2.6.28 or higher?

Thanks

Renato



2014-10-31 17:26 GMT-02:00 Arend van Spriel <arend@broadcom.com>:
> + backport list
>
> Please keep the list in the loop.
>
> On 10/31/14 20:08, Renato wrote:
>>
>> Arend,
>>
>> After doing a make install, only compat.ko and
>> compat_firmware_class.ko was generated.
>>
>> I thought it was an unified driver and because of that no alx.ko was
>> needed.
>>
>> Searching on source tree for "alx*", only the source code was found on
>> ./drivers/net/ethernet/atheros/alx (no kernel module).
>>
>> Before making, I've called the script driver-select with alx as parameter.
>>
>> Do you hane any ideia why the alx.ko module was not build them?
>
>
> It has been a while since I used the "old" compat-drivers stuff. I guess you
> need to for 2.6.24 support. You should check
> drivers/net/ethernet/atheros/Makefile.
>
> Gr. AvS
>
>
>> Thanks
>>
>> 2014-10-31 17:03 GMT-02:00 Arend van Spriel<arend@broadcom.com>:
>>>
>>> On 10/31/14 19:40, Renato wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> I have and old Linux system built from scratch based on kernel 2.6.24
>>>> and I need to add support on it for an Atheros ethernet card that
>>>> doesnt have driver for kernel 2.6.24.
>>>>
>>>> Unfortunately we can't update the kernel because my client has a
>>>> control hardware that only have binary e propertery driver for 2.6.24.
>>>>
>>>> Because of that, I'm trying to use compat-drivers to do that.
>>>>
>>>> What I did so far was:
>>>>
>>>> Downloaded compat-drivers-3.8.3-2-snpu and extraceted it.
>>>> Compiled it using:
>>>>
>>>> ./scripts/driver-select alx
>>>> make
>>>> make install
>>>>
>>>> After rebooting, I loaded the compat driver with:
>>>>
>>>> modprobe compat
>>>>
>>>> I can see the following on dmesg:
>>>>
>>>> Compat-drivers backport release: compat-drivers-v3.8.3-2-snpu
>>>> Backport based on linux-stable.git v3.8.3
>>>> compat.git: linux-stable.git
>>>>
>>>> Nothing more. And no eth yet.
>>>>
>>>> What I am missing?
>>>
>>>
>>>
>>> After loading compat you have the glue layer in place to load the actual
>>> 3.8.3 drivers on 2.6.24. So your next step would be to modprobe the alx
>>> driver or whatever it is called.
>>>
>>> Regards,
>>> Arend
>>>>
>>>>
>>>> Thanks
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>
