Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF41C35271
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 11:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiBGL0C (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbiBGLJS (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:09:18 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D55C043188
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:09:17 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F03A83202A10;
        Mon,  7 Feb 2022 06:09:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 06:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=STv4v9SnskFne8
        5D+IawOZr3vD043HQF5LJsS1Lz8/Q=; b=EpB6UzFc97xMNnOo5u7VO+/PdLUVxm
        f7mHXpichsMOGY1QhXTm6qidNY/qC2Isp3dZhyWIvHYSH93dbHuaqhOtXPTG4Hwn
        Q+xKn6Hk1fICyWuQiFdT3DbyLfb2aZApJT6dPd17bfyvLD4r98v69SHbQS3VVg79
        9OAEY+HZiPEW5ZEPf7hradgzcwIh+yakHLa2nC+DSvY/eV9y8iaKeVKxdd84xl9Y
        hiW4R6tiLXe9bytXWNVLMDjHVcyG1++v3MSZ5BKfUCuiabFNVeaP8THiQFHGlI5z
        3YdivIkFmwA6hDKZnbpjoD7ybsVKkYqIuLTn60d7n+KGaIygJdZTaWhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=STv4v9SnskFne85D+IawOZr3vD043HQF5LJsS1Lz8
        /Q=; b=CQ1lKxBn9Asu7XyZlwxXQPGmQPpS5oIWWPJ/6/BFwIiL5FFrhcBWpBsaz
        JiKDcnrB8AQV8vzSR8nT84VIyCuJ/PaY6sDIl2wFRfWRnQ6Ur1m6JWnQaALOmtz1
        odDpTzUD7dn8bO4DUK9X0lxBgzMaNLkpIftS4iWPkq4GMo8rE0yCFhDi9YMJdspw
        qBKTnnK8S/ioHNV2jV0hV7B6BpJg4Sdjr7qy0wKX6StjsZWlpqUa7n4zAS7jiAOy
        ocABNjdadTphUxUxy5Z4POTqpCJvHUFPgRKxfP/I8CS91bD4DwcbNpmKvunGwmTm
        S6lN+HcGhL5y0ZcIrv4rrCKggQr0w==
X-ME-Sender: <xms:3P0AYmn9HRGFZ1mpj0TTqRIgN07jBVD4FOi45K7LpJ8mVBFzgKsutg>
    <xme:3P0AYt1XMy7czlvl9W_cF036IwZVuiaxdbIliTLt2bfWZIl1i1WE-x4qpCXHj4ayB
    h0KEBL0HM0JgtzoiCo>
X-ME-Received: <xmr:3P0AYkpP6WmjehZ-M2yDHT324qCxkHE_JeAayYlcoG2GJx4hvZqjwD_eIFA8kR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:3P0AYqmqrj6SeSBvseRmc-HQ1tekmau8oHQNZ4hZ7rlYtfgEATkIWg>
    <xmx:3P0AYk1Ewrt2y7fpVRci-NpmiVNCRzswE_WTV8WN38lDSKUZJ8-jag>
    <xmx:3P0AYhvf9rhTylMwSnYuLUHSpuOhjI1ThRLK6g_-e1RIW5votTR5cg>
    <xmx:3P0AYh8CR01vkpbQM_lSOqEffPrQj4ZDLnsRWRQlSZ7aZ-9TkJm8Ug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:09:15 -0500 (EST)
Message-ID: <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
Date:   Mon, 7 Feb 2022 11:09:14 +0000
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
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



在 2022/2/7 10:50, Johannes Berg 写道:
> On Mon, 2022-02-07 at 10:15 +0100, Johannes Berg wrote:
>> On Mon, 2022-02-07 at 01:19 +0000, Jiaxun Yang wrote:
>>> Hi backport forks,
>>>
>>> I was trying to fix ckmake FAIL building against 4.9 for 4.9.297+.
>>>
>>> I found that macro KERNEL_VERSION_IN_RANGE(4,9,297, 4,10,0) won't work
>>> because SUBLEVEL 297 had overflowed 4 bit (255) in KERNEL_VERSION.
>>>
>>> How are we supposed to deal with such situation?
>>>
>> Hm. I guess the only way would be to somehow make a Kconfig variable in
>> backports, that uses the Makefile settings? But env="SUBLEVEL" doesn't
>> work, so not sure, maybe some Makefile trickery to extract it and write
>> it to the config?
Or is it possible to persuade stable forks to define LINUX_VERSION_SUBLEVEL
on existing stable releases?
>>
> Or just find a way to handle the specific area? Is this for the
> build_bug.h stuff?
Yes, any idea?

Thanks.
- Jiaxun

>
> johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
