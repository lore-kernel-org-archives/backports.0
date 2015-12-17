Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50790 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbbLQM4T (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 17 Dec 2015 07:56:19 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: add BIT_ULL
Date: Thu, 17 Dec 2015 13:56:16 +0100
Message-Id: <1450356976-14446-1-git-send-email-johannes@sipsolutions.net> (sfid-20151217_135621_152281_E7DE5434)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Add BIT_ULL() to bitops.h, this is only available since 3.13.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/bitops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
index b0e9283e93c7..86360d04823b 100644
--- a/backport/backport-include/linux/bitops.h
+++ b/backport/backport-include/linux/bitops.h
@@ -16,4 +16,8 @@
 
 #endif
 
+#ifndef BIT_ULL
+#define BIT_ULL(nr) (1ULL << (nr))
+#endif
+
 #endif /* __BACKPORT_BITOPS_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
