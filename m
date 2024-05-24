Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307FE12E1EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570571; cv=none; b=txiOKtQ3sauNEiOeyifyl+aZbu+5ji0uanZdRjwTJqvjYFToEIgOrTcaOFU4SEsswvik27FCt8dp+h1YnZe3H9NfwXCBvgDOU04O7S2dLPDfp9/PgS433BxGcIP4sWmzC1HEKCSX5EY0LR7PVJue+9P+Y9fVfzlneRDg5Gb4dFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570571; c=relaxed/simple;
	bh=SAj6BGk58VP2OqfKO23fgUTYxxT6tuMCSSe+JLl6tLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh7Hw9HRzccPj7a0qZGZTPSo7+XqUnlTPt/8NUPBTNYNKTU5lJgot/KR1o4fPWlvQRs7L2j/6OPIu2Cx1eVJ5aqOQGIpEArofjL3H5dLQcpmEOUcv/cV+rKbX26LrR2wSv/J6b+AhxCzcSL7oC90L8jZL4FVGqkeunCOY0Jd02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hIwLm/Ii; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hIwLm/Ii"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hwhd8LXdiSNUR1McV6+ah6/r078QPgxSA9uxL3B91OA=;
	t=1716570570; x=1717780170; b=hIwLm/IiPie37ovfjdaqlJoeDI7RwErQewQ66/Hu+sJS+6t
	KUgGeJrszmi21TLYbj+K7S/Kaw5Fxso697Ebs+k2HZR5nhA0XgNhPA7N3uG3VV4bhPZlD7VGS6F9y
	gIZtvr2bBqvuEe0csTwaUtybLHX8vjc4BLcImrPXnYmJ6knO3ChIOprGV8NZU7suY7iPA28GgkW5Z
	rCjQPN5I+ovdDxhh+AXiGW/GRo+ltXvJ4tCxXEpHd3K72C3D01c7gvMbwWO/U+zJXfJWtR6NxMUZ3
	cvQCS+Y4JrjfugkQ4YwHMA2o8ZwZjjj4abd68AI0jv/VeaEwk3Ig/z0740xWClkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ3-00000008Xuw-3avd;
	Fri, 24 May 2024 19:09:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 20/74] backports: add mul_u64_u64_div_u64()
Date: Fri, 24 May 2024 19:07:32 +0200
Message-ID: <20240524190907.fcf4bcdc51ee.Ia106b487910574e59b56065f04f9448655011b0a@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
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
index 000000000000..6aea9c9eec77
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
index 1d47bd59fe90..3c8430bc4958 100644
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
index 000000000000..54d1802efd31
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
2.45.1

