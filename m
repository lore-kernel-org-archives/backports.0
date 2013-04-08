Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24554 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935406Ab3DHK0e (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Apr 2013 06:26:34 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 2/8] backport a define for SOL_NFC
Date: Mon,  8 Apr 2013 12:26:07 +0200
Message-Id: <1365416773-12836-3-git-send-email-thierry.escande@linux.intel.com> (sfid-20130408_122638_737098_D697CCCC)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports: "NFC: llcp: Implement socket options"

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/include/linux/compat-3.10.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/include/linux/compat-3.10.h b/backport/include/linux/compat-3.10.h
index bfd9903..b4d8bc5 100644
--- a/backport/include/linux/compat-3.10.h
+++ b/backport/include/linux/compat-3.10.h
@@ -116,6 +116,12 @@ static inline void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
 	return NULL;
 }
 
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

