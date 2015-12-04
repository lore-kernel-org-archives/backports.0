Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35662 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756561AbbLDVZQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 4 Dec 2015 16:25:16 -0500
Subject: Re: [PATCH v2] backports: add ktime_get_boot_ns()
To: Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend@broadcom.com>,
	backports@vger.kernel.org
References: <1449046594-9738-1-git-send-email-johannes@sipsolutions.net>
 <1449046985.2449.0.camel@sipsolutions.net>
 <1449047089.2449.1.camel@sipsolutions.net> <565EC8F7.4030800@broadcom.com>
 <1449053189.2449.8.camel@sipsolutions.net> <56620234.8010104@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <566204B9.2090606@hauke-m.de> (sfid-20151204_222525_846066_6FF48E5F)
Date: Fri, 4 Dec 2015 22:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <56620234.8010104@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/04/2015 10:14 PM, Hauke Mehrtens wrote:
> On 12/02/2015 11:46 AM, Johannes Berg wrote:
>> On Wed, 2015-12-02 at 11:33 +0100, Arend van Spriel wrote:
>>>  
>>> Got a feeling I missing a side of this story. Still got a feeling you
>>> need more coffee ;-)
>>>
>>
>> Yep! I don't drink coffee though, so I'll have to make do with
>> something else ;-)
>>
>> johannes
>> --
>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>
> Hi Johannes,
> 
> I am getting this error with your patch on kernel 4.3:
> 
> hauke@hauke-desktop:~/compat-wireless/tmp$ ionice -c 3 nice -n 20 make V=99
>   CC [M]  /home/hauke/compat-wireless/tmp/compat/main.o
> In file included from include/linux/hrtimer.h:18:0,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/timekeeping.h:5,
>                  from include/linux/ktime.h:297,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/ktime.h:3,
>                  from include/linux/rcupdate.h:47,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/rcupdate.h:3,
>                  from include/linux/srcu.h:33,
>                  from include/linux/notifier.h:15,
>                  from include/linux/memory_hotplug.h:6,
>                  from include/linux/mmzone.h:812,
>                  from include/linux/gfp.h:5,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/gfp.h:3,
>                  from include/linux/kmod.h:22,
>                  from include/linux/module.h:13,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/module.h:3,
>                  from /home/hauke/compat-wireless/tmp/compat/main.c:1:
> include/linux/rbtree.h: In function ‘rb_link_node_rcu’:
> include/linux/rbtree.h:95:2: error: implicit declaration of function
> ‘rcu_assign_pointer’ [-Werror=implicit-function-declaration]
>   rcu_assign_pointer(*rb_link, node);
>   ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:258: recipe for target
> '/home/hauke/compat-wireless/tmp/compat/main.o' failed
> make[6]: *** [/home/hauke/compat-wireless/tmp/compat/main.o] Error 1
> scripts/Makefile.build:403: recipe for target
> '/home/hauke/compat-wireless/tmp/compat' failed
> make[5]: *** [/home/hauke/compat-wireless/tmp/compat] Error 2
> Makefile:1378: recipe for target
> '_module_/home/hauke/compat-wireless/tmp' failed
> make[4]: *** [_module_/home/hauke/compat-wireless/tmp] Error 2
> Makefile.build:6: recipe for target 'modules' failed
> make[3]: *** [modules] Error 2
> Makefile.real:88: recipe for target 'modules' failed
> make[2]: *** [modules] Error 2
> Makefile:40: recipe for target 'modules' failed
> make[1]: *** [modules] Error 2
> Makefile:30: recipe for target 'default' failed
> make: *** [default] Error 2
> hauke@hauke-desktop:~/compat-wireless/tmp$ uname -a
> Linux hauke-desktop 4.3.0+ #3 SMP Tue Nov 3 20:56:24 CET 2015 x86_64
> GNU/Linux
> hauke@hauke-desktop:~/compat-wireless/tmp$
> 

On 3.10 I am gettng a different error message

hauke@hauke-desktop:~/compat-wireless/tmp$ ionice -c 3 nice -n 20 make
KLIB=/lib/modules/3.10.92-031092-generic V=99
  CC [M]  /home/hauke/compat-wireless/tmp/compat/main.o
In file included from
/home/hauke/compat-wireless/tmp/backport-include/linux/pm.h:3:0,
                 from
/usr/src/linux-headers-3.10.92-031092-generic/arch/x86/include/asm/apic.h:5,
                 from
/usr/src/linux-headers-3.10.92-031092-generic/arch/x86/include/asm/smp.h:13,
                 from include/linux/smp.h:38,
                 from include/linux/percpu.h:5,
                 from include/linux/hrtimer.h:23,
                 from
/home/hauke/compat-wireless/tmp/backport-include/linux/timekeeping.h:5,
                 from
/home/hauke/compat-wireless/tmp/backport-include/linux/ktime.h:4,
                 from include/linux/timer.h:5,
                 from include/linux/workqueue.h:8,
                 from
/home/hauke/compat-wireless/tmp/backport-include/linux/workqueue.h:3,
                 from include/linux/srcu.h:34,
                 from include/linux/notifier.h:15,
                 from include/linux/memory_hotplug.h:6,
                 from include/linux/mmzone.h:771,
                 from include/linux/gfp.h:4,
                 from
/home/hauke/compat-wireless/tmp/backport-include/linux/gfp.h:3,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from
/home/hauke/compat-wireless/tmp/backport-include/linux/module.h:3,
                 from /home/hauke/compat-wireless/tmp/compat/main.c:1:
include/linux/pm.h:537:20: error: field ‘suspend_timer’ has incomplete type
  struct timer_list suspend_timer;
                    ^
include/linux/pm.h:539:21: error: field ‘work’ has incomplete type
  struct work_struct work;
                     ^
scripts/Makefile.build:308: recipe for target
'/home/hauke/compat-wireless/tmp/compat/main.o' failed
make[6]: *** [/home/hauke/compat-wireless/tmp/compat/main.o] Error 1
scripts/Makefile.build:455: recipe for target
'/home/hauke/compat-wireless/tmp/compat' failed
make[5]: *** [/home/hauke/compat-wireless/tmp/compat] Error 2
Makefile:1228: recipe for target
'_module_/home/hauke/compat-wireless/tmp' failed
make[4]: *** [_module_/home/hauke/compat-wireless/tmp] Error 2
Makefile.build:6: recipe for target 'modules' failed
make[3]: *** [modules] Error 2
Makefile.real:88: recipe for target 'modules' failed
make[2]: *** [modules] Error 2
Makefile:40: recipe for target 'modules' failed
make[1]: *** [modules] Error 2
Makefile:30: recipe for target 'default' failed
make: *** [default] Error 2
hauke@hauke-desktop:~/compat-wireless/tmp$

I tried to understand the first error but failed, do you know better
what is wrong there?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
