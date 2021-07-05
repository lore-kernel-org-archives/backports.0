Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15542C07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1ADF61973
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhGETTc (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:19:32 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:54246 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhGETTc (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 15:19:32 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 15:19:32 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C49A022329E
        for <backports@vger.kernel.org>; Mon,  5 Jul 2021 19:10:46 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.135])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 80E821A0062;
        Mon,  5 Jul 2021 19:10:45 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 280384C0068;
        Mon,  5 Jul 2021 19:10:44 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 66A4613C2B1;
        Mon,  5 Jul 2021 12:10:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 66A4613C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625512244;
        bh=+Ku7zK6vkQ3ZslUjYsTr28KNfgP/Z5JNaTJmSrn4j4U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V8ZVpx4r2ownumR8U3GmoOYNje1Z1xcH8lP8eeKV4m9tdkawFiqgE+6fLPywQC/E/
         l6YoEnKshRbE2vgfNkiMWjAhpb2M2rD72xxc2kEG+ckNM78Cr2IHBx0ye9yU9F9v7H
         1/9zbBDuyuhCerx5YD7gM9cQSAKxKyF4Qwqs/0ic=
Subject: Re: backports spatch question
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
 <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
 <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
 <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
 <31776ce8-7014-b3ed-41bf-121e8ce5001c@candelatech.com>
 <244749b289fcaca6826670471890420d4b51b6ed.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <a5e843c9-bed8-a381-4e67-dac3a1a207ed@candelatech.com>
Date:   Mon, 5 Jul 2021 12:10:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <244749b289fcaca6826670471890420d4b51b6ed.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1625512246-rLeuuBUDeAXb
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/5/21 10:55 AM, Johannes Berg wrote:
> On Mon, 2021-07-05 at 10:47 -0700, Ben Greear wrote:
>> On 7/1/21 2:51 PM, Johannes Berg wrote:
>>> On Thu, 2021-07-01 at 14:40 -0700, Ben Greear wrote:
>>>>
>>>> [greearb@v-f34-64 backports]$ spatch --version
>>>> spatch version 1.0.8-gf4ba8df-dirty compiled with OCaml version 4.11.1
>>>
>>>
>>> I just realized I never even tried on my system recently, I'm still on
>>> F33 and have
>>>
>>> spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
>>>
>>> Could you try some other version? Backports says it needs "at least"
>>> 1.0.7 but perhaps only exactly that works?
>>>
>>> johannes
>>>
>>
>> I hacked through this by removing the offending spatches.  Seems to have worked OK
>> since the kernels I am using are relatively recent.
>>
>> I spent a while getting the mac80211 patches from owrt tweaked or otherwise
>> resolved so that it would patch against my backports tree.
>>
>> But now I'm having trouble with rfkill and not sure best way forward.  Is backports
>> supposed to take care of this somehow, or do I need to go hacking in openwrt?
> 
> You need this bit in backport-include/linux/rfkill.h, not sure why it's
> not there yet:
> 
> #if LINUX_VERSION_IS_LESS(5,11,0)
> 
> /* This should come from uapi/linux/rfkill.h, but it was much easier
>   * to do it this way.
>   */
> enum rfkill_hard_block_reasons {
>          RFKILL_HARD_BLOCK_SIGNAL        = 1 << 0,
>          RFKILL_HARD_BLOCK_NOT_OWNER     = 1 << 1,
> };
> 
> static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
>                                                bool blocked, unsigned
> long reason)
> {
>          return rfkill_set_hw_state(rfkill, blocked);
> }
> 
> #endif /* 5.11 */
> 
> 
> johannes
> 

I added that patch to the bottom of the file, just above the final #endif

It still fails to build.  I added invalid tokens (BUGME2, BUGME) to the file, and that does show that it is being
included in some places, but not from cfg80211.h I guess:

make  -C "/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0" HOSTCFLAGS="-O2 
-I/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/staging_dir/host/include -I/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/staging_dir/hostpkg/include 
-I/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/staging_dir/target-aarch64_cortex-a53_musl/host/include -Wall -Wmissing-prototypes -Wstrict-prototypes" 
CROSS_COMPILE="aarch64-openwrt-linux-musl-" ARCH="arm64" KBUILD_HAVE_NLS=no KBUILD_BUILD_USER="" KBUILD_BUILD_HOST="" KBUILD_BUILD_TIMESTAMP="Mon Jul  5 
17:34:30 2021" KBUILD_BUILD_VERSION="0" HOST_LOADLIBES="-L/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/staging_dir/host/lib" 
KBUILD_HOSTLDLIBS="-L/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/staging_dir/host/lib" CONFIG_SHELL="bash" V=''  cmd_syscalls= 
KBUILD_EXTRA_SYMBOLS="/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/symvers/gpio-button-hotplug.symvers" 
KERNELRELEASE=5.10.27 
EXTRA_CFLAGS="-I/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include " 
KLIB_BUILD="/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/linux-5.10.27" MODPROBE=true 
KLIB=/lib/modules/5.10.27 KERNEL_SUBLEVEL=10 KBUILD_LDFLAGS_MODULE_PREREQ= modules
make[4]: Entering directory '/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0'
make[5]: 'Kconfig.versions' is up to date.
make[7]: 'Kconfig.versions' is up to date.
make[8]: 'conf' is up to date.
boolean symbol CRYPTO_LIB_ARC4 tested for 'm'? test forced to 'n'
#
# configuration written to .config
#
Building backport-include/backport/autoconf.h ... done.
   CC [M]  /home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.o
In file included from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:26:
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include/net/cfg80211.h:6653:16: 
warning: 'enum rfkill_hard_block_reasons' declared inside parameter list will not be visible outside of this definition or declaration
            enum rfkill_hard_block_reasons reason);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include/net/cfg80211.h: In 
function 'wiphy_rfkill_set_hw_state':
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include/net/cfg80211.h:6658:7: 
error: 'RFKILL_HARD_BLOCK_SIGNAL' undeclared (first use in this function)
        RFKILL_HARD_BLOCK_SIGNAL);
        ^~~~~~~~~~~~~~~~~~~~~~~~
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include/net/cfg80211.h:6658:7: 
note: each undeclared identifier is reported only once for each function it appears in
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include/net/cfg80211.h:6658:7: 
error: type of formal parameter 3 is incomplete
In file included from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.h:14,
                  from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/nl80211.h:9,
                  from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:27:
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/backport-include/linux/rfkill.h: 
At top level:
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/backport-include/linux/rfkill.h:173:1: 
error: unknown type name 'BUGME2'; did you mean 'BUG'?
  BUGME2
  ^~~~~~
  BUG
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/backport-include/linux/rfkill.h:175:6: 
error: expected ';' before 'enum'
  BUGME
       ^
       ;
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/backport-include/linux/rfkill.h:179:1:
  enum rfkill_hard_block_reasons {
  ~~~~
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:1124:6: 
error: conflicting types for 'wiphy_rfkill_set_hw_state_reason'
  void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:26:
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include/net/cfg80211.h:6652:6: 
note: previous declaration of 'wiphy_rfkill_set_hw_state_reason' was here
  void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/backport-include/linux/export.h:7,
                  from ./include/linux/linkage.h:7,
                  from ./include/linux/kernel.h:8,
                  from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/backport-include/linux/kernel.h:3,
                  from ./include/linux/uio.h:8,
                  from ./include/linux/socket.h:8,
                  from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/backport-include/linux/socket.h:3,
                  from ./include/uapi/linux/if.h:25,
                  from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:13:
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:1132:15: 
error: conflicting types for 'wiphy_rfkill_set_hw_state_reason'
  EXPORT_SYMBOL(wiphy_rfkill_set_hw_state_reason);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/export.h:104:21: note: in definition of macro '___EXPORT_SYMBOL'
   extern typeof(sym) sym;       \
                      ^~~
./include/linux/export.h:161:34: note: in expansion of macro '__EXPORT_SYMBOL'
  #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
                                   ^~~~~~~~~~~~~~~
./include/linux/export.h:164:29: note: in expansion of macro '_EXPORT_SYMBOL'
  #define EXPORT_SYMBOL(sym)  _EXPORT_SYMBOL(sym, "")
                              ^~~~~~~~~~~~~~
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:1132:1: 
note: in expansion of macro 'EXPORT_SYMBOL'
  EXPORT_SYMBOL(wiphy_rfkill_set_hw_state_reason);
  ^~~~~~~~~~~~~
In file included from 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:26:
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/include/net/cfg80211.h:6652:6: 
note: previous declaration of 'wiphy_rfkill_set_hw_state_reason' was here
  void wiphy_rfkill_set_hw_state_reason(struct wiphy *wiphy, bool blocked,
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[9]: *** [scripts/Makefile.build:279: 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.o] Error 1
make[8]: *** [scripts/Makefile.build:496: 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless] Error 2
make[7]: *** [Makefile:1810: 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0] Error 2
make[6]: *** [Makefile.build:13: modules] Error 2
make[5]: *** [Makefile.real:93: modules] Error 2
make[4]: *** [Makefile:121: modules] Error 2
make[4]: Leaving directory '/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0'
make[3]: *** [Makefile:561: 
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/.built] Error 2
make[3]: Leaving directory '/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/package/kernel/mac80211'
time: package/kernel/mac80211/compile#0.97#0.43#1.35
     ERROR: package/kernel/mac80211 failed to build.
make[2]: *** [package/Makefile:114: package/kernel/mac80211/compile] Error 1
make[2]: Leaving directory '/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt'
make[1]: *** [package/Makefile:108: /home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/staging_dir/target-aarch64_cortex-a53_musl/stamp/.package_compile] Error 2
make[1]: Leaving directory '/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt'
make: *** [/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/include/toplevel.mk:230: world] Error 2

Compilation exited abnormally with code 2 at Mon Jul  5 12:07:49

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
