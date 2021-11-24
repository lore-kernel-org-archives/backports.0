Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2708C433FE
	for <backports@archiver.kernel.org>; Wed, 24 Nov 2021 06:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhKXGDo (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:03:44 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:56674 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKXGDm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 01:03:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 75140744D6A;
        Wed, 24 Nov 2021 05:55:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id esuDlFYrOiHK; Wed, 24 Nov 2021 05:55:09 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id B8916744D69;
        Wed, 24 Nov 2021 05:55:06 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 2/7] backport: resurrect integrations
Date:   Tue, 23 Nov 2021 21:55:00 -0800
Message-Id: <20211124055505.1267128-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124055505.1267128-1-thomas@adapt-ip.com>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Couple fixes to fix the kernel build when using a built in
backports ("integration mode"):

- newer kernel kconfig doesn't seem to like evaluating
  variables with just '$'. Use '$()'.
- define BACKPORT_DIR in the integration Kconfig so we
  don't have to supply it in an environment variable
  (where it can probably only ever be "backports/"
  anyway).

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 backport/Kconfig.integrate | 11 +++++------
 backport/Kconfig.package   | 10 +++++-----
 backport/Kconfig.sources   | 18 +++++++++---------
 gentree.py                 |  4 ++--
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/backport/Kconfig.integrate b/backport/Kconfig.integrate
index 45ab3ecd4d57..10e9f2cb8ac5 100644
--- a/backport/Kconfig.integrate
+++ b/backport/Kconfig.integrate
@@ -1,3 +1,4 @@
+BACKPORT_DIR:=%%BACKPORT_DIR%%
 config BACKPORT_INTEGRATE
 	bool
 	def_bool y
@@ -29,9 +30,7 @@ menuconfig BACKPORT_LINUX
 	  this should we run into any issues.
 
 if BACKPORT_LINUX
-
-source "$BACKPORT_DIR/Kconfig.versions"
-source "$BACKPORT_DIR/Kconfig.sources"
-source "$BACKPORT_DIR/Kconfig.local"
-
-endif # BACKPORT_LINUX
+source "$(BACKPORT_DIR)/Kconfig.versions"
+source "$(BACKPORT_DIR)/Kconfig.sources"
+source "$(BACKPORT_DIR)/Kconfig.local"
+endif	# BACKPORT_LINUX
diff --git a/backport/Kconfig.package b/backport/Kconfig.package
index 250cdf3e4278..ce2f1cdb5893 100644
--- a/backport/Kconfig.package
+++ b/backport/Kconfig.package
@@ -14,12 +14,12 @@ config BACKPORTED_KERNEL_NAME
 	option env="BACKPORTED_KERNEL_NAME"
 
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
index 5fb44780d842..8344a9aaa378 100644
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
diff --git a/gentree.py b/gentree.py
index 05bb91b39291..4705ffa08fc4 100755
--- a/gentree.py
+++ b/gentree.py
@@ -701,7 +701,7 @@ def _main():
                            project_dir = args.outdir,
                            target_dir = os.path.join(args.outdir, 'backports/'),
                            target_dir_name = 'backports/',
-                           kconfig_source_var = '$BACKPORT_DIR',
+                           kconfig_source_var = '$(BACKPORT_DIR)',
                            )
     else:
         bpid = Bp_Identity(integrate = args.integrate,
@@ -710,7 +710,7 @@ def _main():
                            project_dir = args.outdir,
                            target_dir = args.outdir,
                            target_dir_name = '',
-                           kconfig_source_var = '$BACKPORT_DIR',
+                           kconfig_source_var = '$(BACKPORT_DIR)',
                            )
 
     def logwrite(msg):
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
