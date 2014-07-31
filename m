Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34513 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaGaQ5Z (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 31 Jul 2014 12:57:25 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so5404145igc.0
        for <backports@vger.kernel.org>; Thu, 31 Jul 2014 09:57:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53D9FD41.2030403@broadcom.com>
References: <CAEsx0Y-CM-HW5F6K7SoOSn0dgReSakvOt_CX_=OV=XoVnerfDw@mail.gmail.com>
	<53D9FD41.2030403@broadcom.com>
Date: Thu, 31 Jul 2014 09:57:24 -0700
Message-ID: <CAEsx0Y-5tArybyciDDHszocp6y1gyFt9B59dCv7S7CBfmQvqkQ@mail.gmail.com> (sfid-20140731_185731_517013_F6EE77A3)
Subject: Re: defconfig-ath9k build
From: Daniel Schultze <kinglag@gmail.com>
To: Arend van Spriel <arend@broadcom.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Yes, I'm trying to build directly on the 'Pi and yes kernel headers
are installed.

On Thu, Jul 31, 2014 at 1:24 AM, Arend van Spriel <arend@broadcom.com> wrote:
> On 30-07-14 22:32, Daniel Schultze wrote:
>> Hey guys I was trying to build ath9k drivers for pidora 20 on my
>> Raspberry Pi but ran into these errors. I don't have any Idea what do
>> to with them, could you tell me how I could resolve them:
>
> Are you trying to build this on your raspberry pi? Do you have kernel
> headers installed?
>
> Regards,
> Arend
>
>> uname -r
>> 3.12.23-2.20140626git25673c3.rpfr20.armv6hl.bcm2708
>> make defconfig-ath9k
>> make
>> make[5]: `conf' is up to date.
>> boolean symbol HWMON tested for 'm'? test forced to 'n'
>> boolean symbol HWMON tested for 'm'? test forced to 'n'
>> #
>> # configuration written to .config
>> #
>> Building backport-include/backport/autoconf.h ... done.
>>   CC [M]  /home/dschultze/Downloads/backports-3.15.1-1/compat/main.o
>> In file included from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/backport/backport.h:4:0,
>>                  from <command-line>:0:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kconfig.h:4:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kconfig.h:4:27:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
>>                            ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kconfig.h:4:41:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
>>                                          ^
>> In file included from include/linux/module.h:9:0,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/list.h:6:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/list.h:6:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/list.h:6:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
>>                                         ^
>> In file included from include/linux/linkage.h:6:0,
>>                  from include/linux/kernel.h:6,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kernel.h:3,
>>                  from include/linux/cache.h:4,
>>                  from include/linux/time.h:4,
>>                  from include/linux/stat.h:18,
>>                  from include/linux/module.h:10,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/export.h:7:6:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
>>       ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/export.h:7:28:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
>>                             ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/export.h:7:42:
>> error: missing binary operator before token "("
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
>>                                           ^
>> In file included from include/linux/dynamic_debug.h:111:0,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/dynamic_debug.h:4,
>>                  from include/linux/printk.h:236,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/printk.h:5,
>>                  from include/linux/kernel.h:13,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kernel.h:3,
>>                  from include/linux/cache.h:4,
>>                  from include/linux/time.h:4,
>>                  from include/linux/stat.h:18,
>>                  from include/linux/module.h:10,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/string.h:6:6:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
>>       ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/string.h:6:27:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
>>                            ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/string.h:6:41:
>> error: missing binary operator before token "("
>>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0))
>>                                          ^
>> In file included from include/linux/printk.h:236:0,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/printk.h:5,
>>                  from include/linux/kernel.h:13,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kernel.h:3,
>>                  from include/linux/cache.h:4,
>>                  from include/linux/time.h:4,
>>                  from include/linux/stat.h:18,
>>                  from include/linux/module.h:10,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/dynamic_debug.h:6:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/dynamic_debug.h:6:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/dynamic_debug.h:6:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
>>                                         ^
>> In file included from include/linux/kernel.h:13:0,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kernel.h:3,
>>                  from include/linux/cache.h:4,
>>                  from include/linux/time.h:4,
>>                  from include/linux/stat.h:18,
>>                  from include/linux/module.h:10,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/printk.h:9:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/printk.h:9:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/printk.h:9:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
>>                                         ^
>> In file included from include/linux/cache.h:4:0,
>>                  from include/linux/time.h:4,
>>                  from include/linux/stat.h:18,
>>                  from include/linux/module.h:10,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kernel.h:114:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kernel.h:114:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/kernel.h:114:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
>>                                         ^
>> In file included from include/linux/atomic.h:4:0,
>>                  from include/linux/spinlock.h:392,
>>                  from include/linux/seqlock.h:35,
>>                  from include/linux/time.h:5,
>>                  from include/linux/stat.h:18,
>>                  from include/linux/module.h:10,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/asm/atomic.h:6:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/asm/atomic.h:6:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/asm/atomic.h:6:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
>>                                         ^
>> In file included from include/linux/stat.h:19:0,
>>                  from include/linux/module.h:10,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/uidgid.h:1:6:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
>>       ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/uidgid.h:1:28:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
>>                             ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/uidgid.h:1:42:
>> error: missing binary operator before token "("
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
>>                                           ^
>> In file included from include/linux/rcupdate.h:43:0,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/rcupdate.h:3,
>>                  from include/linux/srcu.h:33,
>>                  from include/linux/notifier.h:15,
>>                  from include/linux/memory_hotplug.h:6,
>>                  from include/linux/mmzone.h:797,
>>                  from include/linux/gfp.h:4,
>>                  from include/linux/kmod.h:22,
>>                  from include/linux/module.h:13,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/completion.h:6:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/completion.h:6:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/completion.h:6:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
>>                                         ^
>> In file included from include/linux/srcu.h:33:0,
>>                  from include/linux/notifier.h:15,
>>                  from include/linux/memory_hotplug.h:6,
>>                  from include/linux/mmzone.h:797,
>>                  from include/linux/gfp.h:4,
>>                  from include/linux/kmod.h:22,
>>                  from include/linux/module.h:13,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/rcupdate.h:44:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/rcupdate.h:44:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/rcupdate.h:44:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
>>                                         ^
>> In file included from include/linux/srcu.h:34:0,
>>                  from include/linux/notifier.h:15,
>>                  from include/linux/memory_hotplug.h:6,
>>                  from include/linux/mmzone.h:797,
>>                  from include/linux/gfp.h:4,
>>                  from include/linux/kmod.h:22,
>>                  from include/linux/module.h:13,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:6:6:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
>>       ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:6:27:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
>>                            ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:6:41:
>> error: missing binary operator before token "("
>>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
>>                                          ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:17:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:17:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:17:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
>>                                         ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:57:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:57:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/workqueue.h:57:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
>>                                         ^
>> In file included from include/linux/tracepoint.h:20:0,
>>                  from include/linux/module.h:18,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/static_key.h:6:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) /* kernels >= 3.3 */
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/static_key.h:6:27:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) /* kernels >= 3.3 */
>>                            ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/static_key.h:6:41:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) /* kernels >= 3.3 */
>>                                          ^
>> In file included from include/linux/module.h:18:0,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:3,
>>                  from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:
>> include/linux/tracepoint.h:32:20: error: field 'key' has incomplete type
>>   struct static_key key;
>>                     ^
>> In file included from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:1:0:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:62:5:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
>>      ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:62:26:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
>>                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/module.h:62:40:
>> error: missing binary operator before token "("
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
>>                                         ^
>> In file included from
>> /home/dschultze/Downloads/backports-3.15.1-1/compat/main.c:4:0:
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/pm_qos.h:6:6:
>> warning: "LINUX_VERSION_CODE" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
>>       ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/pm_qos.h:6:28:
>> warning: "KERNEL_VERSION" is not defined [-Wundef]
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
>>                             ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/pm_qos.h:6:42:
>> error: missing binary operator before token "("
>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
>>                                           ^
>> /home/dschultze/Downloads/backports-3.15.1-1/backport-include/linux/pm_qos.h:9:33:
>> fatal error: linux/pm_qos_params.h: No such file or directory
>>  #include <linux/pm_qos_params.h>
>>                                  ^
>> compilation terminated.
>> make[6]: *** [/home/dschultze/Downloads/backports-3.15.1-1/compat/main.o]
>> Error 1
>> make[5]: *** [/home/dschultze/Downloads/backports-3.15.1-1/compat] Error 2
>> make[4]: *** [_module_/home/dschultze/Downloads/backports-3.15.1-1] Error 2
>> make[3]: *** [modules] Error 2
>> make[2]: *** [modules] Error 2
>> make[1]: *** [modules] Error 2
>> make: *** [default] Error 2
>> --
>> To unsubscribe from this list: send the line "unsubscribe backports" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
