Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:51826 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759363AbdKPOi6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 16 Nov 2017 09:38:58 -0500
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Subject: [PATCH 4/4] backports: fix missing linux/verification.h error on < 4.7
Date: Thu, 16 Nov 2017 15:38:55 +0100
Message-Id: <20171116143855.12307-4-nbd@nbd.name> (sfid-20171116_153900_899407_672E3F63)
In-Reply-To: <20171116143855.12307-1-nbd@nbd.name>
References: <20171116143855.12307-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/verification.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/verification.h b/backport/backport-include/linux/verification.h
index 10e1bcfb..5fd0a2d3 100644
--- a/backport/backport-include/linux/verification.h
+++ b/backport/backport-include/linux/verification.h
@@ -1,7 +1,7 @@
 #ifndef __BP_VERIFICATION_H
 #define __BP_VERIFICATION_H
 #include <linux/version.h>
-#ifndef CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
+#if LINUX_VERSION_IS_GEQ(4,7,0) && !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION)
 #include_next <linux/verification.h>
 #else
 #include <linux/key.h>
@@ -24,5 +24,5 @@ extern int verify_pkcs7_signature(const void *data, size_t len,
 						      const void *data, size_t len,
 						      size_t asn1hdrlen),
 				  void *ctx);
-#endif /* LINUX_VERSION_IS_GEQ(4,7,0) */
+#endif /* LINUX_VERSION_IS_GEQ(4,7,0) && !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) */
 #endif /* __BP_VERIFICATION_H */
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
