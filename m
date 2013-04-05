Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2367 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162502Ab3DEVUr (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 17:20:47 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 2/8] backport a define for SOL_NFC
Date: Fri,  5 Apr 2013 23:20:36 +0200
Message-Id: <1365196842-12992-2-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232050_012294_73E17CD0)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports: "NFC: llcp: Implement socket options"

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/include/linux/compat-3.10.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/include/linux/compat-3.10.h b/backport/include/linux/compat-3.10.h
index c4f279b..d6eab04 100644
--- a/backport/include/linux/compat-3.10.h
+++ b/backport/include/linux/compat-3.10.h
@@ -106,6 +106,12 @@ static inline void *PDE_DATA(const struct inode *inode)
  */
 #define SOCK_SELECT_ERR_QUEUE (SOCK_QUEUE_SHRUNK + 14)
 
+/*
+ * backport SOL_NFC -- see commit:
+ * NFC: llcp: Implement socket options
+ */
+#define SOL_NFC		280
+
 #else /* kernel is >= 3.10 */
 /*
  * We'd delete this upstream ever got this, we use our
-- 
1.7.10.4

