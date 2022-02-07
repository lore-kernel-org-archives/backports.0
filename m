Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98619C433F5
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 14:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiBGOHG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387735AbiBGNkF (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 08:40:05 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8831BC043181
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 05:40:05 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D26B75C0744;
        Mon,  7 Feb 2022 08:40:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Feb 2022 08:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=x8Kz9GwLxyJn/A
        VK7NpMmANWHDIomy+wmvSjXY2cADQ=; b=G6whhnpguPs3mU8QnM19U5rWzVvcDI
        TuyeBdXQ+8BG0pLsC+9zyu5UhWcCjmDXRz5qqkQqguPqWoigVgOY2dHGL0Zal2Ly
        spGeC59/LpzANpiw0aCdyV0SVtuKQLUnNuGMFYZnp2GHcbB+bp9WJFTpfIJoeTmg
        /v2rReMDlkGl+rW86TeE/FDTzw65mvhojAIb/HAF0IhEoEs1eMyBvuWX37kCEMAd
        eRmDIuhNn6xveAJ+JbDm9JqQUDIOoOD0oChS9RpsCwIss5He0zYdSa653Kdu0VZY
        bUScfuVThVex/644L3490p0O6oQb8wNRxtClM17atObp4grUduK8QbNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=x8Kz9GwLxyJn/AVK7NpMmANWHDIomy+wmvSjXY2cA
        DQ=; b=SbvcOGataxKQtKDoQOImH0YqEU92uNba07+9ZH1j9Cc+iy4S+FvRxpVsE
        obG792DttTb4d0sNjKjJlaAI0IiBcj3ucpr47cLvxLqHZcDnyJQlwvzQg9FDILwd
        7u9M6CjyPkJfQ9M56YwN1NGe/+5lD8eo2Hs3+1JI+O68HwGEaYnxz+0tdaUs7XCY
        O8S+zqpde+4QaoYKCeKrpo7l3zwGHnEM+ouZnvB4XNQTKQ8CiS3xz23lG3Z8mB9M
        z4f9rv/7RVIcEPrT4UqxcmUT5i5aGqggOTjXOxR3Bxng8oZIz4VsaQpwn1sjzvtU
        PFQ+I0Y7r0WBjnyrYyUKQbi66byMA==
X-ME-Sender: <xms:NCEBYoSoiJoMYRHpxzt44_AvHPsWpEOTQZ0cnactoz6GHfjcayG6cA>
    <xme:NCEBYlx0PK05qpTcP7p1XN7yit0fKTChWSYWzL9jtmO9ns143xU3GQ2nxKhf6OtmN
    XHEcJ_bPI6mzTYLRR8>
X-ME-Received: <xmr:NCEBYl2LeBdvyZq-x5qiY93Yns7M5N2qZ1sU_M19MK9vfZPo5H4l26lPoB9EcEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:NCEBYsBQKLDhVvFNvMaSYTABk65yFco7yw32Fkfc8NgXQui5AQ3o9w>
    <xmx:NCEBYhim-mbGHtMrWTB76lJ_h2v-u_0bDgLQ7HhQl-DVtW8_eMj5YA>
    <xmx:NCEBYork-HiY7Xc3uOPyBrL_UhBHAoa60EmC2qSe-tXivZCzjSJung>
    <xmx:NCEBYha0cMafJhr3eqa8H68uXwWS1DSAiEKxENOWFETG7FKby03Www>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 08:40:04 -0500 (EST)
Message-ID: <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
Date:   Mon, 7 Feb 2022 13:40:03 +0000
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
 <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
 <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



在 2022/2/7 13:04, Johannes Berg 写道:
> On Mon, 2022-02-07 at 12:52 +0000, Jiaxun Yang wrote:
>> 在 2022/2/7 11:11, Johannes Berg 写道:
>>> Looking at commit b29eec6c49, does it even matter? We can continue using
>>> bug.h which includes build_bug.h, it's just pulling in more than needed.
>> Sorry, in which tree?
>>
> In 4.9.x.
>
> Basically, we _cannot_ include build_bug.h where we know for sure it
> does *not* exist, since that would be a compile error.
>
> We don't _want_ to include bug.h from build_bug.h if we can avoid it,
> since it's bigger and more stuff.
>
> But for 4.9.x, I'm not sure we need to change anything, since we'll
> include bug.h from build_bug.h which should continue to work?

Sorry I didn't follow, the problem for 4.9.297+ is when we are including
bug.h, it just include build_bug.h from backport-include.
Then in backport-include build_bug.h, the include_next is excluded so
the real build_bug.h from kernel tree is never included and thus those
macros supposed to be in build_bug.h can never work.

Thanks.
- Jiaxun

>
> johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
