Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937A1A38FD
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532137; cv=none; b=L/zn3iA8k9fVlRW/Wk2VqqPqU+zKDQTsG52/zgquCfX0WXMHiFarm1HLaGraM7thJ1xeBVqp0xbl0Sy01p9LgIMcvgBorMvu1SiGnPlLFylKLVON96hJEaDJjVEhD1YT41/KIx8pUSTF4Eib4pxGAw5aaWyK0V9dkwz4gF+4s2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532137; c=relaxed/simple;
	bh=JuxhMgNBFNeylPhuP4MI7m9GGyjwqAg6z1azHENTugc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1e5HTRIbUciSMMSP0IEYiTkGlAX+7dUYLS1305J4OUQf61GPfTVROFlnpKAsMZwPhD9zMdP9YcxIwiwB15pe/BL7bt7C5+RpyQ4U7vQRvJUsd2aeHuoMf71pn6uahKk8r0Q4Ghjqi45E6y+jOzQH5gcsGQpD+0Wic9LBbWz9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=cZoL2VXG; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="cZoL2VXG"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdW3w4Rz9srM;
	Fri, 28 Jun 2024 01:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeFDoBNL7BCAgWfogBsUJZN8td5YGU2rIVpwadBtaBY=;
	b=cZoL2VXGQSbbtwGG7J9Dg2sdF/BE1y24Hc7yWMBhgdh/KwLzHnQDF9qrjv3K7rQexxW2jv
	3e3obkQEgAblVwW3FG4o0Npf1lnsSrM0xmsw7PQtjxJm0ZDdzpH40eklf46O0F6jo6iWtc
	uv3cEkXcju+NuAffyuBF00DoKe6ibksPWli8R4mAkCl9YbElaZ/jPIHOhSw3xcS3ofMj7m
	0OV82noVSaYUXYrSNtHuY6io/2K7ziCNnt9xQErfdy/mLS0R5koc+Z7cb85R18qxiVcfHy
	SjmUEv2Wzrs6RWwPnvbvsT915m5LJkJiSiQjPnOjqD1jUimdpF9YQ7RWTlkjrg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 29/75] backports: add mul_u64_u64_div_u64()
Date: Fri, 28 Jun 2024 01:47:15 +0200
Message-ID: <20240627234808.1253337-30-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/math64.h | 11 ++++++
 backport/compat/Makefile                 |  1 +
 backport/compat/backport-5.9.c           | 45 ++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 backport/backport-include/linux/math64.h
 create mode 100644 backport/compat/backport-5.9.c

diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
new file mode 100644
index 00000000..6aea9c9e
--- /dev/null
+++ b/backport/backport-include/linux/math64.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_LINUX_MATH64_H
+#define __BACKPORT_LINUX_MATH64_H
+#include_next <linux/math64.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,9,0)
+#define mul_u64_u64_div_u64 LINUX_BACKPORT(mul_u64_u64_div_u64)
+extern u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c);
+#endif /* < 5.9 */
+
+#endif /* __BACKPORT_LINUX_MATH64_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index c2b89176..698f14f5 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -11,6 +11,7 @@ compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
 compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
 compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
+compat-$(CPTCFG_KERNEL_5_9) += backport-5.9.o
 compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
diff --git a/backport/compat/backport-5.9.c b/backport/compat/backport-5.9.c
new file mode 100644
index 00000000..54d1802e
--- /dev/null
+++ b/backport/compat/backport-5.9.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+
+u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
+{
+	u64 res = 0, div, rem;
+	int shift;
+
+	/* can a * b overflow ? */
+	if (ilog2(a) + ilog2(b) > 62) {
+		/*
+		 * (b * a) / c is equal to
+		 *
+		 *      (b / c) * a +
+		 *      (b % c) * a / c
+		 *
+		 * if nothing overflows. Can the 1st multiplication
+		 * overflow? Yes, but we do not care: this can only
+		 * happen if the end result can't fit in u64 anyway.
+		 *
+		 * So the code below does
+		 *
+		 *      res = (b / c) * a;
+		 *      b = b % c;
+		 */
+		div = div64_u64_rem(b, c, &rem);
+		res = div * a;
+		b = rem;
+
+		shift = ilog2(a) + ilog2(b) - 62;
+		if (shift > 0) {
+			/* drop precision */
+			b >>= shift;
+			c >>= shift;
+			if (!c)
+				return res;
+		}
+	}
+
+	return res + div64_u64(a * b, c);
+}
+EXPORT_SYMBOL_GPL(mul_u64_u64_div_u64);
-- 
2.45.2

