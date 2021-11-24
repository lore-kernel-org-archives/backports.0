Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F77DC433EF
	for <backports@archiver.kernel.org>; Wed, 24 Nov 2021 06:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhKXGDo (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:03:44 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:56672 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhKXGDm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 01:03:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id A9777744D74;
        Wed, 24 Nov 2021 05:55:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 36Q5Z02tSAJj; Wed, 24 Nov 2021 05:55:15 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 4C530744D71;
        Wed, 24 Nov 2021 05:55:08 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 6/7] backport: expose BP_MODULES in package mode only
Date:   Tue, 23 Nov 2021 21:55:04 -0800
Message-Id: <20211124055505.1267128-7-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124055505.1267128-1-thomas@adapt-ip.com>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Otherwise 'option modules' conflicts with the kernel
namespace.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 backport/Kconfig.package.hacks | 9 +++++++++
 backport/compat/Kconfig        | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/backport/Kconfig.package.hacks b/backport/Kconfig.package.hacks
index 6a429dd107fd..85c71d43c690 100644
--- a/backport/Kconfig.package.hacks
+++ b/backport/Kconfig.package.hacks
@@ -6,3 +6,12 @@ config NET_CORE
 	def_bool y
 config EXPERT
 	def_bool y
+
+config BP_MODULES
+	option modules
+	bool
+	default MODULES
+
+	help
+	This symbol is necessary for the newer kconf tool, it looks
+	for the "option modules" to control the 'm' state.
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 174322d8a340..87df1f731a34 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -53,15 +53,6 @@
 # Variations are obviously possible.
 #
 
-config BP_MODULES
-	option modules
-	bool
-	default MODULES
-
-	help
-	This symbol is necessary for the newer kconf tool, it looks
-	for the "option modules" to control the 'm' state.
-
 config BPAUTO_BUILD_NLATTR
 	def_bool y
 	depends on KERNEL_5_2
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
