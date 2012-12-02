Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57299 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab2LBQmD (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Dec 2012 11:42:03 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1378292pad.19
        for <backports@vger.kernel.org>; Sun, 02 Dec 2012 08:42:03 -0800 (PST)
Message-ID: <50BB84D3.9050402@gmail.com>
Date: Mon, 03 Dec 2012 00:41:55 +0800
From: Shuo <shuox.liu@gmail.com>
Reply-To: shuox.liu@gmail.com
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: backports@vger.kernel.org
Subject: Re: Build compat-wireless for linus tree
References: <50A675EE.9010406@gmail.com> <50A79668.2060901@hauke-m.de> <50B4C158.3020701@gmail.com> <50B4D99B.8000308@gmail.com> <50B8C954.2090507@hauke-m.de>
In-Reply-To: <50B8C954.2090507@hauke-m.de>
Content-Type: text/plain; charset=GB2312
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/30/2012 10:57 PM, Hauke Mehrtens wrote:

> On 11/27/2012 04:17 PM, Shuo wrote:
>> Hi Hauke,
>> Sorry for disturb again.
>> I am trying compat-wireless-2012-11-25 for v3.7-rc7, but it fails.
>> I downloaded the tar package and unpackaged, driver-select b43, make
>> Some logs:
>>
>> Processing new driver-select request...
>> Backing up makefile: Makefile.bk
>> Backup exists: Makefile.bk
>> Backup exists: Makefile.bk
>> Backup exists: Makefile.bk
>> Backing up makefile: drivers/misc/eeprom/Makefile.bk
>> Backing up makefile: net/wireless/Makefile.bk
>> Backing up makefile: drivers/net/wireless/Makefile.bk
>> ./scripts/gen-compat-autoconf.sh /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/.config /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/config.mk > include/linux/compat_autoconf.h
>> make -C /lib/modules/3.7.0-rc7-shuo-main+//build M=/home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25 modules
>> make[1]: Entering directory `/home/lskakaxi/work/linux/kernel_build'
>> /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/config.mk:247: "WARNING: CONFIG_CFG80211_WEXT will be deactivated or not working because kernel was compiled with CONFIG_WIRELESS_EXT=n. Tools using wext interface like iwconfig will not work. To activate it build your kernel e.g. with CONFIG_LIBIPW=m."
>>   CC [M]  /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/compat/main.o
>> In file included from /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/pm_qos.h:9:0,
>>                  from /home/lskakaxi/work/linux/linux/include/linux/netdevice.h:28,
>>                  from /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/compat-2.6.29.h:5,
>>                  from /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/compat-2.6.h:50,
>>                  from <command-line>:0:
>> /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/pm_qos_params.h:7:38: fatal error: linux/pm_qos_params.h: No such file or directory
>> compilation terminated.
>>
>> I found the linux/pm_qos_params.h has been renamed to pm_qos.h one year ago. I am confused why compat-wirelss need this old header.
>> Anything i missed?
>>
>> Shuo
>>
> Hi Shuo,
> 
> There seams to be something wrong with your kernel. The include done in
> include/linux/pm_qos.h:9:0 should not happen on your kernel version.
> 
> Does include/generated/uapi/linux/version.h in your kernel directory
> contains #define LINUX_VERSION_CODE 197895 or does it contain some other
> number?
> 

The problem had been resolved.
There is an old LINUX_VERSION_CODE in the version.h. So i clean the
kernel tree and make a full compile again. The errors above went away.
Another thing is i found the latest compat driver contains some
graphics drivers. When i install a wireless driver, such as b43, the
graphics drivers also will be installed. That will break my original
in-tree graphic drivers dep and caused some issue when X startup.
So now, i turn to use latest wireless and graphic in-tree drivers with
the latest kernel. They work well.
Thanks, again!

> Hauke

Shuo
