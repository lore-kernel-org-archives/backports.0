Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E889C433EF
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbiBFW1d (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiBFW1c (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:27:32 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B797C06173B
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:27:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7A3FB3200A3E;
        Sun,  6 Feb 2022 17:27:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 06 Feb 2022 17:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=gJFDttsg6PwCMwcFuyciI7AGWQUwzu
        2HuP/zOpmnjQg=; b=ymvUqMs3lMiy4jJeYGy+wtT9X/SDANwdRl22nDt2cGvqig
        B6gSwHl2gkRL0n13Pagp24MoICgymKgEJW+gGDcdG36wxRjSG0uupZFqSzf0f3vs
        PMpti3Srh5voLiOent25wfeU2z+0PJdv+DpNJ/XZn1KawMyFNY0SCGWcmiSkTmC7
        YiDtqQOVutLINhgL48gSfL7G90DylDcgFmV23S07sLst0u7jdtbP7pKXx6lhc2Qq
        WkYFFnHkvW3OEOL4HByEIg8k0GVgaSRpWkG9AiohVUK2OUqCyYrqfclwbsJvTcWx
        mhBF+POnLG8cvsZcq0sDPF097VdgYk6/zaSoIpWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gJFDtt
        sg6PwCMwcFuyciI7AGWQUwzu2HuP/zOpmnjQg=; b=HhbzuLRJBbsGe3kN7NZpMO
        cjoVzgCIPsqRgsPXKTHaxh5Vfyi9pI2YAuNP9rejtkTvib/gQtDgzn/vNs7JtVX1
        l1DOwX7eJgGZrnVoh6OV2EpvK7UCMgt61NEuIYFWtQWqUyElpLBqdQ9eEte/v/ob
        YwNrT3+oOsuSjlJDanws2wXq2Va3GaLBhYB122KhpRVZP65P3pcVC6XL5zfuKZ7F
        W3O+iYrQK274B4okEr3gMC0ZAB5275tbNVaZ0SiyQ9Voh2P4Nz42pDiV4vPT3pQq
        4KEmR2CjiLbY2NCCAJb6YdcFiTh86dxWSXZRTlvMvyuRuBNzKCCgarpgOSNrBWYw
        ==
X-ME-Sender: <xms:UUsAYnI73YPSX3PtFGLebzX4qHv5x5X2fsODneOS7UYl03indH4LzQ>
    <xme:UUsAYrLXqNm0GwwEPgJ3TGsb_Dm0kMMMDVLbWRp-reBBR9Kx4XCXJsMfjzR4a2jQX
    kODkhbqD5_oMc69_wo>
X-ME-Received: <xmr:UUsAYvsaJoqhwviJn3dndRMk5hAlLGujQpCm1Ye2e5JYQEK8fCXLrI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejiefhgfetleekleffud
    ektdehvedujedvgeekkeejfefhhffhtedutefgtdffueenucevlhhushhtvghrufhiiigv
    pedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:UUsAYgZrvtwX4VfMfl9-iaTxUxMTufyXP3jOG3DbR3kkGZHCBXvBJg>
    <xmx:UUsAYua5BiuLV_OL7Tnis2S_j6ykoZMgEgmhPCNcBS-Jc2Nyw5A0vA>
    <xmx:UUsAYkBn0LEi2Bl8yP4wyxWQ7hnyxo5sfIoLXNRG4pupq5VaqXsneA>
    <xmx:UksAYtndXC7N5h8iEJuO6Bq4C_LR0Is7mp2s71F97iO0-CbyPloUNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:27:29 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 6/6] defconfigs: Refresh for ath11k
Date:   Sun,  6 Feb 2022 22:26:56 +0000
Message-Id: <20220206222656.210655-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add defconfig for ath11k, also add ath11k runtime dependencies to
wifi defconfig.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 backport/defconfigs/ath11k | 14 ++++++++++++++
 backport/defconfigs/wifi   |  3 +++
 2 files changed, 17 insertions(+)
 create mode 100644 backport/defconfigs/ath11k

diff --git a/backport/defconfigs/ath11k b/backport/defconfigs/ath11k
new file mode 100644
index 00000000..9ca4b310
--- /dev/null
+++ b/backport/defconfigs/ath11k
@@ -0,0 +1,14 @@
+CPTCFG_MHI_BUS=m
+CPTCFG_QRTR=m
+CPTCFG_QRTR_MHI=m
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_WLAN_VENDOR_ATH=y
+CPTCFG_ATH11K_PCI=m
+CPTCFG_ATH11K=m
+CPTCFG_ATH11K_DEBUG=y
+CPTCFG_ATH11K_DEBUGFS=y
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 936203d9..774b0823 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -58,6 +58,7 @@ CPTCFG_MAC80211_HWSIM=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211=m
 CPTCFG_MAC80211_MESH=y
+CPTCFG_MHI_BUS=m
 CPTCFG_MT7601U=m
 CPTCFG_MT7603E=m
 CPTCFG_MT7615E=m
@@ -86,6 +87,8 @@ CPTCFG_PCMCIA_ATMEL=m
 CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
+CPTCFG_QRTR=m
+CPTCFG_QRTR_MHI=m
 CPTCFG_QTNFMAC_PCIE=m
 CPTCFG_R8188EU=m
 CPTCFG_RSI_91X=m
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
