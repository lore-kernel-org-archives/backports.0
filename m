Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB047C4167B
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382613AbiBGMsN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386339AbiBGLe0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:26 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B20C043181
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:26 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 940ED3202B37;
        Mon,  7 Feb 2022 06:34:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 07 Feb 2022 06:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=+wNikXSbGU2o4eMTKXjWwZmxi2ddjU
        dnnedm2bE6V74=; b=lomC4ZkLjqgtXgEKVhUmg5bEoGg4Xo/BhJHkY6yWT4Xomo
        FGp7EoMZLegULc1icVWjGJxQpGz6cFVS+jkb+KnUvN2ZGoZfeo3c9txPepuNh0V3
        XBz/cO9rJ/HmzUdl4/KkNV4SMaeeOVJuZwFLBLBeYv6Vvw/H/4SqpBrAEj4K0ufw
        5Nbqwec3lfQ91BbI3KhJG4babZKq97Da8zXr2uSH9N6G1tIRWM6yTsZ+uMeZT301
        qdIsDLuQ1gFJ1r7H6BlN6L9g1BC2u79GfA68S9DWKYhDAcyJxYXtNU/IaJMkjMRl
        a9Yq/dMX+Zh++cUbqseJDgAPiQ6eWgPuFhj76Bqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+wNikX
        SbGU2o4eMTKXjWwZmxi2ddjUdnnedm2bE6V74=; b=XfVZbA1DUgKQLWzj9S5OJL
        R3tHE/t9TY7cEpWVgytiwynEDHlhxHSWSx2TdowHUhc0UytYI4wJHx8RGDmrjGNE
        Ig1EuWUEWwkO8SreJEk7XomL0hlL7X5J4eXiVEci5w2+bPZ3x/ulyw4YBOiwLPwa
        B3PVXt2Ys8Tzb8iw12G5LOwkuVItt1c7aW/9qzLOpXCuSEiZTF1PWqLbCSjPiU8Z
        TSt7/wLwYuc0Bs6UWwBWjB9bXMN6iOEstspQpC1ot0MBD05IU+MYxcyE3LkDtfAR
        EPb1y+85Z7V6GqZP8piIzUk692YrPf51wrVDMBbp5qo+wyE0qKm4kERC92FfVJGg
        ==
X-ME-Sender: <xms:wAMBYlnO6EV6g2Gck5p2Z9rLSlKhsH0h5hBCo71DYiRIUduU6NIaSQ>
    <xme:wAMBYg3uhZ0T_w5Zgy8IDtfNIpDKAZnFIWNfsxdDetMvW-D6aUgDzXPD3jJHMjqYD
    Qi78QnaGX9Z-kIfJPA>
X-ME-Received: <xmr:wAMBYrphQhcrsJEGmNyVku11n192ZvjxhtLn2lkz8w3FGY2cOshx2M8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:wQMBYlkkbDPGYlrDR4R5k-P7_WAVAcZI4xzhrC2o5FbxOm4357XxNw>
    <xmx:wQMBYj00A_riteEZ-_wE_uDS4H0Ybr3stBOFQWxtjBZp4AcjlbdEGw>
    <xmx:wQMBYkuobuOK84di7HuDVu6BqzNwPX9efdpEWDb9KUAtuRLee_AA-A>
    <xmx:wQMBYhCsd2TTYpxifrTi-AaEympR3Fwkd7k-feFQUyqjkgMTvLREkA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:24 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/7] headers: Add MHI stuff to mod_devicetable
Date:   Mon,  7 Feb 2022 11:33:32 +0000
Message-Id: <20220207113338.214748-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
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
