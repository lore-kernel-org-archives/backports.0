Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206BC07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 17:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A164761946
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 17:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGERuM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 13:50:12 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:55196 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhGERuL (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 13:50:11 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.175])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C8B7B20061;
        Mon,  5 Jul 2021 17:47:33 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5F4968C006A;
        Mon,  5 Jul 2021 17:47:33 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3479913C2B3;
        Mon,  5 Jul 2021 10:47:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3479913C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625507249;
        bh=/7KF+7irV/f55XOd/u1PtVxozgKVuIwNpHSlEex5N04=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KVa+d3Tf/CDfnBPaimm/tDzY09i1jvAlHR3v0W4+kc4cJD+Jh6/42w6aNyXc5b8I5
         03J2UurGNQwh3PXhlMQSyg72YEfE1T9VWl4ERgzWjspsR6u/bMAh3s7U8qobgWbgsW
         uAsvKWdKJzxHV2GqynFWKeB4CZNkUN36eyDdPkDo=
Subject: Re: backports spatch question
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
 <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
 <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
 <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <31776ce8-7014-b3ed-41bf-121e8ce5001c@candelatech.com>
Date:   Mon, 5 Jul 2021 10:47:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1625507254-r_m_srwwf7C8
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/1/21 2:51 PM, Johannes Berg wrote:
> On Thu, 2021-07-01 at 14:40 -0700, Ben Greear wrote:
>>
>> [greearb@v-f34-64 backports]$ spatch --version
>> spatch version 1.0.8-gf4ba8df-dirty compiled with OCaml version 4.11.1
> 
> 
> I just realized I never even tried on my system recently, I'm still on
> F33 and have
> 
> spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
> 
> Could you try some other version? Backports says it needs "at least"
> 1.0.7 but perhaps only exactly that works?
> 
> johannes
> 

I hacked through this by removing the offending spatches.  Seems to have worked OK
since the kernels I am using are relatively recent.

I spent a while getting the mac80211 patches from owrt tweaked or otherwise
resolved so that it would patch against my backports tree.

But now I'm having trouble with rfkill and not sure best way forward.  Is backports
supposed to take care of this somehow, or do I need to go hacking in openwrt?


Building backport-include/backport/autoconf.h ... done.
   CC [M]  /home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/compat/main.o
   LD [M]  /home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/compat/compat.o
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
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c: At 
top level:
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:1125:16: 
warning: 'enum rfkill_hard_block_reasons' declared inside parameter list will not be visible outside of this definition or declaration
            enum rfkill_hard_block_reasons reason)
                 ^~~~~~~~~~~~~~~~~~~~~~~~~
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:1125:42: 
error: parameter 3 ('reason') has incomplete type
            enum rfkill_hard_block_reasons reason)
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c: In 
function 'wiphy_rfkill_set_hw_state_reason':
/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/build_dir/target-aarch64_cortex-a53_musl/linux-mediatek_mt7622/backports-ct-5.13.0/net/wireless/core.c:1129:6: 
error: implicit declaration of function 'rfkill_set_hw_state_reason'; did you mean 'wiphy_rfkill_set_hw_state_reason'? [-Werror=implicit-function-declaration]
   if (rfkill_set_hw_state_reason(rdev->rfkill, blocked, reason))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~
       wiphy_rfkill_set_hw_state_reason
cc1: some warnings being treated as errors
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
time: package/kernel/mac80211/compile#3.68#1.38#4.72
     ERROR: package/kernel/mac80211 failed to build.
make[2]: *** [package/Makefile:114: package/kernel/mac80211/compile] Error 1
make[2]: Leaving directory '/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt'
make[1]: *** [package/Makefile:108: /home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/staging_dir/target-aarch64_cortex-a53_musl/stamp/.package_compile] Error 2
make[1]: Leaving directory '/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt'
make: *** [/home/greearb/git/tip/wlan-ap-ct-e8450-new/openwrt/include/toplevel.mk:230: world] Error 2

Compilation exited abnormally with code 2 at Mon Jul  5 10:21:42


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
