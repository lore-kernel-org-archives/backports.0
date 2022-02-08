Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F30AC433EF
	for <backports@archiver.kernel.org>; Tue,  8 Feb 2022 15:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381822AbiBHPvp (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382030AbiBHPvj (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 Feb 2022 10:51:39 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD3C03E92F
        for <backports@vger.kernel.org>; Tue,  8 Feb 2022 07:51:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7C3F53200F9C;
        Tue,  8 Feb 2022 10:51:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Feb 2022 10:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=+2vUYTaD3+cfoF
        ViV7J3BAQSIFZ4Cuv4ykQNm73nLAA=; b=stXyTMb5sNDLEuuybu+yYgzF7ilFh5
        0gHtFpZTRthuveS+1c4YX/fRWyT0nH5tapxfJ4LE5UUKV1GCuKDQ52FEgDR8txap
        MxKGEEhr/oTHCeCG0J7+Hc07OJcQF0kwaD6cvo9kb9g5WY5jCY/7NpL2OQYTqYwB
        O64zpfOd17dFgZV17fOhHT3kZ30XhgyPe1OXXGkglM7sYrx5kPgrAjgX6CfRMjV2
        EEampGC2siny2CuQIJs7yFg63EPncu7q+3fXuWNf6+h0x+/OOPqnTxv3JIG4pHi0
        MGHROKPfdQRhn0vKhxFPqWeVRMVmoczA8zqJKRhGuVTiw5aDWzBnp/AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=+2vUYTaD3+cfoFViV7J3BAQSIFZ4Cuv4ykQNm73nLAA=; b=QdeP9BMM
        oUIko0PiVh/gAx99PWpULWYYLtanuhiqseZBDHYLPFKT0XnNV2LW2y+kuNzkN4N+
        kaPRzKmdaC/NgA9grPeL2qR6qb8UnBNt3DoEQLKbvHksxN0qySY59uLqzfMX7wuR
        Kf3htvZ51tVwk8R2z0fBioOJDjE6AXE3WspkhVA2vVFKaLWbehkJbo3PPHsyqjPp
        IqJohswgGIIIrtRZUxHAXjIzmWidT04S5FGDxCio3vMOt3JB8mQB3k9B8MRX+1wt
        U5qwCs0FgH+/yC9wHtU0p9tZSowfPCjTYFJ+S2uj5c8ZVRB/cXNu71wfgRcwzVcJ
        dFgh8r+q7kNR4g==
X-ME-Sender: <xms:eZECYnojeirzsi_P9nnX04-WgwSSE3HDNDDhXR5LXCl7bFjPfMg7iw>
    <xme:eZECYhrTTpqL5BGUy7InnWXPIK1QuayR6zAdmNNvJz9fu3hu8InO5K2P9DUWWMbC7
    6ppwJ3XmcKXTUE-s30>
X-ME-Received: <xmr:eZECYkOWkaTxwcpsjOYZGH-g0j8rWhSXCwakl0qQN50BAP1M9mFImTuCnfZ7N5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:epECYq6YpMOI3qpBpC97eaZUCtmsLBti9bSKjsdSR4ZcyQYiPQJ2Rw>
    <xmx:epECYm4a7Q5jO_jQ3T9KfsISdgrhhkxqn0FRGN21YJ_b0_Kw7bq5eA>
    <xmx:epECYiixAaPP4DTT6xdTRnOWTI6s_EzNKoVeINW3Fj96oEQDLhOlXg>
    <xmx:epECYsTLiLFM6qjEZydCwXn1-7mT0KTAFGbIozcT_qETjXyY_mKt9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Feb 2022 10:51:21 -0500 (EST)
Message-ID: <a3f573f1-7f61-b38d-813a-53d4af59f322@flygoat.com>
Date:   Tue, 8 Feb 2022 15:51:21 +0000
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
 <1153d726-aed6-0b62-d0f1-6a1e2a878543@flygoat.com>
 <c4e0b94283e55619822a2f5d45a91b5d33d3cfa1.camel@sipsolutions.net>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <c4e0b94283e55619822a2f5d45a91b5d33d3cfa1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



在 2022/2/8 15:02, Johannes Berg 写道:
> On Tue, 2022-02-08 at 14:50 +0000, Jiaxun Yang wrote:
>> Ah I tried this approach but find that this may break other modules
>> depending on our headers because the cflag won't come with be
>> inherited by them.
>>
> Hm. I thought about if that could happen, but decided not? We only
> compile C files in backports, which other parts would break?

For example OpenWRT compiles mac80211 purely from backports.

So for other out-of-tree wireless drivers they have to include headers
provided by backports, but they can't recieve cflags from our makefile.

So it will leave those macros undefined ad led to problems.

Thanks.
- Jiaxun

>
> johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
