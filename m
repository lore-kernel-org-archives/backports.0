Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1398C433EF
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbiBFW1a (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiBFW13 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:27:29 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA8C06173B
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:27:29 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 865BA3200C20;
        Sun,  6 Feb 2022 17:27:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 06 Feb 2022 17:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=oLIIWU9P1CgrZeA7fOI0oj0r4+rGfG
        i1wlVzve5xwlo=; b=RjWAw5D2WXAs+Eak2edkRQmNC9pfwe57tHIeaNVBWBedf7
        OzNCEASjguo38ND0LAzo7U63/XRhbwA/+MyfkG9yNJ57g/XlY4aqAS2w8l8+3GPU
        OidmJSbArwn7sJvkNmtyCiROsYO4opkMnY0+rdxvfjJZImmrtQQHr/SBxoZ93hV/
        WmnTIcTaKoxXj9FMAYQmyScAxDegOb4djRiDuiYbYndg2TPdp8r+D7H8v3PCpglx
        YS7LIo2p64j1p4m2E8xpIJcV0V66dz6CnSgntkasq8n4FYXv7Iz+otfnMBy3Popb
        9u7TbGA6JqeuVOt6xHljRqozWomYmIeu5B9fRcmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oLIIWU
        9P1CgrZeA7fOI0oj0r4+rGfGi1wlVzve5xwlo=; b=hVuCAzZdbx1Xi4ooycFnK4
        QEJU27dAfafSJ+Ad5vXmnoTTajZRY8OOGc2Lbvh2uDi4BIrT+bPZWT0XumZAH6wL
        2tdqWwupfcIZoQBCgXNvSuDn7/gIMhKuisD9xj9D+rtGMbMWPN169uJ8i90dH9qG
        Mgqq1W6EnYo3bZJnoxIx5UYjR1GWJ8GdAuhwxOG40+wzZoh4tkZRRSX/wNCapbCd
        ZTiZbgeYsYPVqlCaWm7/+P46UM7Q0Pn4X+16np0yWZSkeWROrtYZBk2ElipqRXsG
        /dkVRFtm03O15nCLw7Dre0AoJcrh+em53Te1cL0SOUXmGTp3kcrZuOsGvCHa234A
        ==
X-ME-Sender: <xms:UEsAYgQX92T4eTkVXU80jRnxszksHAikXBnVQFzoxd-mkU24171VAg>
    <xme:UEsAYtyAiPNO1OkgqO-FXrBc6QLQrq4d4uQXgyUgkpfnhHuzVZ23dbjs6KcnH3QIz
    vw-emnhUBfKdOC1WvA>
X-ME-Received: <xmr:UEsAYt3dFN96ELWx8HN4hEgqzCT5M1GzDeqj5QHvrjmAF88vNmZfjS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepjeffiedvgefhgfetudduuddthfevhffhieejhfejtdfggeelvdel
    lefhleeuheffnecuffhomhgrihhnpehkvgihrdhnvghtnecuvehluhhsthgvrhfuihiivg
    epudenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihg
    ohgrthdrtghomh
X-ME-Proxy: <xmx:UEsAYkBx1i0tPzM7c45gfChqxtUrcDgzL_aoLJDc8sLCWd5lQxqgEw>
    <xmx:UEsAYph8UVHS7qPNWN4eo_iN-MvmQBmw1n4XjxKT9_X2tqGMEwQxxg>
    <xmx:UEsAYgo5qQKEageFWbmY0Nr_ZMtg_eR-TWw8QnG3PbeMLD7fpMfdjg>
    <xmx:UEsAYsuEpj728mE-rv7rau-RrVGHCXcV8bET4vdnjkqlFFIAvHHrDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:27:27 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/6] backports: Add QRTR driver
Date:   Sun,  6 Feb 2022 22:26:55 +0000
Message-Id: <20220206222656.210655-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
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
