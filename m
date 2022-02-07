Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D820EC4167D
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383404AbiBGMsP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386362AbiBGLe2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:28 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EC5C043181
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:28 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 85A9332021EF;
        Mon,  7 Feb 2022 06:34:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 06:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=BpYppwKNqqoGtvnYgw33jYFU+5WYF2
        abhdippHcLdeY=; b=hnd/BE/9qswc8qm95D8Fj0ejQnP3ABxLYpLqIQgz2M2lvM
        cBeWIbx7515EtjU2tBfEIHRxL3FZNMXml6Qz7Wc+5FC9PuGYL0pvnRN7BZPytK+T
        8hiVYxmNWyeZK3KuArd6O3pOM6o6ZuzHzT9OnCODRUwAHq6ek7rriJRZi1IDRk4u
        9Oj6hvI5u8J2JZp5yw/Neuo7U9BbE1HgZR+9Liy5YgnZOCvSoMUvcdx23MalP9yg
        nuMfrpiNHu9otu3GqBMzKI4hMPIRnij7xS+MRVyQWLml5nCXnEP1cBR6Lx8HB/X1
        2DqS3a0wdXlEzUynQ4LYl1Gnxl4h9sDXdcP+MPdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BpYppw
        KNqqoGtvnYgw33jYFU+5WYF2abhdippHcLdeY=; b=W6fnmAGaLeS3nIpFFNs10+
        RXtk0kAKAV3zc9KiPTm5rSrdsk1uyAopSeN0JUzJUlBa4pFz+bdU3ATUrmClV9un
        kPnYw924ftQQlzJ8JXRU1KuCP+MPzVibaXqhGUyDBQpX1Gt9Scg1BxU8vB88iZmp
        Iw20x3uuoFfhraqpBUqlXndDEZYhTl3k4MCwo7Bd7xyritW4JB+vLVjSvWW++U8b
        r8bzOkZpG86IdecRyzzC6dcA7zEjTEtzO5uWEZO6tnt6lFkMjd/rar+czJxfBjpH
        6N9HzjVyYZdIB1LfBteaULMtT68dTfz3ZdeD6sHp9vKWmha/27e/uJ+m2x9BydhQ
        ==
X-ME-Sender: <xms:wgMBYt8dSoZS1A3Le4BKlmFJvvqh2N5Bpbqe2yWLKBSO860W6hONWQ>
    <xme:wgMBYhsu7_c9-diYDyLzcaIUSA_RpBcoFeyAua-sPRYU7sL1caQk6Mhws15n_nk8V
    lGZllnFDxz7dyhnl_c>
X-ME-Received: <xmr:wgMBYrA7h1bxN4GLVDKoWjTMLdzEEx0P7_aprg0vYUbXdPG7jlj2M-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:wwMBYhf2V0KLLgDlD3QOBamoK5FYBqCSbImn5adLgZCNhrti8BmdYQ>
    <xmx:wwMBYiM2BFJ9fDsTNpOF4TbE7G8W5qx3RlQdQdJ2smtzpIuHckTxSw>
    <xmx:wwMBYjkbmXc4doocA18caqgF5aCZudo89jdX4DJ-idcsdNGJZciDKg>
    <xmx:wwMBYrbEBH2MSxoo-nB1VwKTN-gQ5KLFhhT6E8fHhKRzLwfP7qV9Qg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:26 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 2/7] backports: Add mhi bus driver
Date:   Mon,  7 Feb 2022 11:33:33 +0000
Message-Id: <20220207113338.214748-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
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
