Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACEBC433EF
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346525AbiBFW1X (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiBFW1W (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:27:22 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23AC06173B
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:27:21 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D3C153200A3E;
        Sun,  6 Feb 2022 17:27:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 06 Feb 2022 17:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=+wNikXSbGU2o4eMTKXjWwZmxi2ddjU
        dnnedm2bE6V74=; b=ULtk20H1GR5Hc7nuRcwtceDxH7hcICvUddv3puFXwMdi58
        erz108yKJo2JHD4RG/Cjh+9WnA1zap5yheLerlex4VHpPUNJGr0XzNvShaXv2DKg
        HSWzEhBYwmFf8a7E9UEoFooibT3MAJsHmJBsRGupBjtw53vUAlaac1HCBCMrOklR
        4YzMV7LUvvTHqeUVHSL6e2RRgrIrG7Wydi0JRtrBOAg5e0qJbfp2Hcfcrw8/j26R
        IejwV/DWsRDuUVmRGxu/MUJHKJG52mKqq7NBUjIhDULAf9XG2yMz5MW/QvjOn2Vn
        e33//jA0x4n2rpET8mIfhFwCyVf/L+426GDAiLFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+wNikX
        SbGU2o4eMTKXjWwZmxi2ddjUdnnedm2bE6V74=; b=YRpDSBwuprim29xBjhO+WH
        VNo6vH1Ty6VLc4Iak6C81V+uRutuASpKS9kyenF4s7ZKqF3F+AM8nv1rOg2fowYP
        uqT/FdJCKYVcfwJxHqdHRxDoSXgqP4qim2q6irh/WPDERSeOuibKPu87L+AlraA9
        GFE8QLuuBgcs6IE+DZBicVYsLv8WQtURXfoALd7c8nL8gxNCvlQG8DkOI+dCqXwS
        cN0slXK9zo+ao7ERgWOH0eqCyupH//Vur+F5c5Vv6Nc39Lyke34DHeIwNLh9Zora
        TF6F8UyLqlA3SF29zqL7hxle5r8ofr5Qo/2GqH4zR1IE1nnnwCgpfz1+AffEZwoQ
        ==
X-ME-Sender: <xms:SEsAYvwkDcIUBhJgufOJgrEj3YG_9sKWvkzlb765Nv1n6ZpLjVB62Q>
    <xme:SEsAYnRDGVdSzArdXwJjhadTQJWtiK1HxWuhNhKl85Tn1JmZ9kZ_T1N-N4ERtltOO
    D3iRoXIK-F1JX0Y5so>
X-ME-Received: <xmr:SEsAYpVIrIZ5oNfgIpO7L-wXx5rth2WYNYn44Qk6WIGwUx03YILxSKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejiefhgfetleekleffud
    ektdehvedujedvgeekkeejfefhhffhtedutefgtdffueenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:SEsAYpgx0IScC_0T4cGSJd1ZXlLp2C1qB8Qyqsh-cFlbVMhvEkw52w>
    <xmx:SEsAYhByl12qWBFluOJTE1csGKFGYCJO1spD83A35-QfAd_qH5EF9g>
    <xmx:SEsAYiKNnHEr2JonwQMs0iozVYVPKIzmB__-kRaKUgtUl5CSQt-fUA>
    <xmx:SEsAYkOxeEkRL8_TRjrHpelSGoCBxmGoKkV9bYrQRo9UhBdFgsoZpQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:27:19 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/6] headers: Add MHI stuff to mod_devicetable
Date:   Sun,  6 Feb 2022 22:26:51 +0000
Message-Id: <20220206222656.210655-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Backport from 5.7.
It is required by MHI drivers to probe modules properly.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 backport/backport-include/linux/mod_devicetable.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index ec0a3e62..fc9beedb 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -14,4 +14,19 @@
 #define HID_ANY_ID                             (~0)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,7,0)
+#define MHI_DEVICE_MODALIAS_FMT "mhi:%s"
+#define MHI_NAME_SIZE 32
+
+/**
+ * struct mhi_device_id - MHI device identification
+ * @chan: MHI channel name
+ * @driver_data: driver data;
+ */
+struct mhi_device_id {
+	const char chan[MHI_NAME_SIZE];
+	kernel_ulong_t driver_data;
+};
+#endif
+
 #endif /* __BACKPORT_MOD_DEVICETABLE_H */
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
