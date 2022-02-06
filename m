Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B95C433EF
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346693AbiBFW1Z (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiBFW1Y (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:27:24 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB67C06109E
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:27:23 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BDFF43200EC0;
        Sun,  6 Feb 2022 17:27:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 06 Feb 2022 17:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=BpYppwKNqqoGtvnYgw33jYFU+5WYF2
        abhdippHcLdeY=; b=rzem8pXuP1K4po/NbW0NJ2+9AGjw0D3nnvFviitfOKB+Nh
        k7oecwUyN80wAYjG+O3xCaEuCjVXfjq+kHq4mirDuYE9c6o5UkguLYV/Znmltzdg
        F2wAdFPelmEfoe8wHLiohncfAbY73TVF4q87HRIO6No/qT4lIe4+JnJjUCeFoU8L
        V7TZgU8yjQlx12u7Pcskaxyr6eGmxra55Cy/Sdcz3wy0sRfWU7OM/lfVje44QGpE
        F1naRnY14olSVFjY78IUx0Pr5uf03XwFfiqU6/MI64pCxVdodzF9H95bsp54kbup
        jh3ynPnoPAsodGX6r5PGmEd8wa+BUTj8K+QxChfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BpYppw
        KNqqoGtvnYgw33jYFU+5WYF2abhdippHcLdeY=; b=Z5mv2tgseusUmQ6siqcPOg
        J8qmNtq37CNl/xiZYuFtd5pVchTC3dKvRSdZfIQQyuOSZiElgFPHAsi+Ew3jutcc
        YO5Q8FqPVxvnNmc3jaF5iNlYO+MeN4KK2RBG3CvueBfyQCvlzgETmepdFow5DRtS
        CSYVO2BNSf5ViOIHkRR8O44/1qPUo4H1Io6lyBqaw+GlH8qeofocyVvYmslICgpJ
        C/UlrNlTEYNXXODMi1Z2rGyivKlBwY2wZPRj52xUMyb2Y0ZCjiXXOgzsJdsECs6W
        ijJhp+d/SWZNWwefl6Lu+FNbf8O9fQ0+H0b6I6j88S0qqT5OSpzgvh8p5Lr/4LYg
        ==
X-ME-Sender: <xms:SksAYumEQrMG1OMjBGu5UP85oPc1KsXASxSrsUsPaBEL8Cl8CoQAgg>
    <xme:SksAYl0JfvOJiLgzHs0owfi5F-hSFWRCsN3uNMusAtvlodrEsaTFMNJ1T_dc_AHbb
    wh9XDwLF0OBasbr7Ys>
X-ME-Received: <xmr:SksAYsriLyiaN_CmB2M4YtCLFXhZof0uv3GemCrBcdVJdxydRNOJAAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejiefhgfetleekleffud
    ektdehvedujedvgeekkeejfefhhffhtedutefgtdffueenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:SksAYil4QKXZxvrfn_PkWELez3YwIlJZuEvA274YEbBiMrLCyjChgQ>
    <xmx:SksAYs3Dd9haTcInbbav0zIr-iwN1MPaO9qs7rAse7JYyLYYJy5DDQ>
    <xmx:SksAYpsoy4z7FMISMPfkUtYcyimFlKDF-NzKIXw4d6lLPWLNyhxxwQ>
    <xmx:SksAYqCdeKZr2YuJdKrJT1JAihNEPE4trLagyRaBwBCyvuVbEJ3t_w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:27:21 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/6] backports: Add mhi bus driver
Date:   Sun,  6 Feb 2022 22:26:52 +0000
Message-Id: <20220206222656.210655-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add it to copylist and wire up in Makefile and Kconfig.
Also set minimal depdency to 4.19 as it requires ida_alloc
and xarray which is too messy to be backported to earlier
versions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 backport/Kconfig.sources | 1 +
 backport/Makefile.kernel | 1 +
 copy-list                | 3 +++
 dependencies             | 3 +++
 4 files changed, 8 insertions(+)

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 5fb44780..8f430965 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -4,6 +4,7 @@ source "$BACKPORT_DIR/compat/Kconfig"
 # these are copied from the kernel
 source "$BACKPORT_DIR/net/wireless/Kconfig"
 source "$BACKPORT_DIR/net/mac80211/Kconfig"
+source "$BACKPORT_DIR/drivers/bus/mhi/Kconfig"
 source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
 source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
 
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 62baa945..e2a1a263 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -39,6 +39,7 @@ obj-y += compat/
 
 obj-$(CPTCFG_CFG80211) += net/wireless/
 obj-$(CPTCFG_MAC80211) += net/mac80211/
+obj-$(CPTCFG_MHI_BUS) += drivers/bus/mhi/
 obj-$(CPTCFG_WLAN) += drivers/net/wireless/
 obj-$(CPTCFG_SSB) += drivers/ssb/
 obj-$(CPTCFG_BCMA) += drivers/bcma/
diff --git a/copy-list b/copy-list
index be8539d4..1be2285e 100644
--- a/copy-list
+++ b/copy-list
@@ -91,6 +91,9 @@ net/mac80211/
 include/linux/mpls.h
 include/uapi/linux/mpls.h
 
+drivers/bus/mhi/
+include/linux/mhi.h
+
 drivers/net/wireless/ath/
 drivers/ssb/
 include/linux/ssb/
diff --git a/dependencies b/dependencies
index d8c3f106..623763a2 100644
--- a/dependencies
+++ b/dependencies
@@ -37,3 +37,6 @@ NL80211_TESTMODE 4.18
 
 # Needs aes_expandkey() and aes_encrypt()
 RTL8723BS 5.4
+
+# ida_alloc(), xarray
+MHI_BUS 4.19
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
