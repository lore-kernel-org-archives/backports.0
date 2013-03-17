Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57277 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab3CQIwI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 04:52:08 -0400
Received: by mail-wg0-f52.google.com with SMTP id 15so3235402wgd.7
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 01:52:06 -0700 (PDT)
Date: Sun, 17 Mar 2013 09:52:02 +0100
From: =?utf-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
To: backports@vger.kernel.org
Subject: Unable to compile "compat-drivers" in Debian Wheezy
Message-ID: <20130317085202.GB3547@stt008.linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I'm trying to compile "compat-drivers" in Debian Wheezy but it fails:

Kernel version:

root@stt300:~# dpkg -l | grep linux-image
ii  linux-image-3.2.0-4-686-pae          3.2.39-2                i386         Linux 3.2 for modern PCs
ii  linux-image-686-pae                  3.2+46                  i386         Linux for modern PCs (meta-package)
        
Build tools installed:
        
root@stt300:~# LANG=POSIX apt-get install build-essential 
linux-headers-`uname -r`
Reading package lists... Done
Building dependency tree       
Reading state information... Done
build-essential is already the newest version.
linux-headers-3.2.0-4-686-pae is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.

But when running the build commands:

hpc03@stt300:~/Escritorio/compat-drivers-3.9-rc2-2-su$ 
./scripts/driver-select brcmsmac
Processing new driver-select request...
Backing up makefile: Makefile.bk
Backup exists: Makefile.bk
Backup exists: Makefile.bk
Backup exists: Makefile.bk
Backup exists: Makefile.bk
Backing up makefile: drivers/net/wireless/Makefile.bk
Backing up makefile: drivers/net/wireless/brcm80211/Makefile.bk

hpc03@stt300:~/Escritorio/compat-drivers-3.9-rc2-2-su$ LANG=POSIX make
make -C /lib/modules/3.2.0-4-686-pae/build M=/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su modules
make[1]: Entering directory `/usr/src/linux-headers-3.2.0-4-686-pae'
CC [M]  /home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/compat/main.o
In file included from /home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/include/linux/compat-2.6.h:67:0,
from <command-line>:0:
                 
/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/include/linux/compat-3.4.h:43:21: error: redefinition of 'kmalloc_array'
/usr/src/linux-headers-3.2.0-4-common/include/linux/slab.h:243:21: note: previous definition of 'kmalloc_array' was here
/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/include/linux/compat-3.4.h:104:20: error: redefinition of 'eth_hw_addr_random'
/usr/src/linux-headers-3.2.0-4-common/include/linux/etherdevice.h:165:20: note: previous definition of 'eth_hw_addr_random' was here
make[5]: *** [/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/compat/main.o] Error 1
make[4]: *** [/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/compat] Error 2
make[3]: *** [_module_/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su] Error 2
make[2]: *** [sub-make] Error 2
make[1]: *** [all] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-3.2.0-4-686-pae'
make: *** [modules] Error 2

Note: I've tried with a bunch of different "compat-drivers" and 
"compat-wireless" packages but none succeeded.

Note 2: I also reported this to Debian BTS (bug #703205)

Greetings,

-- 
Camaleón 
