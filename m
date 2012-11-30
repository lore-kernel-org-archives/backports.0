Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54910 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758496Ab2K3O5i (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 30 Nov 2012 09:57:38 -0500
Message-ID: <50B8C954.2090507@hauke-m.de>
Date: Fri, 30 Nov 2012 15:57:24 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: shuox.liu@gmail.com, backports@vger.kernel.org
Subject: Re: Build compat-wireless for linus tree
References: <50A675EE.9010406@gmail.com> <50A79668.2060901@hauke-m.de> <50B4C158.3020701@gmail.com> <50B4D99B.8000308@gmail.com>
In-Reply-To: <50B4D99B.8000308@gmail.com>
Content-Type: text/plain; charset=GB2312
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/27/2012 04:17 PM, Shuo wrote:
> Hi Hauke,
> Sorry for disturb again.
> I am trying compat-wireless-2012-11-25 for v3.7-rc7, but it fails.
> I downloaded the tar package and unpackaged, driver-select b43, make
> Some logs:
> 
> Processing new driver-select request...
> Backing up makefile: Makefile.bk
> Backup exists: Makefile.bk
> Backup exists: Makefile.bk
> Backup exists: Makefile.bk
> Backing up makefile: drivers/misc/eeprom/Makefile.bk
> Backing up makefile: net/wireless/Makefile.bk
> Backing up makefile: drivers/net/wireless/Makefile.bk
> ./scripts/gen-compat-autoconf.sh /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/.config /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/config.mk > include/linux/compat_autoconf.h
> make -C /lib/modules/3.7.0-rc7-shuo-main+//build M=/home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25 modules
> make[1]: Entering directory `/home/lskakaxi/work/linux/kernel_build'
> /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/config.mk:247: "WARNING: CONFIG_CFG80211_WEXT will be deactivated or not working because kernel was compiled with CONFIG_WIRELESS_EXT=n. Tools using wext interface like iwconfig will not work. To activate it build your kernel e.g. with CONFIG_LIBIPW=m."
>   CC [M]  /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/compat/main.o
> In file included from /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/pm_qos.h:9:0,
>                  from /home/lskakaxi/work/linux/linux/include/linux/netdevice.h:28,
>                  from /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/compat-2.6.29.h:5,
>                  from /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/compat-2.6.h:50,
>                  from <command-line>:0:
> /home/lskakaxi/work/extern_modules/compat-wireless/compat-wireless-2012-11-25/include/linux/pm_qos_params.h:7:38: fatal error: linux/pm_qos_params.h: No such file or directory
> compilation terminated.
> 
> I found the linux/pm_qos_params.h has been renamed to pm_qos.h one year ago. I am confused why compat-wirelss need this old header.
> Anything i missed?
> 
> Shuo
> 
Hi Shuo,

There seams to be something wrong with your kernel. The include done in
include/linux/pm_qos.h:9:0 should not happen on your kernel version.

Does include/generated/uapi/linux/version.h in your kernel directory
contains #define LINUX_VERSION_CODE 197895 or does it contain some other
number?

Hauke
