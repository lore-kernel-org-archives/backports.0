Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E71C41535
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382325AbiEMQGT (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382328AbiEMQGS (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:18 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D723631A
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id A2A926E3A89;
        Fri, 13 May 2022 16:06:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id hAA6J4egQP_N; Fri, 13 May 2022 16:06:14 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 657876E3A73;
        Fri, 13 May 2022 16:05:29 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 10/15] backport: expose BP_MODULES in package mode only
Date:   Fri, 13 May 2022 09:05:18 -0700
Message-Id: <20220513160523.2944694-11-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Otherwise 'option modules' conflicts with the kernel
namespace.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 backport/Kconfig.package.hacks | 10 ++++++++++
 backport/compat/Kconfig        |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/backport/Kconfig.package.hacks b/backport/Kconfig.package.hacks
index 6a429dd107fd..3c97304525c1 100644
--- a/backport/Kconfig.package.hacks
+++ b/backport/Kconfig.package.hacks
@@ -6,3 +6,13 @@ config NET_CORE
 	def_bool y
 config EXPERT
 	def_bool y
+
+config BP_MODULES
+	modules
+	bool
+	default MODULES
+
+	help
+	This symbol is necessary for the newer kconf tool, it looks
+	for the "option modules" to control the 'm' state.
+
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 1f690e009214..87df1f731a34 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -53,15 +53,6 @@
 # Variations are obviously possible.
 #
 
-config BP_MODULES
-	modules
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
