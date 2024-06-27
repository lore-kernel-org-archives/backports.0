Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04571A3BB2
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532139; cv=none; b=l5e7mIfxwUZRxdpEnI1k8okuV1FF3sGW1/KGFg14etF3nd+yAZ1lcKwtEmj1izuw93HADpbRFX+RNibmDjWnCf0LX7TjjhlhQwxe323fHySB6QG14LfSveBfwu0/qvCYFsRKXzfifiu4Z41IuljjgIk2CThF/fITFtTt6zIlyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532139; c=relaxed/simple;
	bh=yTRi+1lxyevOdqWPZXSRyCRNVqokjKZhA/3IIPXqbgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt1rLQXasxjM2Yw11a1OitZik1VC9JwPUYwUhMDFRmtpLT2ii2xnzFkbgWRL/Zd8Ao3z6qTHKefByhOx3+kkP9h0gTzJWuB+4QUPAxujUwU863ksGnJL3xcfklrAwhdMxTmZPXPuF8k52BK2Xm0LGGhYo8gca55+4WDmQvNAi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=n3oCNdGt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="n3oCNdGt"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdf55GVz9svK;
	Fri, 28 Jun 2024 01:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QM0wFCxkAoizIcfJjy+sRlY4pTvY00J3VMzsaWaVtik=;
	b=n3oCNdGtAv7KYt1cu1CHqfT2xyWmrZutgb3bu8SmT4TRURVg1DgvfpxomO5OHj3w7AyQ9b
	Vd0gqwIWc+I4Mf5nS1OwoGc8zkWTlVyNGrCEFZlptTsEP7K919APuuOhGuxgQeINKyeCdq
	+m2IbRwkRxg2DP7lpXBPZVOp58wREzChFyXNfcJgAD227gvpHNIeuiFb0/LpmjJXuNhKK7
	rrs+8GM8yTe+FywomrWkCYMWx+O3STQyP+3xW596QfZiI6T8+7mktHFVdWAhfYQLQ15I71
	BVaJQWyn5HseGQ9K2lZU3RFn/zXiv9UvkFcqfHkAKl37oPiXGnVgwGvpMNYWJg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 56/75] backports: Add devm_bitmap_zalloc()
Date: Fri, 28 Jun 2024 01:47:42 +0200
Message-ID: <20240627234808.1253337-57-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdf55GVz9svK

The carl9170 driver is using devm_bitmap_zalloc() now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/bitmap.h | 17 ++++++++++++
 backport/compat/backport-5.13.c          | 34 ++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 backport/backport-include/linux/bitmap.h

diff --git a/backport/backport-include/linux/bitmap.h b/backport/backport-include/linux/bitmap.h
new file mode 100644
index 00000000..a09c5a68
--- /dev/null
+++ b/backport/backport-include/linux/bitmap.h
@@ -0,0 +1,17 @@
+#ifndef __BP_LINUX_BITMAP_H
+#define __BP_LINUX_BITMAP_H
+#include_next <linux/bitmap.h>
+
+#if LINUX_VERSION_IS_LESS(5,13,0)
+/* Managed variants of the above. */
+#define devm_bitmap_alloc LINUX_BACKPORT(devm_bitmap_alloc)
+unsigned long *devm_bitmap_alloc(struct device *dev,
+				 unsigned int nbits, gfp_t flags);
+
+#define devm_bitmap_zalloc LINUX_BACKPORT(devm_bitmap_zalloc)
+unsigned long *devm_bitmap_zalloc(struct device *dev,
+				  unsigned int nbits, gfp_t flags);
+
+#endif
+
+#endif /* __BP_LINUX_BITMAP_H */
diff --git a/backport/compat/backport-5.13.c b/backport/compat/backport-5.13.c
index c10b3321..8ec5865d 100644
--- a/backport/compat/backport-5.13.c
+++ b/backport/compat/backport-5.13.c
@@ -2,6 +2,8 @@
 
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/bitmap.h>
+#include <linux/device.h>
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /*
@@ -28,3 +30,35 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL_GPL(tasklet_unlock_spin_wait);
 #endif
+
+static void devm_bitmap_free(void *data)
+{
+	unsigned long *bitmap = data;
+
+	bitmap_free(bitmap);
+}
+
+unsigned long *devm_bitmap_alloc(struct device *dev,
+				 unsigned int nbits, gfp_t flags)
+{
+	unsigned long *bitmap;
+	int ret;
+
+	bitmap = bitmap_alloc(nbits, flags);
+	if (!bitmap)
+		return NULL;
+
+	ret = devm_add_action_or_reset(dev, devm_bitmap_free, bitmap);
+	if (ret)
+		return NULL;
+
+	return bitmap;
+}
+EXPORT_SYMBOL_GPL(devm_bitmap_alloc);
+
+unsigned long *devm_bitmap_zalloc(struct device *dev,
+				  unsigned int nbits, gfp_t flags)
+{
+	return devm_bitmap_alloc(dev, nbits, flags | __GFP_ZERO);
+}
+EXPORT_SYMBOL_GPL(devm_bitmap_zalloc);
-- 
2.45.2

