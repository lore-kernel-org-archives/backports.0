Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C0C433EF
	for <backports@archiver.kernel.org>; Tue,  8 Feb 2022 14:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378422AbiBHOu3 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 8 Feb 2022 09:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiBHOu2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 Feb 2022 09:50:28 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7840C061577
        for <backports@vger.kernel.org>; Tue,  8 Feb 2022 06:50:27 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 47D323201F88;
        Tue,  8 Feb 2022 09:50:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 08 Feb 2022 09:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=X+rOT+XSRnpaf8
        pqAxLqdMBZcMxKT/b312X3t+mFgZ0=; b=oglfxyH1TaweWTxub6DOdrU/iPG1wT
        5T1mnCG1SWxQ87ozf+n7+1Hfvprr/gsWR93yqVjE7fqFvqNgcTTVFwbDFPE+AT9T
        3v0WldnNK7/jsS44FNc15P6vC094e0pTT05D3Lk2znfKruihDUfNFffkWWAaEGvC
        ZihHXnnVdc2CvrRMpSyv79aLbMK/vBVyXaPL8Mf2h0xSaBY5wOTGPgugCGXlo/05
        CkI3lwDaoIlQGqUQaf7gd6PUwy0V50AlAA3aOS3bZUPaXqqru5F/3N2p8rY8zzUz
        CQ+SEhqJ6SwCdwcxf/d1JMKju6/itPu6KPcDaucMN37HK9ZddMG4EW4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=X+rOT+XSRnpaf8pqAxLqdMBZcMxKT/b312X3t+mFgZ0=; b=hn/rOKqW
        Ex0DLeSlUkAU1YaJQijJhOWzSF4uC55yh4v2MEGbBl9H0CkI3u/iMGAV7NZGe24f
        e5uEA6p463qelG0oiU78NTf6qmuJ6X5IFXPjI4u9L+ZJc3w194oA1KpEhkOLW8og
        Q+q7kSgd3hs8VY07tvPpNsxsfo2kuPIWaj2Q1sQtEojOMqz1VSI8H0kxUFa0Dv0G
        40tRHmLztmdQZJOglir2fmRalbxSSpUiU9pU2XjXnhZ6qCj+u+9dSe6QgF3Ka5fy
        NfDu+U8SAokWPOVPbt0yoWSG4rqEvFhkWTmrx8Iog43rzOCI2ZzADh5iwEteV0OW
        rA1f1OYtqpfASw==
X-ME-Sender: <xms:MoMCYt87QKUAWoWx4CywnatmGryM5px211sUjQ3nnnoPlihyYvb0Hw>
    <xme:MoMCYhv0re2htqh_IFd_wxB_NBovAIgiVCpfJCsCDv2T8nF7b-e2JtLJk0MfxZSY_
    PFk_WbNZHGnExN4EUk>
X-ME-Received: <xmr:MoMCYrCJpeYC0b5otgRpaMh7d8B2sJmaJ1IFISpqIlhaFO6bju5o3s3FTDeuXM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepjeefkeevteffheevkeeitedviefhhffhiefggeektefhgfelvedu
    jeelgfefteetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:MoMCYhcsU8EY0bYgX0s-UajpRQc2pkczLJUixI458xtYdsKC6ycd2w>
    <xmx:MoMCYiM0ft0tPKQF32wXLBlt8JisZRxxWRH4FiH_GQ_nSYGKGSBqEw>
    <xmx:MoMCYjlBvpzB_d3I_WbvNWI20MpRvJzVJhbZ1L_NmlmZ8GyiCX6FJQ>
    <xmx:MoMCYk0DxVcpg5b5xkw8_tn_ZqxhWgaLhDloC7qCVOHEkssT0UycMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Feb 2022 09:50:26 -0500 (EST)
Message-ID: <1153d726-aed6-0b62-d0f1-6a1e2a878543@flygoat.com>
Date:   Tue, 8 Feb 2022 14:50:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Dealing with SUBLEVEL overflow in backports
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
 <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
 <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
 <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
 <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
 <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
 <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
 <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
 <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
 <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
 <1ac779ab0dfebdaa1ce7e5b6e900d49164e4afa9.camel@sipsolutions.net>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <1ac779ab0dfebdaa1ce7e5b6e900d49164e4afa9.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



在 2022/2/8 7:58, Johannes Berg 写道:
> On Mon, 2022-02-07 at 23:18 +0100, Hauke Mehrtens wrote:
>> The LINUX_VERSION_CODE is fixed since 4.9.255, see here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=42efb098c75f9d4b95f7cf35d3d52e80cc2fde82
>>
>> SUBLEVEL should still contains the minor kernel version number.
>>
>> We could extend the macros in backport/backport-include/linux/version.h
>> to check for SUBLEVEL manually if it overflows.
>>
> Right, but the thing is we don't have SUBLEVEL in the *C* code, only in
> the Makefile.
>
> However, stupid me? This is trivial:
>
> --- a/Makefile.kernel
> +++ b/Makefile.kernel
> @@ -60,3 +60,5 @@ obj-$(CPTCFG_WLAN) += drivers/net/wireless/
>   #obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
>   #
>   #obj-$(CPTCFG_STAGING) += drivers/staging/
> +
> +subdir-ccflags-y += -DCOMPAT_KERNEL_SUBLEVEL=$(SUBLEVEL)
>
>
> (whatever the name is)

Ah I tried this approach but find that this may break other modules
depending on our headers because the cflag won't come with be
inherited by them.

So probably we need to generate a header for this purpose as well.

Thanks.
- Jiaxun


>
> johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
