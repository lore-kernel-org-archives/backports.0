Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41035 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbbFNO3h (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/21] backports: add backport for new AEAD crypto API
Date: Sun, 14 Jun 2015 16:29:08 +0200
Message-Id: <1434292162-2261-8-git-send-email-hauke@hauke-m.de> (sfid-20150614_162945_019275_3F6B4430)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

mac80211 makes use of the new AEAD crypto api since commit 957e0fe629.
This patch provides a backport layer which converts the new API to the
old one used in older kernel versions. This backport is based on this
mainline commit: 996d98d85.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/crypto/aead.h | 33 ++++++++++++++++
 backport/compat/Makefile                |  1 +
 backport/compat/backport-4.2.c          | 67 +++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 backport/backport-include/crypto/aead.h
 create mode 100644 backport/compat/backport-4.2.c

diff --git a/backport/backport-include/crypto/aead.h b/backport/backport-include/crypto/aead.h
new file mode 100644
index 0000000..97d5ce6
--- /dev/null
+++ b/backport/backport-include/crypto/aead.h
@@ -0,0 +1,33 @@
+#ifndef __BACKPORT_CRYPTO_AEAD_H
+#define __BACKPORT_CRYPTO_AEAD_H
+#include_next <crypto/aead.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#define aead_request_set_ad LINUX_BACKPORT(aead_request_set_ad)
+static inline void aead_request_set_ad(struct aead_request *req,
+				       unsigned int assoclen)
+{
+	req->assoclen = assoclen;
+}
+
+#define crypto_aead_reqsize LINUX_BACKPORT(crypto_aead_reqsize)
+unsigned int crypto_aead_reqsize(struct crypto_aead *tfm);
+
+struct aead_request *crypto_backport_convert(struct aead_request *req);
+
+static inline int backport_crypto_aead_encrypt(struct aead_request *req)
+{
+	return crypto_aead_encrypt(crypto_backport_convert(req));
+}
+#define crypto_aead_encrypt LINUX_BACKPORT(crypto_aead_encrypt)
+
+static inline int backport_crypto_aead_decrypt(struct aead_request *req)
+{
+	return crypto_aead_decrypt(crypto_backport_convert(req));
+}
+#define crypto_aead_decrypt LINUX_BACKPORT(crypto_aead_decrypt)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0) */
+
+#endif /* __BACKPORT_CRYPTO_AEAD_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index f60c32b..d0acf17 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -26,6 +26,7 @@ compat-$(CPTCFG_KERNEL_3_17) += backport-3.17.o
 compat-$(CPTCFG_KERNEL_3_18) += backport-3.18.o
 compat-$(CPTCFG_KERNEL_3_19) += backport-3.19.o
 compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
+compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/backport-4.2.c b/backport/compat/backport-4.2.c
new file mode 100644
index 0000000..e00aa49
--- /dev/null
+++ b/backport/compat/backport-4.2.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Backport functionality introduced in Linux 4.2.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <crypto/scatterwalk.h>
+#include <crypto/aead.h>
+
+static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
+					    struct scatterlist *src,
+					    unsigned int len)
+{
+	for (;;) {
+		if (!len)
+			return src;
+
+		if (src->length > len)
+			break;
+
+		len -= src->length;
+		src = sg_next(src);
+	}
+
+	sg_init_table(dst, 2);
+	sg_set_page(dst, sg_page(src), src->length - len, src->offset + len);
+	scatterwalk_crypto_chain(dst, sg_next(src), 0, 2);
+
+	return dst;
+}
+
+struct aead_old_request {
+	struct scatterlist srcbuf[2];
+	struct scatterlist dstbuf[2];
+	struct aead_request subreq;
+};
+
+unsigned int crypto_aead_reqsize(struct crypto_aead *tfm)
+{
+	return crypto_aead_crt(tfm)->reqsize + sizeof(struct aead_old_request);
+}
+EXPORT_SYMBOL_GPL(crypto_aead_reqsize);
+
+struct aead_request *crypto_backport_convert(struct aead_request *req)
+{
+	struct aead_old_request *nreq = aead_request_ctx(req);
+	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct scatterlist *src, *dst;
+
+	src = scatterwalk_ffwd(nreq->srcbuf, req->src, req->assoclen);
+	dst = req->src == req->dst ?
+	      src : scatterwalk_ffwd(nreq->dstbuf, req->dst, req->assoclen);
+
+	aead_request_set_tfm(&nreq->subreq, aead);
+	aead_request_set_callback(&nreq->subreq, aead_request_flags(req),
+				  req->base.complete, req->base.data);
+	aead_request_set_crypt(&nreq->subreq, src, dst, req->cryptlen,
+			       req->iv);
+	aead_request_set_assoc(&nreq->subreq, req->src, req->assoclen);
+
+	return &nreq->subreq;
+}
+EXPORT_SYMBOL_GPL(crypto_backport_convert);
-- 
2.1.4

