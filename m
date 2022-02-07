Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB86C433EF
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 13:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiBGNfX (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 08:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447012AbiBGMwF (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 07:52:05 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5233C043181
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 04:52:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F59C5C0424;
        Mon,  7 Feb 2022 07:52:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Feb 2022 07:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=jAlXRvtxOGflhP
        tr7XYxy7R3qR962EnrMGPOPN+X2do=; b=m4Y0pp0zqNHdJt6rMMsJgxPh6XM8Kt
        fGtf0ZzP88o/5enIji/x5UuvFKgcYlrtxr1txm4XEGiT8o/En1hf6SGYAA+nZWyW
        3ZVvukcjSikJbmduJeg6aHJ2uKKOPzmqXf/UW4yhmi5Y6iD/eGWD4zmMI7FJ9JHC
        xjIS8ud0oyRWnY3+Kg7+5v/DmXNt75QK/ZJRG7iao2vlD0D/Xy7TwvrgPpAJ3yL9
        hapq3JZrgPJYiEEplCOuIROiTJbm5FHUuGpLmG+JtcErKYJ1Y4uujkcu1k/X7BI5
        WT/Qkfxhh3V0Y76xEle+4aw+Df58em0aFtOt3vq90PlPFZcR5VCROdIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=jAlXRvtxOGflhPtr7XYxy7R3qR962EnrMGPOPN+X2
        do=; b=QxK/nZNuA/D4kjAR7UHmgnau0nkgPtlcXi9Fb3ee/j4pqhnC9HOXr4di/
        5MogaMwOhurEbxj1KEqQSth9VIOHceS1RtkQiOQPucMBdoESwDuwMu3VhYkOBKtR
        Iuh/mbt5hGwPhBdKtRvhqARrHlfeA+QKIecuTiCzmAPJZnEHjlB6fripeulSsRzn
        3TIDYiBP3lKTPmsr/NkIWACrUsUzB83/AB5t3VpPOFrPdocG2kHubUWTEe15Z4xb
        BTdxyRz04hRGGblVwlhMpUGUzyvI/Vw1AzAdeHUrw1gotXhZ8cHC0CZRC7lUtPkk
        pg6xY3Eka40D9nE0rwJf+iYGAp0VQ==
X-ME-Sender: <xms:8xUBYtwUvzmGOppg-Q9u6yX9PmkylXQbLZK_WLdsIJ6VS7hPs5vIKw>
    <xme:8xUBYtSl340S15b6YCUsiSzYd8Aem8E9Svac2N6sC7Q_UQss-MmwwYqkrwCMBEPz2
    rXLsDF9suu6rMR75x4>
X-ME-Received: <xmr:8xUBYnVrBgbwPLGpdMztwrKK77i92TytN98yCRxzfTF1GHVXGafTIvxunJJhWws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:8xUBYvhKBiAigkvPw5Ectpfw7wajPy88EbBLqAZotmfiIIIq1Rj9Lg>
    <xmx:8xUBYvB_7LLyyUwDrEq2b2eQJXKNIBW4iXIDuQGP0EkpuDP0OIYStA>
    <xmx:8xUBYoK1yjvlrnoAR7ySYENTJyEfqnUbDKxtAJF9Ul4MOGGVSAPwzw>
    <xmx:9BUBYk69jgIO4OLLq2SA3qo5zUR5nNOwf2O5lr5fYcU-PVKFEa07Sg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 07:52:03 -0500 (EST)
Message-ID: <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
Date:   Mon, 7 Feb 2022 12:52:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Dealing with SUBLEVEL overflow in backports
To:     Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
 <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
 <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
 <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
 <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



在 2022/2/7 11:11, Johannes Berg 写道:
>
> Looking at commit b29eec6c49, does it even matter? We can continue using
> bug.h which includes build_bug.h, it's just pulling in more than needed.
Sorry, in which tree?

Thanks.
- Jiaxun
>
> johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
