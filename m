Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37590 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWxz (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:53:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/10] backports: backport PTR_ERR_OR_ZERO
Date: Thu,  8 Aug 2013 00:53:20 +0200
Message-Id: <1375916005-16411-6-git-send-email-hauke@hauke-m.de> (sfid-20130808_005356_053614_AB8D3FE3)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports this patch:
commit 6e8b8726ad503214ba66e34aed69aff41de33489
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Mon Jul 15 11:19:32 2013 +0930

    PTR_RET is now PTR_ERR_OR_ZERO

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/err.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/err.h b/backport/backport-include/linux/err.h
index f62e3bf..5583c2f 100644
--- a/backport/backport-include/linux/err.h
+++ b/backport/backport-include/linux/err.h
@@ -23,4 +23,8 @@ static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+#define PTR_ERR_OR_ZERO(p) PTR_RET(p)
+#endif
+
 #endif /* __BACKPORT_LINUX_ERR_H */
-- 
1.7.10.4

