Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49597 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbcD3VBG (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:06 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/16] header: add shash_desc_zero() and ahash_request_zero()
Date: Sat, 30 Apr 2016 23:00:37 +0200
Message-Id: <1462050048-8953-6-git-send-email-hauke@hauke-m.de> (sfid-20160430_230111_592833_C9B9E525)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

shash_desc_zero() and ahash_request_zero() were added in Linux commit
e67ffe0af "crypto: hash - Add helpers to zero stack request/descriptor".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/crypto/hash.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 backport/backport-include/crypto/hash.h

diff --git a/backport/backport-include/crypto/hash.h b/backport/backport-include/crypto/hash.h
new file mode 100644
index 0000000..18cb630
--- /dev/null
+++ b/backport/backport-include/crypto/hash.h
@@ -0,0 +1,24 @@
+#ifndef _BACKPORT_CRYPTO_HASH_H
+#define _BACKPORT_CRYPTO_HASH_H
+#include_next <crypto/hash.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#define shash_desc_zero LINUX_BACKPORT(shash_desc_zero)
+static inline void shash_desc_zero(struct shash_desc *desc)
+{
+	memzero_explicit(desc,
+			 sizeof(*desc) + crypto_shash_descsize(desc->tfm));
+}
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#define ahash_request_zero LINUX_BACKPORT(ahash_request_zero)
+static inline void ahash_request_zero(struct ahash_request *req)
+{
+	memzero_explicit(req, sizeof(*req) +
+			      crypto_ahash_reqsize(crypto_ahash_reqtfm(req)));
+}
+#endif
+
+#endif /* _BACKPORT_CRYPTO_HASH_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
