Return-path: <backports-owner@vger.kernel.org>
Received: from mail-bn1on0138.outbound.protection.outlook.com ([157.56.110.138]:14838
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932362AbcECSqN convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 3 May 2016 14:46:13 -0400
From: Guillaume Fournier <gfournier@brioconcept.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Problem backporting wl18xx to kernel 2.6.28
Date: Tue, 3 May 2016 16:14:39 +0000
Message-ID: <CY1PR0401MB0972873AA01C262A18881EA0BA7A0@CY1PR0401MB0972.namprd04.prod.outlook.com> (sfid-20160503_204615_893557_EA1B30FF)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I am trying to use backports-3.14.22-1 to cross-compile the wl18xx driver for a custom kernel 2.6.28 designed to run on an NXP video encoder (ASC8852A).  I am using Backports 3.14 because of this note in the documentation: "Current versions of backports support all mainline kernels starting with version 3.0, for kernel versions older than 3.0 please use backports-3.14, which supports all kernel versions back to 2.6.26.".  I have decided to using 3.14.22 because it seemed the most recent 3.14 release.  While configuring Backports, I noticed that the TI Modules (WL_TI) were not supported prior to 2.6.30:

Symbol: WL18XX [=m]
Type : tristate
Prompt: TI wl18xx support
  Defined at drivers/net/wireless/ti/wl18xx/Kconfig:1
  Depends on: WLAN [=y] && WL_TI [=y] && m && <choice> && MAC80211 [=m]
  Location:
    -> Wireless LAN (WLAN [=y])
      -> TI Wireless LAN support (WL_TI [=y])
  Selects: WLCORE [=m]

and

Symbol: WL_TI [=y]
Type : boolean
Prompt: TI Wireless LAN support
  Defined at drivers/net/wireless/ti/Kconfig:1
  Depends on: WLAN [=y] && !BACKPORT_KERNEL_2_6_30
  Location:
    -> Wireless LAN (WLAN [=y])

Therefore, I am trying to get the wl18xx to build on 2.6.30 as a first step.  After I get this to work, I will try to manually backport it to 2.6.28.  I will have to find out how to get the patched driver source code for the 2.6.30 driver (maybe use the Backports kernel integration?), but first things first.

To make things easier for Backports, I am *not* using my custom kernel for now but a clean slate 2.6.30 kernel.  Here is what I did:
1) Cloned linux from git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
2) Checked out v2.6.30
3) Menuconfig to make sure CONFIG_CRYPTO_CCM=m is activated as per: http://marc.info/?t=139876444500003&r=1&w=2 (it was already activated so I had nothing to do except saving the config)
4) Cross-compiled the kernel
5) Menuconfig Backports to select wl18xx driver, cfg80211, mac80211
6) Cross-compile Backports

All this is run in a VirtualBox VM running Ubuntu 16.04 LTS 32 bits.  Here are my environment variables of interest:
CROSS_COMPILE=/opt/Mozart_toolchain/arm-eabi-uclibc/usr/bin/arm-unknown-linux-uclibcgnueabi- (from NXP SDK toolchain)
ARCH=arm
KLIB_BUILD=/home/gfournier/wifi-atomas/linux (points to the clean slate cloned linux kernel 2.6.30)
KLIB=/home/gfournier/wifi-atomas/rootfs (empty rootfs directory to get the result of the build)

I am running into build errors.  First, I got this error (although CONFIG_CRYPTO_CCM=m):
In file included from /home/gfournier/wifi-atomas/backports-3.14.22-1/compat/compat-2.6.32.c:11:
/home/gfournier/wifi-atomas/backports-3.14.22-1/backport-include/linux/compat.h:18: error: expected ';', ',' or ')' before '*' token

I commented out the code as such to see if I would get better results:
#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
//#define compat_put_timespec LINUX_BACKPORT(compat_put_timespec)
//extern int compat_put_timespec(const struct timespec *, void __user *);
#endif

However, I now have this error:
/home/gfournier/wifi-atomas/backports-3.14.22-1/drivers/net/wireless/ti/wl18xx/scan.c: In function 'wl18xx_scan_send':
/home/gfournier/wifi-atomas/backports-3.14.22-1/drivers/net/wireless/ti/wl18xx/scan.c:138: error: unknown field 'enabled' specified in initializer
/home/gfournier/wifi-atomas/backports-3.14.22-1/drivers/net/wireless/ti/wl18xx/scan.c:138: warning: excess elements in struct initializer
/home/gfournier/wifi-atomas/backports-3.14.22-1/drivers/net/wireless/ti/wl18xx/scan.c:138: warning: (near initialization for 'descriptor')

Is there something I am not understanding correctly about how I am supposed to build Backports?
Can you provide help on the previous errors?
To your knowledge, has anyone tried to get wl18xx running on 2.6.28?

Guillaume Fournier

--
To unsubscribe from this list: send the line "unsubscribe backports" in
