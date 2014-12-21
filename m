Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36599 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbaLURgn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:36:43 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 09/16] backport: do not call coredump when it was not build
Date: Sun, 21 Dec 2014 18:36:23 +0100
Message-Id: <1419183390-22169-10-git-send-email-hauke@hauke-m.de> (sfid-20141221_184347_949935_38A464B0)
In-Reply-To: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
References: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When coredump was included in the kernel backports is build against
then it could be that the prototype are used, which caused a undefined
references linking problem. This patch fixes the problem by only using
this when the driver is actually compiled in.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/backports.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/backports.h b/backport/compat/backports.h
index 323c908..ccc8972 100644
--- a/backport/compat/backports.h
+++ b/backport/compat/backports.h
@@ -13,7 +13,7 @@ static inline void crypto_ccm_module_exit(void)
 {}
 #endif
 
-#ifdef CPTCFG_BPAUTO_WANT_DEV_COREDUMP
+#ifdef CPTCFG_BPAUTO_BUILD_WANT_DEV_COREDUMP
 int devcoredump_init(void);
 void devcoredump_exit(void);
 #else
-- 
1.9.1

