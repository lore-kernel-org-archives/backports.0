Return-path: <backports-owner@vger.kernel.org>
Received: from [178.33.119.222] ([178.33.119.222]:38251 "EHLO mail.wifense.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbaIHKbM (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Sep 2014 06:31:12 -0400
Received: from localhost (unknown [127.0.0.1])
	by mail.wifense.com (Postfix) with ESMTP id 325E72C084C
	for <backports@vger.kernel.org>; Mon,  8 Sep 2014 10:34:36 +0000 (UTC)
Received: from mail.wifense.com ([127.0.0.1])
	by localhost (mail.wifense.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPng5XGRLJsd for <backports@vger.kernel.org>;
	Mon,  8 Sep 2014 12:34:23 +0200 (CEST)
Received: from [172.30.200.107] (230.red-80-28-132.adsl.static.ccgg.telefonica.net [80.28.132.230])
	(Authenticated sender: jcasas@wifense.com)
	by mail.wifense.com (Postfix) with ESMTPSA id 262612C082E
	for <backports@vger.kernel.org>; Mon,  8 Sep 2014 12:34:23 +0200 (CEST)
Message-ID: <540D8563.8020403@wifense.com> (sfid-20140908_123114_643760_9967C57E)
Date: Mon, 08 Sep 2014 12:30:59 +0200
From: Javier Casas Marin <jcasas@wifense.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: Re: error compiling backports-3.14-1: too many arguments to function
 'request_firmware_nowait'
References: <540D6A0A.30609@wifense.com> <540D7A66.5060802@wifense.com>
In-Reply-To: <540D7A66.5060802@wifense.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This time I don't understand what is going on with the error:

/root/modules/backports-3.14-1/net/mac80211/key.c:813: error: implicit 
declaration of function 'atomic64_set'

If I search for this function definition I see it is in compat_atomic.c 
file:

wsos-sdk:~/modules/backports-3.14-1# grep -r --include="*.c" atomic64_set .
./net/mac80211/key.c: atomic64_set(&key->u.ccmp.tx_pn, pn64);
./net/mac80211/key.c: atomic64_set(&key->u.aes_cmac.tx_pn, pn64);
./compat/compat_atomic.c:void atomic64_set(atomic64_t *v, long long i)
./compat/compat_atomic.c:EXPORT_SYMBOL_GPL(atomic64_set);

Now I search for it in the compat Makefile:
wsos-sdk:~/modules/backports-3.14-1# grep compat_atomic.o compat/Makefile
compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o

And I see in .config that I do have that config option enabled:
wsos-sdk:~/modules/backports-3.14-1# grep 
BACKPORT_BUILD_GENERIC_ATOMIC64 .config
CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64=y

and it works because I see tha the compat_atomic.o is generated during 
the compilation so, I guess that the problem is exporting the symbol 
with EXPORT_SYMBOL_GPL(atomic64_set)

any clue about how to solve this?

Javi

El 08/09/2014 11:44, Javier Casas Marin escribió:
>
> Hi,
> after a bit more investigation I  found this:
>
> wsos-sdk:~/modules/backports-3.14-1# grep compat_firmware_class 
> compat/Makefile
> obj-$(CPTCFG_BACKPORT_BUILD_FW_LOADER) += compat_firmware_class.o
>
> so I looked in compat/Kconfig and found this (I didn't find it before 
> because I grep with the CPTCFG_ header):
>
> config BACKPORT_BUILD_FW_LOADER
>     tristate
>     depends on m
>     # RHEL6, starting from 6.0, backports the FW loader already
>     depends on !BACKPORT_RHEL_KERNEL_6_0
>     depends on !FW_LOADER || BACKPORT_KERNEL_2_6_33
>     default m if BACKPORT_FW_LOADER
>     default m if BACKPORT_USERSEL_BUILD_ALL
>
> config BACKPORT_FW_LOADER
>     bool
>
> from here I understand that I have to enable de BACKPORT_FW_LOADER 
> option.
> I haven't found it in menuconfig so I changed it manually in 
> compat/Kconfig to 'def_bool y'
>
> Now the error went away but a new one appeared:
>
>   CC [M]  /root/modules/backports-3.14-1/net/mac80211/key.o
> /root/modules/backports-3.14-1/net/mac80211/key.c: In function 
> 'ieee80211_set_key_tx_seq':
> /root/modules/backports-3.14-1/net/mac80211/key.c:813: error: implicit 
> declaration of function 'atomic64_set'
> make[6]: *** [/root/modules/backports-3.14-1/net/mac80211/key.o] Error 1
> make[5]: *** [/root/modules/backports-3.14-1/net/mac80211] Error 2
> make[4]: *** [_module_/root/modules/backports-3.14-1] Error 2
> make[3]: *** [modules] Error 2
> make[2]: *** [modules] Error 2
> make[1]: *** [modules] Error 2
> make: *** [default] Error 2
>
> I'll try to figure out what happens this time
>
> Javi
>
> El 08/09/2014 10:34, Javier Casas Marin escribió:
>>
>> Hi,
>> when I try to compile backports-3.14-1 in a 2.6.30 kernel I get this 
>> error:
>>
>> /root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c: 
>> In function 'ath9k_eeprom_request':
>> /root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c:647: 
>> warning: passing argument 5 of 'request_firmware_nowait' makes 
>> pointer from integer without a cast
>> /root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c:647: 
>> warning: passing argument 6 of 'request_firmware_nowait' from 
>> incompatible pointer type
>> /root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c:647: 
>> error: too many arguments to function 'request_firmware_nowait'
>> make[8]: *** 
>> [/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.o] Error 
>> 1
>> make[7]: *** 
>> [/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k] Error 2
>> make[6]: *** 
>> [/root/modules/backports-3.14-1/drivers/net/wireless/ath] Error 2
>> make[5]: *** [/root/modules/backports-3.14-1/drivers/net/wireless] 
>> Error 2
>> make[4]: *** [_module_/root/modules/backports-3.14-1] Error 2
>> make[3]: *** [modules] Error 2
>> make[2]: *** [modules] Error 2
>> make[1]: *** [modules] Error 2
>> make: *** [default] Error 2
>>
>> I saw that in backport-include/linux/firmware.h there is a 
>> pre-compiler directive to use the backport's version of 
>> request_firmware_nowait function:
>>
>> #if defined(CPTCFG_BACKPORT_BUILD_FW_LOADER_MODULE)
>> #define request_firmware_nowait LINUX_BACKPORT(request_firmware_nowait)
>>
>> But I haven't found where the CPTCFG_BACKPORT_BUILD_FW_LOADER_MODULE 
>> is defined.
>>
>> I just ran:
>> make defconfig-ath9k
>> make
>>
>> Am I missing a previous configuration step?
>>
>> Thanks!
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe backports" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

