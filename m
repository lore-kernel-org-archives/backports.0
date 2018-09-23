Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50664 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIXCCO (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:02:14 -0400
Message-ID: <1537733001.1707.5.camel@sipsolutions.net> (sfid-20180923_220334_818247_9A235E8D)
Subject: Re: kernel 4.18+ build problem "Recursive variable 'KBUILD_CFLAGS' "
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Sun, 23 Sep 2018 22:03:21 +0200
In-Reply-To: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de> (sfid-20180923_161658_834557_1648CD51)
References: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de>
         (sfid-20180923_161658_834557_1648CD51)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 16:16 +0200, Hauke Mehrtens wrote:
> Hi,
> 
> I tried to compile backports against kernel 4.18 and 4.19-rc4 (header
> files from Ubuntu) and ran into this problem when it wants to link the
> kernel:
> 
>   LD [M]
> /home/hauke/compat-wireless/backports-4.19-rc4-1/drivers/net/wireless/realtek/rtlwifi/rtl_usb.o
>   Building modules, stage 2.
> scripts/Makefile.lib:10: *** Recursive variable 'KBUILD_CFLAGS'
> references itself (eventually).  Stop.

Hmm. I vaguely remember something like that with our driver, but can't
find it now? I also remember trying to fix it in the upstream kernel ...

Ah yes. This patch:

-subdir-ccflags-y = $(call cc-option,...)
+subdir-ccflags-y := $(call cc-option,...)

My commit log said:

   In newer kernels, calling cc-option will use KBUILD_CFLAGS,
   which itself gets subdir-ccflags-y added to it. Thus, we get
   it referencing itself, since nothing here is evaluated until
   KBUILD_CFLAGS is used: KBUILD_CFLAGS contains subdir-ccflags-y,
   that in turn contains cc-option call, containing KBUILD_CFLAGS.

   To avoid that, use := assignment to subdir-ccflags-y. This
   causes make to also evaluate += immediately, cc-option calls
   are done right away and we don't end up with KBUILD_CFLAGS
   referencing itself.

   This fixes build of the driver on kernels 4.15 and higher.

Really in our driver - and it was ChromeOS-specific code too - it was +=
but we had to start with := instead of =.

I don't see something like this in rtlwifi though?

Ah, but we have

subdir-ccflags-y += $(call cc-option, -fno-pie) $(call cc-option, -no-pie)

in backports, so I guess this would help:

--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -30,7 +30,7 @@ NOSTDINC_FLAGS := \
        $(CFLAGS)
 endif
 
-subdir-ccflags-y += $(call cc-option, -fno-pie) $(call cc-option, -no-pie)
+subdir-ccflags-y := $(call cc-option, -fno-pie) $(call cc-option, -no-pie)
 ifeq ($(CPTCFG_KERNEL_4_3),y)
 subdir-ccflags-y += -Wno-pointer-sign
 endif

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
