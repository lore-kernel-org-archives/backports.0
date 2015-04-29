Return-path: <backports-owner@vger.kernel.org>
Received: from mail.sablalik.us ([74.111.177.26]:61860 "EHLO mail.sablalik.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbbD3AiX convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 29 Apr 2015 20:38:23 -0400
Date: Wed, 29 Apr 2015 19:37:11 -0400
Subject: trouble building ath10k on newer versions
From: Peter Sabat <pete@sablalik.us>
To: <backports@vger.kernel.org>
Message-ID: <D166E367.18190A%pete@sablalik.us> (sfid-20150430_023826_856464_5621F96E)
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Just wondering if something has changed since backports-20150129 that
would only allow compat and cfg80211 build ?

I noticed that mac80211 isn¹t in the menuconfig now, but the build worked
fine before.



I do have CONFIG_CRYPTO_CCM in my kernel config :


root@server2:/boot# uname -a
Linux server2 3.14.9-final #1 SMP Sat Jun 28 18:58:27 EDT 2014 x86_64
x86_64 x86_64 GNU/Linux

root@server2:/boot# cat config-3.14.9-final | grep CCM
CONFIG_CRYPTO_CCM=y



here is the output  - note that I got these from the previous (working)
builds.


root@server2:~/build/backports-20150313# make defconfig-ath10k
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
  -c -o conf.o conf.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
  -c -o zconf.tab.o zconf.tab.c
cc   conf.o zconf.tab.o   -o conf
boolean symbol HWMON tested for 'm'? test forced to 'n'
boolean symbol HWMON tested for 'm'? test forced to 'n'
#
# configuration written to .config
#



‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹




root@server2:~/build/backports-20150313# make
make[5]: `conf' is up to date.
boolean symbol HWMON tested for 'm'? test forced to 'n'
boolean symbol HWMON tested for 'm'? test forced to 'n'
#
# configuration written to .config
#
Building backport-include/backport/autoconf.h ... done.
  CC [M]  /home/pete/build/backports-20150313/compat/main.o
  CC [M]  /home/pete/build/backports-20150313/compat/backport-3.15.o
  CC [M]  /home/pete/build/backports-20150313/compat/backport-3.17.o
  CC [M]  /home/pete/build/backports-20150313/compat/backport-3.18.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/core.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/sysfs.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/radiotap.o
  CC [M]  /home/pete/build/backports-20150313/compat/backport-3.19.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/util.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/reg.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/scan.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/nl80211.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/mlme.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/ibss.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/sme.o
  LD [M]  /home/pete/build/backports-20150313/compat/compat.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/chan.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/ethtool.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/mesh.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/ap.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/trace.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/ocb.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/wext-compat.o
  CC [M]  /home/pete/build/backports-20150313/net/wireless/wext-sme.o
  LD [M]  /home/pete/build/backports-20150313/net/wireless/cfg80211.o
  Building modules, stage 2.
  MODPOST 2 modules
  CC      /home/pete/build/backports-20150313/compat/compat.mod.o
  CC      /home/pete/build/backports-20150313/net/wireless/cfg80211.mod.o
  LD [M]  /home/pete/build/backports-20150313/compat/compat.ko
  LD [M]  /home/pete/build/backports-20150313/net/wireless/cfg80211.ko





Thanks much -

Pete





