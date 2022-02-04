Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F667C433FE
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbiBDVlh (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbiBDVlh (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:41:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB19C06173E
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bBTU2iXAVTt1ajQkCdfQ89AJfnpSiGqQn1j07lD8KOg=; b=hmWwhvHiZ8Ibv0+zS4KdHBzn15
        sn0QHF6+HHOniYYPoCh5bttSo78pfqJPsamzwFGthe2V3xgHtDr2qyDisgXa58qpXSKpWa1nAdi3I
        XQi5IhYQedSwwEyPNqHNOWEDgdbYDSyHxMnYMRv7lswiZbcKZ2UrEsXJWEWT+3//QrExdep+etBJH
        C3HiVYZMBB+z7l2gysGTGuAepzSo4LUPx9MuFl/c9mN+5TTVQoC2He9xLbDYCFzXdeA+JRIGvm2hh
        oyPfh/6v7O4ety7fld5Xd/AuBlXOpdJ6RXzLvmwcBLblNqQd3BVfYGS8DKM+cudUk84K86VfKUiid
        q1vQufQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6Kk-005TzG-4Q; Fri, 04 Feb 2022 21:41:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hauke@hauke-m.de, backports@vger.kernel.org, mcgrof@kernel.org
Cc:     thomas@adapt-ip.com, johannes@sipsolutions.net
Subject: [PATCH 3/4] kconfig: fix backport syntax to work with linux-next next-20220204
Date:   Fri,  4 Feb 2022 13:41:30 -0800
Message-Id: <20220204214131.1306843-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204214131.1306843-1-mcgrof@kernel.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

kconfig on next-20220204 has a few changes. First the options
stuff has been deprecated leaving only the modules option. For
variables though we can just use shell. And if we use variables
on source we just need to use parens like $(FOO).

Fix all this.

This was tested with a backport generated for v5.15.8.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 backport/Kconfig.integrate |  6 +++---
 backport/Kconfig.package   | 18 +++++++++---------
 backport/Kconfig.sources   | 18 +++++++++---------
 backport/compat/Kconfig    |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/backport/Kconfig.integrate b/backport/Kconfig.integrate
index 45ab3ecd..d98c371c 100644
--- a/backport/Kconfig.integrate
+++ b/backport/Kconfig.integrate
@@ -30,8 +30,8 @@ menuconfig BACKPORT_LINUX
 
 if BACKPORT_LINUX
 
-source "$BACKPORT_DIR/Kconfig.versions"
-source "$BACKPORT_DIR/Kconfig.sources"
-source "$BACKPORT_DIR/Kconfig.local"
+source "$(BACKPORT_DIR)/Kconfig.versions"
+source "$(BACKPORT_DIR)/Kconfig.sources"
+source "$(BACKPORT_DIR)/Kconfig.local"
 
 endif # BACKPORT_LINUX
diff --git a/backport/Kconfig.package b/backport/Kconfig.package
index 250cdf3e..a933ead4 100644
--- a/backport/Kconfig.package
+++ b/backport/Kconfig.package
@@ -2,24 +2,24 @@ mainmenu "Backports from $BACKPORTED_KERNEL_NAME $BACKPORTED_KERNEL_VERSION (bac
 
 config BACKPORT_DIR
 	string
-	option env="BACKPORT_DIR"
+	default $(shell, echo $BACKPORT_DIR)
 config BACKPORTS_VERSION
 	string
-	option env="BACKPORTS_VERSION"
+	default $(shell, echo $BACKPORTS_VERSION)
 config BACKPORTED_KERNEL_VERSION
 	string
-	option env="BACKPORTED_KERNEL_VERSION"
+	default $(shell, echo $BACKPORTED_KERNEL_VERSION)
 config BACKPORTED_KERNEL_NAME
 	string
-	option env="BACKPORTED_KERNEL_NAME"
+	default $(shell, echo $BACKPORTED_KERNEL_NAME)
 
 # Packaging hacks
-source "$BACKPORT_DIR/Kconfig.package.hacks"
+source "$(BACKPORT_DIR)/Kconfig.package.hacks"
 
 # Code we backport
-source "$BACKPORT_DIR/Kconfig.sources"
+source "$(BACKPORT_DIR)/Kconfig.sources"
 
 # these will be generated
-source "$BACKPORT_DIR/Kconfig.kernel"
-source "$BACKPORT_DIR/Kconfig.versions"
-source "$BACKPORT_DIR/Kconfig.local"
+source "$(BACKPORT_DIR)/Kconfig.kernel"
+source "$(BACKPORT_DIR)/Kconfig.versions"
+source "$(BACKPORT_DIR)/Kconfig.local"
diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 5fb44780..8344a9aa 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -1,15 +1,15 @@
 # this has the configuration for the backport code
-source "$BACKPORT_DIR/compat/Kconfig"
+source "$(BACKPORT_DIR)/compat/Kconfig"
 
 # these are copied from the kernel
-source "$BACKPORT_DIR/net/wireless/Kconfig"
-source "$BACKPORT_DIR/net/mac80211/Kconfig"
-source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
-source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
+source "$(BACKPORT_DIR)/net/wireless/Kconfig"
+source "$(BACKPORT_DIR)/net/mac80211/Kconfig"
+source "$(BACKPORT_DIR)/drivers/net/wireless/Kconfig"
+source "$(BACKPORT_DIR)/drivers/net/usb/Kconfig"
 
-source "$BACKPORT_DIR/drivers/ssb/Kconfig"
-source "$BACKPORT_DIR/drivers/bcma/Kconfig"
+source "$(BACKPORT_DIR)/drivers/ssb/Kconfig"
+source "$(BACKPORT_DIR)/drivers/bcma/Kconfig"
 
-source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
+source "$(BACKPORT_DIR)/drivers/usb/class/Kconfig"
 
-source "$BACKPORT_DIR/drivers/staging/Kconfig"
+source "$(BACKPORT_DIR)/drivers/staging/Kconfig"
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 174322d8..1f690e00 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -54,7 +54,7 @@
 #
 
 config BP_MODULES
-	option modules
+	modules
 	bool
 	default MODULES
 
-- 
2.34.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
