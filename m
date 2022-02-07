Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75617C433F5
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 01:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbiBGBTs (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 20:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBTs (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 20:19:48 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED388C06173B
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 17:19:47 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 56B175C0106;
        Sun,  6 Feb 2022 20:19:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 06 Feb 2022 20:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=Y0woTqyhsLX1aDVbGaShD1aOY5/Cjt1bURsics
        GKhME=; b=NXraW/2mW9edfunTwf9HbBfG5bWtqebpsLTqU8GLMxcvGz5jLqfu6Y
        sAIng5X2WpLV5FGdeg28m+M4oLJcj4RJ1Dn36JV8pqj7Kc4e/0hHqPBP0qVoLYUP
        4L8RCqvf/juB52YpfCdxgI5032/+fXUSlsirMBUCltTT+UJr51CuH2uKMjAIsham
        VV8HLLPK8ZlMXqFEUu1SiI0ULyPHN+CNRcRjWIB0jfZ5VKdvV0KYrcB4NKsi1KBA
        aUgraxxSFmrZDe8UhpJsV7cHKyXvkmSBBiTIQaNeuNkOrsTIpuu6MpoQgr5JBMlJ
        4P89KqNN5GgiMb/qowvF9odtidyzvsaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Y0woTq
        yhsLX1aDVbGaShD1aOY5/Cjt1bURsicsGKhME=; b=C8Opd+LYipq6j/Df2j8eK+
        86P90QjrnWn1qRXFcCKXFkwss9rf/RzN0IBDYEamRex/FN6C2I7ule1g9EgFhn27
        l/DKRuhj6rU1T5vUuKGgLuUQOnNqpx/6gGR9ddbTJITZbHhG56UOsrj6myxQ0ZK4
        WYq99oPh7UB64Ws+b+tMbibtULaRJyVRrTdIDb2qw32V6uSeSGeJiHr+yK0xxXcl
        frtXfLrLecYvLJEGh7ekWRK2p8ZbFb5KfOAM/lTiaTweou6uO/X/Y7FFjLrpmQUX
        NIX043Tq/sKEnjSEoItebFqttGmnQS9rqYbJl9cJxur2rtaXXMLUYPlw7VhGugMw
        ==
X-ME-Sender: <xms:s3MAYrumF-CnTzvb5pTkmYTmiqENkCiPdqg0APUGTtEkTqz5HNkyDQ>
    <xme:s3MAYscbONCW-NrZ3f8XeJVcF0Smub2cLdtKdCxUm5CR9CR6v6HwPXmUZ6eyPHCCc
    kztwJOKohInfPvrYVk>
X-ME-Received: <xmr:s3MAYuz1rDU7Fgu8g-TyD9Qu2WCbsqoTwA6aqcUjtGG_-4urU39dwKej98v8vQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvhffutgfgsehtjeertddtfeejnecuhfhrohhmpeflihgrgihunhcu
    jggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrf
    grthhtvghrnhephfduueeggffgtefhtedvgeejuefftdeuhfduffffheeftdegueevleeu
    fedtieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:s3MAYqMpCuLQUu1DfaXChCCCLimo1-7OjC50n3LjrzalUAQAtlVflg>
    <xmx:s3MAYr_wQ1gG-j2c8HH92XhA0EFyxwiE_byJTNtnhezavYdNv00KZQ>
    <xmx:s3MAYqW3M7J02l4Oh7DlkakW-ZN-SHuD6kVl_Ls5ZtoUEjlXPTXBBw>
    <xmx:s3MAYoFkcp-K2IlbJJ7ugVD8SztkUPLBHFIEPkPQZAiEHIOD5Tgi7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 20:19:46 -0500 (EST)
Message-ID: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
Date:   Mon, 7 Feb 2022 01:19:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Dealing with SUBLEVEL overflow in backports
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi backport forks,

I was trying to fix ckmake FAIL building against 4.9 for 4.9.297+.

I found that macro KERNEL_VERSION_IN_RANGE(4,9,297, 4,10,0) won't work
because SUBLEVEL 297 had overflowed 4 bit (255) in KERNEL_VERSION.

How are we supposed to deal with such situation?

Thanks.
- Jiaxun
--
To unsubscribe from this list: send the line "unsubscribe backports" in
