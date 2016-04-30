Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49601 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbcD3VBG (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:06 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/16] header: add SHASH_DESC_ON_STACK()
Date: Sat, 30 Apr 2016 23:00:40 +0200
Message-Id: <1462050048-8953-9-git-send-email-hauke@hauke-m.de> (sfid-20160430_230112_210288_4A8B22B7)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

SHASH_DESC_ON_STACK was added in Linux commit a0a77af14 "crypto:
LLVMLinux: Add macro to remove use of VLAIS in crypto code".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/crypto/hash.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/crypto/hash.h b/backport/backport-include/crypto/hash.h
index 3510659..9c26e0c 100644
--- a/backport/backport-include/crypto/hash.h
+++ b/backport/backport-include/crypto/hash.h
@@ -28,4 +28,11 @@ static inline void ahash_request_zero(struct ahash_request *req)
 	struct ahash_request *name = (void *)__##name##_desc
 #endif
 
+#ifndef SHASH_DESC_ON_STACK
+#define SHASH_DESC_ON_STACK(shash, ctx)				  \
+	char __##shash##_desc[sizeof(struct shash_desc) +	  \
+		crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
+	struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
+#endif
+
 #endif /* _BACKPORT_CRYPTO_HASH_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
