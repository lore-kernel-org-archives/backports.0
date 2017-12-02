Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:46816 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdLBAot (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 1 Dec 2017 19:44:49 -0500
Received: by mail-pg0-f49.google.com with SMTP id b11so5171192pgu.13
        for <backports@vger.kernel.org>; Fri, 01 Dec 2017 16:44:49 -0800 (PST)
Received: from ?IPv6:2600:100f:b000:9b80:6941:fc3f:6520:9004? ([2600:100f:b000:9b80:6941:fc3f:6520:9004])
        by smtp.gmail.com with ESMTPSA id h13sm12772807pfi.40.2017.12.01.16.44.47
        for <backports@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2017 16:44:48 -0800 (PST)
From: Remington Furman <remicles2@gmail.com>
Subject: Cross-compiling wifi driver on Android
To: backports@vger.kernel.org
Message-ID: <41f0fd53-25ef-420e-8ef8-f24498b8118e@gmail.com> (sfid-20171202_014451_466599_433CD4CB)
Date: Fri, 1 Dec 2017 16:44:46 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I've been following the directions here:
<https://backports.wiki.kernel.org/index.php/Documentation/packaging#Cross_compiling>
Thanks you your help, I've successfully run gentree.py

I used a "make showcommands kernelconfig" Android build command
to find the proper CROSS_COMPILE and ARCH variables for building
the kernel.  I then pointed KLIB and KLIB_BUILD to the proper
directories for my Android build (it uses a separate build
directory for everything, including the kernel).

 From my backports directory:
set -a
CROSS_COMPILE=aarch64-linux-android-
ARCH=arm64
KLIB=/media/remicles/BP2/work/linux_android_board_support_package_vla.br_.1.2.4-01810-8x16.0-3/APQ8016_410C_LA.BR.1.2.4-01810-8x16.0_5.1.1_Lollipop_P2/kernel
KLIB_BUILD=/media/remicles/BP2/work/linux_android_board_support_package_vla.br_.1.2.4-01810-8x16.0-3/APQ8016_410C_LA.BR.1.2.4-01810-8x16.0_5.1.1_Lollipop_P2/out/target/product/msm8916_64/obj/KERNEL_OBJ
set +a
make menuconfig

That succeeds and shows me a menu.  However, '<M> USB Network
Adapters ----' is an empty menu and the rtl8192cu driver I am
after is not available.  Enabling CPTCFG_WLAN_VENDOR_REALTEK in
'make menuconfig' doesn't lead to any other options.

If I instead run 'make defconfig-rtlwifi' (which includes
'CPTCFG_RTL8192CU=m'), then the resulting .config file still
contains:

$ grep -i -e "rtl" -e "realtek" .config
CPTCFG_WLAN_VENDOR_REALTEK=y
CPTCFG_NET_VENDOR_REALTEK=y
CPTCFG_BACKPORTED_WLAN_VENDOR_REALTEK=y
# CPTCFG_BACKPORTED_RTL8180 is not set
[snip]
# CPTCFG_BACKPORTED_RTL8192CU is not set
# CPTCFG_BACKPORTED_RTLWIFI is not set
# CPTCFG_BACKPORTED_RTLWIFI_PCI is not set
# CPTCFG_BACKPORTED_RTLWIFI_USB is not set
# CPTCFG_BACKPORTED_RTLWIFI_DEBUG is not set
[snip]
# CPTCFG_BACKPORTED_USB_RTL8152 is not set

At this point, a build includes compat.ko and cfg80211.ko, but no
rtl8192cu.ko, of course.

If I understand this page correctly, I need to first disable
conflicting drivers in my target kernel .config before running
'make menuconfig' in backports.
<https://backports.wiki.kernel.org/index.php/Documentation/integration#Kernel_integration_menuconfig>
I've tried a number of target kernel configurations, but haven't
found a combination that makes backports happy yet.  I've disable
CONFIG_CFG80211 and CONFIG_WLAN, but no luck.

I've tried to dive into Makefile.real to understand how the two
.config files interact, but I don't understand menuconfig/kconf
enough.  Is there a way I can get some debug output to see any
conflicts between my .config files?

I've thought about just copying the backports driver code into my
target kernel source directory and building from there, but I'm
not sure if that would work or is advised.  My guess is that it
could be a mess without using the backports Kconfig files.  My
goal is to have an rtl8192cu.ko module (and the modules it
depends on) that I can load on the target.

Does anyone have any pointers or suggestions?

Thank you,
Remington

--
To unsubscribe from this list: send the line "unsubscribe backports" in
