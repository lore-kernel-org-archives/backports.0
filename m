Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5490EC433F5
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379797AbiEMQGG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382332AbiEMQGF (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:05 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A6B87
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id D83176E3A84;
        Fri, 13 May 2022 16:06:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id dCMdEAba64gu; Fri, 13 May 2022 16:05:56 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 5D9D06E3A7D;
        Fri, 13 May 2022 16:05:26 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 03/15] kconfig: fix backport syntax to work with linux-next next-20220204
Date:   Fri, 13 May 2022 09:05:11 -0700
Message-Id: <20220513160523.2944694-4-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

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
 backport/Kconfig.sources   | 22 +++++++++++-----------
 backport/compat/Kconfig    |  2 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/backport/Kconfig.integrate b/backport/Kconfig.integrate
index 45ab3ecd4d57..d98c371cd438 100644
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
index 250cdf3e4278..a933ead4a025 100644
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
index 87ffca94f7ec..c3b5ba64cc4b 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -1,17 +1,17 @@
 # this has the configuration for the backport code
-source "$BACKPORT_DIR/compat/Kconfig"
+source "$(BACKPORT_DIR)/compat/Kconfig"
 
 # these are copied from the kernel
-source "$BACKPORT_DIR/net/wireless/Kconfig"
-source "$BACKPORT_DIR/net/mac80211/Kconfig"
-source "$BACKPORT_DIR/net/qrtr/Kconfig"
-source "$BACKPORT_DIR/drivers/bus/mhi/Kconfig"
-source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
-source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
+source "$(BACKPORT_DIR)/net/wireless/Kconfig"
+source "$(BACKPORT_DIR)/net/mac80211/Kconfig"
+source "$(BACKPORT_DIR)/net/qrtr/Kconfig"
+source "$(BACKPORT_DIR)/drivers/bus/mhi/Kconfig"
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
index 174322d8a340..1f690e009214 100644
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
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
