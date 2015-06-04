Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33702 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbFDJQh (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 4 Jun 2015 05:16:37 -0400
Received: by padj3 with SMTP id j3so25792262pad.0
        for <backports@vger.kernel.org>; Thu, 04 Jun 2015 02:16:36 -0700 (PDT)
From: Bhuvanchandra DV <bhuvanchandradv@gmail.com>
Message-ID: <5570176B.2050709@gmail.com> (sfid-20150604_111640_554528_6EC26AA3)
Date: Thu, 04 Jun 2015 14:46:27 +0530
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Kernel backports mailinglist <backports@vger.kernel.org>
CC: bhuvanchandra.dv@gmail.com
Subject: Re: Issubh while integrating backports(20150525) to target Kernel
 3.1.10
References: <556D9D89.2020500@gmail.com> <556F4819.3020706@hauke-m.de>
In-Reply-To: <556F4819.3020706@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello Hauke,

On 06/04/2015 12:01 AM, Hauke Mehrtens wrote:

> On 06/02/2015 02:11 PM, Bhuvan wrote:
>> Hello,
>>
>> I'm trying to integrate backports(20150525) to target Kernel 3.1.10.
>> Followed the instructions available in the backports wiki for kernel
>> integration procedure. Nice! documentation.
>> Used linux-next.git, backports.git with next-20150525 and
>> backports-20150525 tags respectively.
>> The target Linux kernel version is based on NVIDIA's L4T and it was not
>> a clean 3.1 baseline but
>> rather some pre 3.2 version with further Android additions.
>> My aim is to backport the iwlwifi drivers on 3.1.10 kernel.
>>
>> Backporting 20150525 on 3.1.10 using gentree.py was not successful:
>>
>> # ./gentree.py --integrate --clean --gitdebug --git-revision
>> next-20150525 ../linux-next ~/linux
>> Get original source files from git ...
>> Applying patches from patches to ~/backports ...
>> Modify Kconfig tree ...
>> Rewrite Makefiles and Kconfig files ...
>> Applying patches from integration-patches/ to ~/linux ...
>> Failed to apply changes from
>> 001-enable-backports/0001-enable-backports-built-in.patch
>>> patching file Makefile
>>> Hunk #1 succeeded at 506 (offset -36 lines).
>>> Hunk #2 succeeded at 713 (offset -108 lines).
>>> Hunk #3 FAILED at 841.
>>> 1 out of 3 hunks FAILED -- saving rejects to file Makefile.rej
>> Traceback (most recent call last):
>>    File "./gentree.py", line 1091, in <module>
>>      ret = _main()
>>    File "./gentree.py", line 724, in _main
>>      logwrite=logwrite)
>>    File "./gentree.py", line 1078, in process
>>      bpid.project_dir, logwrite)
>>    File "./gentree.py", line 552, in apply_patches
>>      raise Exception('Patch failed')
>> Exception: Patch failed
>> ....
>>
>> Makefile.ref :
>>
>> --- Makefile
>> +++ Makefile
>> @@ -841,7 +845,7 @@ libs-y        := $(libs-y1) $(libs-y2)
>>
>>   # Externally visible symbols (used by link-vmlinux.sh)
>>   export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
>> -export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
>> +export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
>> $(backports-y)
>>   export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
>>   export LDFLAGS_vmlinux
>>   # used by scripts/pacmage/Makefile
>>
>> Am i missing some thing or doing some thing wrong!.
>> Can some one provide few pointers for fixing the issues and few pointers
>> on backporting kernel integration
>> on non standard kernel trees, like the one which i am working on.
>>
>> Best regards,
>> Bhuvan
> I think the documentation is not so good. ;-)
:-)
>
> If you just want to compile the drivers against your kernel the easiest
> way is to download the tar from here:
> http://www.kernel.org/pub/linux/kernel/projects/backports/2015/05/25/backports-20150525.tar.xz
>
> You can compile it against your kernel like any other external kernel
> module.
> The git repository is only needed if you want to generate your own tar
> with the drivers form your kernel.

Agreed, but I'm using it for integrating the backport drivers with kernel instead of using them as kernel modules.
Followed as per the instructions here: https://backports.wiki.kernel.org/index.php/Documentation/integration

Using the backport-20150525 tar, compilation fails:

Log:

|dvb|make defconfig-wifi                                                                                  []
Generating local configuration database from kernel ... done.
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o conf.o conf.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o zconf.tab.o zconf.tab.c
In file included from zconf.tab.c:2503:0:
menu.c: In function ‘get_symbol_str’:
menu.c:561:18: warning: ‘jump’ may be used uninitialized in this function [-Wmaybe-uninitialized]
      jump->offset = r->len - 1;
                   ^
In file included from zconf.tab.c:2503:0:
menu.c:515:19: note: ‘jump’ was declared here
   struct jump_key *jump;
                    ^
cc   conf.o zconf.tab.o   -o conf
boolean symbol HWMON tested for 'm'? test forced to 'n'
boolean symbol HWMON tested for 'm'? test forced to 'n'
#
# configuration written to .config
#
|dvb|make                                                                                                 []
make[5]: 'conf' is up to date.
boolean symbol HWMON tested for 'm'? test forced to 'n'
boolean symbol HWMON tested for 'm'? test forced to 'n'
#
# configuration written to .config
#
Building backport-include/backport/autoconf.h ... done.
   CC [M]  /home/bhuvan/backports-20150525/compat/main.o
/home/bhuvan/backports-20150525/compat/main.c:51:1: warning: data definition has no type or storage class [enabled by default]
/home/bhuvan/backports-20150525/compat/main.c:51:1: warning: type defaults to ‘int’ in declaration of ‘EXPORT_SYMBOL_GPL’ [-Wimplicit-int]
/home/bhuvan/backports-20150525/compat/main.c:51:1: warning: parameter names (without types) in function declaration [enabled by default]
   CC [M]  /home/bhuvan/backports-20150525/compat/backport-3.2.o
/home/bhuvan/backports-20150525/compat/backport-3.2.c:25:1: warning: data definition has no type or storage class [enabled by default]
/home/bhuvan/backports-20150525/compat/backport-3.2.c:25:1: warning: type defaults to ‘int’ in declaration of ‘EXPORT_SYMBOL_GPL’ [-Wimplicit-int]
/home/bhuvan/backports-20150525/compat/backport-3.2.c:25:1: warning: parameter names (without types) in function declaration [enabled by default]
   CC [M]  /home/bhuvan/backports-20150525/compat/compat-3.3.o
In file included from /home/bhuvan/backports-20150525/backport-include/linux/device.h:4:0,
                  from include/linux/dmaengine.h:24,
                  from include/linux/skbuff.h:30,
                  from /home/bhuvan/backports-20150525/backport-include/linux/skbuff.h:3,
                  from /home/bhuvan/backports-20150525/compat/compat-3.3.c:13:
include/linux/device.h: In function ‘root_device_register’:
include/linux/device.h:724:38: error: ‘THIS_MODULE’ undeclared (first use in this function)
include/linux/device.h:724:38: note: each undeclared identifier is reported only once for each function it appears in
/home/bhuvan/backports-20150525/compat/compat-3.3.c: At top level:
/home/bhuvan/backports-20150525/compat/compat-3.3.c:166:1: warning: data definition has no type or storage class [enabled by default]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:166:1: warning: type defaults to ‘int’ in declaration of ‘EXPORT_SYMBOL_GPL’ [-Wimplicit-int]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:166:1: warning: parameter names (without types) in function declaration [enabled by default]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:206:1: warning: data definition has no type or storage class [enabled by default]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:206:1: warning: type defaults to ‘int’ in declaration of ‘EXPORT_SYMBOL_GPL’ [-Wimplicit-int]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:206:1: warning: parameter names (without types) in function declaration [enabled by default]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:226:1: warning: data definition has no type or storage class [enabled by default]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:226:1: warning: type defaults to ‘int’ in declaration of ‘EXPORT_SYMBOL_GPL’ [-Wimplicit-int]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:226:1: warning: parameter names (without types) in function declaration [enabled by default]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:239:1: warning: data definition has no type or storage class [enabled by default]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:239:1: warning: type defaults to ‘int’ in declaration of ‘EXPORT_SYMBOL_GPL’ [-Wimplicit-int]
/home/bhuvan/backports-20150525/compat/compat-3.3.c:239:1: warning: parameter names (without types) in function declaration [enabled by default]
scripts/Makefile.build:305: recipe for target '/home/bhuvan/backports-20150525/compat/compat-3.3.o' failed
make[6]: *** [/home/bhuvan/backports-20150525/compat/compat-3.3.o] Error 1
scripts/Makefile.build:441: recipe for target '/home/bhuvan/backports-20150525/compat' failed
make[5]: *** [/home/bhuvan/backports-20150525/compat] Error 2
Makefile:1361: recipe for target '_module_/home/bhuvan/backports-20150525' failed
make[4]: *** [_module_/home/bhuvan/backports-20150525] Error 2
Makefile.build:6: recipe for target 'modules' failed
make[3]: *** [modules] Error 2
Makefile.real:88: recipe for target 'modules' failed
make[2]: *** [modules] Error 2
Makefile:40: recipe for target 'modules' failed
make[1]: *** [modules] Error 2
Makefile:30: recipe for target 'default' failed
make: *** [default] Error 2
...

CONFIG_MODULES is enabled in .config file

|dvb|cat /home/bhuvan/linux-tegra/.config|grep CONFIG_MODULE
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODULE_SRCVERSION_ALL=y

>
> Hauke
>
Best regards,

Bhuvan

