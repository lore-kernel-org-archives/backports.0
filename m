Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC18C433F5
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 22:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiBGW0z (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBGW0z (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 17:26:55 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC96C061355
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 14:26:54 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Jt1311yb7z9sQg;
        Mon,  7 Feb 2022 23:26:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1644272811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsRbH0cgtbFrJcJNBvjf2qyYH4Y2LCTrtw3OwSy6Qw8=;
        b=FiQqsDqk0xZLayRIQwvHbzeE7GBjenVHHofwJf7/w4Z2BfssVHNTe0I8mVMJdpQYgVGJKy
        ot0MpjLKyT/Iy8MQmAWpDy79boTdz9Dsgn0jdhtD4bztfCyMnrY+wKawjRz4hRoTeZkZdY
        Cy1ucupEoKfPr35m8mEagWI0+edWueYU5TZNaHi8uClj+X2Ri7Bn0s00ewAjx0J/nVu6Zp
        VJDzB01cJ5xBGekN3DxneGhBG0l8m4GQIzV8ndr+HOAQ85vvo+wPGm8/UYVFSXDGoG/lqF
        MnbZDGvzI8OxNGkx7d1sCUXQWT6tUBpMB//l3jk3myvBgiGPegzvXxZSDV22PQ==
Message-ID: <8997e3a1-5b12-92f5-1d01-7c4999cb7b98@hauke-m.de>
Date:   Mon, 7 Feb 2022 23:26:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] backports: Backport some ath11k runtime dependencies
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, mcgrof@kernel.org
Cc:     backports@vger.kernel.org
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
 <12bcca34-90ec-ca85-a95b-c067b35a47ae@hauke-m.de>
 <768ee985-1c7a-0c93-1295-53fe7edc42ad@flygoat.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <768ee985-1c7a-0c93-1295-53fe7edc42ad@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/7/22 02:09, Jiaxun Yang wrote:
> 
> 
> 在 2022/2/6 23:30, Hauke Mehrtens 写道:
>> On 2/6/22 23:26, Jiaxun Yang wrote:
>>> Backport mhi bus driver and QRTR driver.
>>> ath11k requires them aligned with latest version at runtime.
>>>
>>> Jiaxun Yang (6):
>>>    headers: Add MHI stuff to mod_devicetable
>>>    backports: Add mhi bus driver
>>>    backports: backport {get,set}_user_ifreq
>>>    headers: backport sk_error_report
>>>    backports: Add QRTR driver
>>>    defconfigs: Refresh for ath11k
>>>
>>>   backport/Kconfig.sources                      |  2 +
>>>   backport/Makefile.kernel                      |  2 +
>>>   .../backport-include/linux/mod_devicetable.h  | 15 ++++++
>>>   backport/backport-include/linux/netdevice.h   |  5 ++
>>>   backport/backport-include/net/sock.h          |  8 ++++
>>>   backport/compat/Makefile                      |  1 +
>>>   backport/compat/backport-5.15.c               | 47 +++++++++++++++++++
>>>   backport/compat/backport-genetlink.c          |  2 +-
>>>   backport/defconfigs/ath11k                    | 14 ++++++
>>>   backport/defconfigs/wifi                      |  3 ++
>>>   copy-list                                     |  6 +++
>>>   dependencies                                  |  6 +++
>>>   12 files changed, 110 insertions(+), 1 deletion(-)
>>>   create mode 100644 backport/compat/backport-5.15.c
>>>   create mode 100644 backport/defconfigs/ath11k
>>>
>>
>> This looks good to me.
> Hi Hauke,
> 
> Thanks for your reviewing.
>>
>> I think you have to add "ATH11K 5.2" too to the dependencies file. If 
>> this is not added Kconfig will try to activate QRTR on older kernel 
>> configurations too.
> 
> Ok, will do in v2.
>>
>> On which kernel versions did you runtime tested this? Did you use this 
>> with the PCIe or the AHB version of ath11k?
> On kernel 5.10, with ath11k_pci only.

Thanks for the information. This is fine with me. Most of the testing I 
also do inside of OpenWrt.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
