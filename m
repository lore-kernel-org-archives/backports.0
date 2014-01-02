Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:46669 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaABRy1 convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 2 Jan 2014 12:54:27 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so14343492wib.12
        for <backports@vger.kernel.org>; Thu, 02 Jan 2014 09:54:26 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 2 Jan 2014 12:54:26 -0500
Message-ID: <CAOzu-jgfXjXt-_YQmcZqiD2zKiZkgT_VD8dMoi-WqW=Jw8QX_w@mail.gmail.com> (sfid-20140102_185429_936242_E622A8EA)
Subject: problems building iwlwifi for kernel 2.6.32
From: Kurt Bodiker <kebodiker@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm trying to build iwlwifi for a compiled 2.6.32 kernel for use in
Citrix XenClient XT v3.1.2. Using backports 3.10-2, no problem,
iwlwifi, mac80211, cfg80211, etc... build. If I use the release file
for 3.13-rc2, then only kernel modules that are built are compat and
cfg80211.

Here are the commands I run and the output:
root@debian-build:/usr/src/backports/backports-3.13-rc2-1# make
KLIB_BUILD=/usr/src/linux-xenclient-ndvm_2.6.32-r0 KLIB=/fakeroot
defconfig-iwlwifi
Generating local configuration database from kernel ... done.
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
-fomit-frame-pointer   -c -o conf.o conf.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
-fomit-frame-pointer   -c -o zconf.tab.o zconf.tab.c
cc   conf.o zconf.tab.o   -o conf
#
# configuration written to .config
#

root@debian-build:/usr/src/backports/backports-3.13-rc2-1# make
KLIB_BUILD=/usr/src/linux-xenclient-ndvm_2.6.32-r0 KLIB=/fakeroot -j4
make[5]: `conf' is up to date.
#
# configuration written to .config
#
Building backport-include/backport/autoconf.h ... done.
  Updating /usr/src/backports/backports-3.13-rc2-1/Makefile.xen
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/main.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/core.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-2.6.33.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/sysfs.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/radiotap.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-2.6.34.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/util.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-2.6.35.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-2.6.36.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/reg.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-2.6.37.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/scan.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-2.6.39.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/nl80211.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/kstrtox.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/mlme.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.0.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/ibss.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.1.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.3.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.4.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/sme.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/chan.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.5.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/user_namespace.o
/usr/src/backports/backports-3.13-rc2-1/net/wireless/nl80211.c: In
function ‘T.1493’:
/usr/src/backports/backports-3.13-rc2-1/net/wireless/nl80211.c:77:
warning: ‘wdev_id’ may be used uninitialized in this function
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.6.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/ethtool.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.7.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.8.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/mesh.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/ap.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat-3.9.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/trace.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/debugfs.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/backport-3.10.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/backport-3.12.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/backport-3.13.o
  LD [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/cfg80211.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/kfifo.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat_atomic.o
  CC [M]  /usr/src/backports/backports-3.13-rc2-1/compat/dma-shared-helpers.o
  LD [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat.o
  Building modules, stage 2.
  MODPOST 2 modules
  CC      /usr/src/backports/backports-3.13-rc2-1/compat/compat.mod.o
  CC      /usr/src/backports/backports-3.13-rc2-1/net/wireless/cfg80211.mod.o
  LD [M]  /usr/src/backports/backports-3.13-rc2-1/compat/compat.ko
  LD [M]  /usr/src/backports/backports-3.13-rc2-1/net/wireless/cfg80211.ko



Any thoughts or suggestions?

Kurt
