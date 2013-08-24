Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52974 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab3HXO3M (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 24 Aug 2013 10:29:12 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] backports: fix typo in define
Date: Sat, 24 Aug 2013 16:28:58 +0200
Message-Id: <1377354539-9202-1-git-send-email-hauke@hauke-m.de> (sfid-20130824_162917_466748_CDBFCBAE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes a build error one some non x86 systems.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
index 0aadc80..c99719b 100644
--- a/backport/backport-include/linux/types.h
+++ b/backport/backport-include/linux/types.h
@@ -21,7 +21,7 @@ typedef u32 phys_addr_t;
  * as of 2.6.28 but x86 and ppc had it already.
  */
 #else
-#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defned(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
+#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
 #define CONFIG_PHYS_ADDR_T_64BIT 1
 typedef u64 phys_addr_t;
 #else
-- 
1.7.10.4

