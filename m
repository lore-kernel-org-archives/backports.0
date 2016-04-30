Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49598 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbcD3VBF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:05 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/16] header: add AHASH_REQUEST_ON_STACK()
Date: Sat, 30 Apr 2016 23:00:38 +0200
Message-Id: <1462050048-8953-7-git-send-email-hauke@hauke-m.de> (sfid-20160430_230111_036593_19D6AFB2)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

AHASH_REQUEST_ON_STACK() was added in Linux commit d4421c54c "crypto:
hash - Add AHASH_REQUEST_ON_STACK".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/crypto/hash.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/crypto/hash.h b/backport/backport-include/crypto/hash.h
index 18cb630..3510659 100644
--- a/backport/backport-include/crypto/hash.h
+++ b/backport/backport-include/crypto/hash.h
@@ -21,4 +21,11 @@ static inline void ahash_request_zero(struct ahash_request *req)
 }
 #endif
 
+#ifndef AHASH_REQUEST_ON_STACK
+#define AHASH_REQUEST_ON_STACK(name, ahash) \
+	char __##name##_desc[sizeof(struct ahash_request) + \
+		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
+	struct ahash_request *name = (void *)__##name##_desc
+#endif
+
 #endif /* _BACKPORT_CRYPTO_HASH_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
