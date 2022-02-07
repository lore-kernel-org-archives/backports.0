Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B4C433F5
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 01:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiBGBL1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 20:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBL0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 20:11:26 -0500
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 17:11:25 PST
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B4C06173B
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 17:11:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C8555C007B;
        Sun,  6 Feb 2022 20:09:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 06 Feb 2022 20:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=GhG6yEJzpIIGT7
        L8soFcz+oTDZ/Mk0oM6jz2ofuhV+0=; b=C4twCsy1x0AmLg1Oii1saV6/15coUp
        zTqJwUkv8QAXpkuRlwvkoSeQf4XVvGxdEkskHZpevwrAFTBx9BKCYoogeDOGYBRS
        NkxuuhuIh22A5zNUsWHAIgXsi/zr9zwruFjze/BC9CXuntSe+z9rV67EmvENDwkZ
        BLvxy4N6XvtK5fasD6Bn307B14WU8998jum7rOI/vg0SG7HZxDhIMNiPmOf1w0pI
        DwEZBjQtBER8wICTC/MVWmVeJAdMm+jYo35dG902MLFPP9xoViWjJYPliYvGPLJK
        9U6cbdwHDExSdFUzVmh7hOHZ48i9deqpcxaYmN6Q6DUZkb2Pr9Rm9iQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=GhG6yEJzpIIGT7L8soFcz+oTDZ/Mk0oM6jz2ofuhV
        +0=; b=J3jndshMJioWRnp7/tLRmc4nM613y4al0MeJtUpsduzR0z+4ua69V1SUK
        7zdWErr60u5uTkUhrsVuopDjgz3OxNEK5EVOKGM4ZF+WE8t2agxJvWfP1BygwXne
        Tit+XX+9w/uIoDlOiSiYENMBz57WzgteWpGBF71368s4du/e1p+SokJ+m1hena/8
        uM/iWmHqyI76P6gPN7OoO25Gp9wxyR8tDOFvY+gBwgZZkGdsd4PDpU5guesMu2nK
        j1/ukZmtMPdS1xWqNBFsBfgqGVVBWEXKluolW5lOlDHBoaD2ghEQL2O6O2hlzVR2
        w+yJlmXUwfJHdVqH8gdZCkAAFds5g==
X-ME-Sender: <xms:YHEAYoAbcN77mRXX_b-gvqPp-Gi8AUTGtCVYOB2-Zr8lFzCyw1iC9Q>
    <xme:YHEAYqjRZhBgexaTXS_iwkRWMDLvC6CeANOz9ugVMoQQqAedBTdN3y-Dn5hutTCmL
    pZaLrOs9CR8cX4J9h0>
X-ME-Received: <xmr:YHEAYrmMZEpfpLLW9VQcd3SuVU0lc_YjdCtxuJFGI7m-Dnp8n_MTlGCWQyN-jbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:YHEAYuyMrXCc7uStX_VIT-cEKDSVzL8ttjQBKJxkM0UlT_6uUNtDaw>
    <xmx:YHEAYtTMVLTOwlGaZq0GKEVfH6VPjrPZn74tOcJyMKoVr6iP1vH0-g>
    <xmx:YHEAYpZKeCQy9w4UesJZdqsIddZUIMF4l4p-JAFKXelIGnL9i3ESTw>
    <xmx:YHEAYsLJWF5fdwoPCWJHTtmEuFK1u9VvXUWzdLyarFWMiGnxJ0VhEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 20:09:51 -0500 (EST)
Message-ID: <768ee985-1c7a-0c93-1295-53fe7edc42ad@flygoat.com>
Date:   Mon, 7 Feb 2022 01:09:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/6] backports: Backport some ath11k runtime dependencies
To:     Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@kernel.org
Cc:     backports@vger.kernel.org
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
 <12bcca34-90ec-ca85-a95b-c067b35a47ae@hauke-m.de>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <12bcca34-90ec-ca85-a95b-c067b35a47ae@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



在 2022/2/6 23:30, Hauke Mehrtens 写道:
> On 2/6/22 23:26, Jiaxun Yang wrote:
>> Backport mhi bus driver and QRTR driver.
>> ath11k requires them aligned with latest version at runtime.
>>
>> Jiaxun Yang (6):
>>    headers: Add MHI stuff to mod_devicetable
>>    backports: Add mhi bus driver
>>    backports: backport {get,set}_user_ifreq
>>    headers: backport sk_error_report
>>    backports: Add QRTR driver
>>    defconfigs: Refresh for ath11k
>>
>>   backport/Kconfig.sources                      |  2 +
>>   backport/Makefile.kernel                      |  2 +
>>   .../backport-include/linux/mod_devicetable.h  | 15 ++++++
>>   backport/backport-include/linux/netdevice.h   |  5 ++
>>   backport/backport-include/net/sock.h          |  8 ++++
>>   backport/compat/Makefile                      |  1 +
>>   backport/compat/backport-5.15.c               | 47 +++++++++++++++++++
>>   backport/compat/backport-genetlink.c          |  2 +-
>>   backport/defconfigs/ath11k                    | 14 ++++++
>>   backport/defconfigs/wifi                      |  3 ++
>>   copy-list                                     |  6 +++
>>   dependencies                                  |  6 +++
>>   12 files changed, 110 insertions(+), 1 deletion(-)
>>   create mode 100644 backport/compat/backport-5.15.c
>>   create mode 100644 backport/defconfigs/ath11k
>>
>
> This looks good to me.
Hi Hauke,

Thanks for your reviewing.
>
> I think you have to add "ATH11K 5.2" too to the dependencies file. If 
> this is not added Kconfig will try to activate QRTR on older kernel 
> configurations too.

Ok, will do in v2.
>
> On which kernel versions did you runtime tested this? Did you use this 
> with the PCIe or the AHB version of ath11k?
On kernel 5.10, with ath11k_pci only.

Thanks.
- Jiaxun
>
> Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
