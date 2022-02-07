Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC01C43217
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359442AbiBGMsG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386406AbiBGLef (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:35 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B4BC043181
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A8C3E3202B09;
        Mon,  7 Feb 2022 06:34:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 07 Feb 2022 06:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=oLIIWU9P1CgrZeA7fOI0oj0r4+rGfG
        i1wlVzve5xwlo=; b=NVhwZVaeV61Wl+/5m29dPyLGVymK/Sz2VqcpDzYXqRF5SI
        FnKEWmQrvkUJmODcKguVWgAAC0Lt5AcGd5r1ETQvCGtzEbdvmtb37EiV9fVMYoGL
        LttEhd+YwgeDtHa80yE0kiaM/OCgV8kN6kAzppagr9KWA2LXN49fuWc3+bSBn6sc
        DT52Gh/7DxV8op8nl2gsVvxFo1roOdzy0sJbtEyH4+AtXbCLtsDOC+y0Wn+A4Trv
        kD5ArytjV7pMyTajcxs9xbXMPDDve2M1YyNoLPS1CGk4FJNuJympFRk4ug3YT/0t
        0SolWaWJtU8UW/i8W6yaFgKJAqzMgTNqxdsjdoMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oLIIWU
        9P1CgrZeA7fOI0oj0r4+rGfGi1wlVzve5xwlo=; b=JPbtpD3wIhA4fRttuEAB79
        texwFEIa2Niy422EFlEPjSO/aHTAyOFHcSrbBuvcpTcki+nLrmuxfErz5RQ4BMp3
        0N6ctHZHwt+TVezWA8tFHoLmwXN4ZEGhrCEhEgMaDwu5lckktLFgNNKRPN5NHQAL
        UywDgu7/rtiG9maBEBP3EaREir2S1soOoSoAoJLOOLvWKoqkBnfcIKiA6nPugO4C
        e/s4YZ7GqOrN7BGxPesGwWzOqKQz+AJ7E4TnHwpHu4aMI1QSxs2AbV+6nlPGluc8
        3r6iToeEO20Tfw/pw7ijLpJBp/9CJJ1453XRm15thIU/kImLHi8Jw2LoSXv5WX9g
        ==
X-ME-Sender: <xms:yAMBYjldhT5Bsc-N5JKQ0ZxaLwNGzJ-vCg8htDhIvaC9nbATpWMLQg>
    <xme:yAMBYm0DDBcJG6M32jw9-xsdb6xawMcuKsLOyXJOufFPT2pvYWv_cSIsAQJXIauZJ
    JRoWWeEwxW3wb8jg9E>
X-ME-Received: <xmr:yAMBYpq7DUHFBwghK5fpAG0AnTwpeUhlyl-m0NLm56YCvO6tCuW0v18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejffeivdeghffgteduuddutdfhvefhhfeijefhjedtgfegledvleel
    hfelueehffenucffohhmrghinhepkhgvhidrnhgvthenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhm
X-ME-Proxy: <xmx:yAMBYrmoQMyjoK_QoIDs4HhCG2Nla_RxPF_1uKJdjSisrliJ7-kPmQ>
    <xmx:yAMBYh3R7UPK_W7xcScIaBGX_sjg69c-2gOWLnEE03kqAyGShNQ-kg>
    <xmx:yAMBYquzxANfv9fe3bxkBEjUzqjVX9U3GPxohNakahe30wCGg3K0cg>
    <xmx:yQMBYvAEhW_GxyU9OySPO7KCll6Nb26dcN_3jCj4PADGKndM1dCWQg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:32 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 5/7] backports: Add QRTR driver
Date:   Mon,  7 Feb 2022 11:33:36 +0000
Message-Id: <20220207113338.214748-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

 Add it to copylist and wire up in Makefile and Kconfig.
 Also set minimal depdency to 5.2.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 backport/Kconfig.sources | 1 +
 backport/Makefile.kernel | 1 +
 copy-list                | 3 +++
 dependencies             | 3 +++
 4 files changed, 8 insertions(+)

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 8f430965..87ffca94 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -4,6 +4,7 @@ source "$BACKPORT_DIR/compat/Kconfig"
 # these are copied from the kernel
 source "$BACKPORT_DIR/net/wireless/Kconfig"
 source "$BACKPORT_DIR/net/mac80211/Kconfig"
+source "$BACKPORT_DIR/net/qrtr/Kconfig"
 source "$BACKPORT_DIR/drivers/bus/mhi/Kconfig"
 source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
 source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index e2a1a263..373fed96 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -39,6 +39,7 @@ obj-y += compat/
 
 obj-$(CPTCFG_CFG80211) += net/wireless/
 obj-$(CPTCFG_MAC80211) += net/mac80211/
+obj-$(CPTCFG_QRTR) += net/qrtr/
 obj-$(CPTCFG_MHI_BUS) += drivers/bus/mhi/
 obj-$(CPTCFG_WLAN) += drivers/net/wireless/
 obj-$(CPTCFG_SSB) += drivers/ssb/
diff --git a/copy-list b/copy-list
index 1be2285e..480a9fb3 100644
--- a/copy-list
+++ b/copy-list
@@ -36,6 +36,8 @@ include/linux/wireless.h
 include/uapi/linux/wireless.h
 include/linux/ieee80211.h
 include/linux/pci_ids.h
+include/uapi/linux/qrtr.h
+include/trace/events/qrtr.h
 include/uapi/linux/pci_regs.h
 include/linux/mmc/sdio_ids.h
 include/linux/ath9k_platform.h
@@ -83,6 +85,7 @@ crypto/asymmetric_keys/x509_public_key.c -> compat/verification/x509_public_key.
 
 net/Makefile
 net/Kconfig
+net/qrtr/
 net/wireless/
 net/mac80211/
 # MPLS labels, checked on skb->protocol on the
diff --git a/dependencies b/dependencies
index 623763a2..5de1bbe1 100644
--- a/dependencies
+++ b/dependencies
@@ -40,3 +40,6 @@ RTL8723BS 5.4
 
 # ida_alloc(), xarray
 MHI_BUS 4.19
+
+# sock_gettstamp()
+QRTR 5.2
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
