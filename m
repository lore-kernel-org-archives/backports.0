Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771201A38F5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532141; cv=none; b=PP9HXDWImbvy5wtUNQ43Hi++MsddkWpUcom+60isTGYKXHv+K0e56FN9nZuF10M0O3StO0ZIfSeVzKSHMAEg+lNIC8tTr/UXwMpn8aigUeZKZCzav5kXwQ2l+Ky75w6lezTJO/ei5yEqgkayA1VTCr9Q0KfjtDMENWsiOjd1RI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532141; c=relaxed/simple;
	bh=U3BKB/gZHypdbexzXdu16bhfBu0jxH37Nun6u0MUdPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxX1GgYNRRA1mHszt18YjbXj+K/f0WfsRJ/sa3SpS2dl54eJsT2ZqmBjAtq0LiJPqdGqoPoEBTL4B2aZMBTzeMVSoxWfg0uXIXyAVW9x5xVJ8JLzpFK8RZtB5RooAHRkb3Ay0kpd+MlqrmcXzqCNvpyY0DEs+BCilHtU62fYvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=SMVyRLkj; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="SMVyRLkj"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9Fdh2t6vz9spB;
	Fri, 28 Jun 2024 01:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3l+F6MQal6eTwMKLor/Y0QZUNjK++qvqEqZQNMsunX4=;
	b=SMVyRLkj0+hs4hWT+FOpZMZ6pnfs0n3kOJ9UNUtK0NGB/++fX/cFBn68HUmUOSgk6fkvhR
	8OITRiaIDmqhHK8veU15fdpML7MHVGjb67ZCBpSmNx5awf3T/H1OhaASTlxl2mAXaEPqxP
	HYVyA92WIaI14dSBFtypW+R62HPqAxbbFOCa0mlcdr4MEEX6M9i2g6hLrbECyOYSPW+GVL
	Aq2vZ9fYQWs7QKppBgCXz39o9tON/V9sI2t61LVBBNfOvPc2WnPxKS+hBrMadBC097PqFQ
	IthYwcQl6xI2AZRGiQ3dlJhtblliLCEAlAHgb1zupdlZ5wsuo/27CUiw7sK0AA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 63/75] header: Add pm_runtime_resume_and_get
Date: Fri, 28 Jun 2024 01:47:49 +0200
Message-ID: <20240627234808.1253337-64-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used by the wlcore and wil6210 driver.

Code was copied from upstream Linux kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pm_runtime.h | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 backport/backport-include/linux/pm_runtime.h

diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
new file mode 100644
index 00000000..5b4b75e1
--- /dev/null
+++ b/backport/backport-include/linux/pm_runtime.h
@@ -0,0 +1,31 @@
+#ifndef __BACKPORT_PM_RUNTIME_H
+#define __BACKPORT_PM_RUNTIME_H
+#include_next <linux/pm_runtime.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,10,0)
+#define pm_runtime_resume_and_get LINUX_BACKPORT(pm_runtime_resume_and_get)
+
+/**
+ * pm_runtime_resume_and_get - Bump up usage counter of a device and resume it.
+ * @dev: Target device.
+ *
+ * Resume @dev synchronously and if that is successful, increment its runtime
+ * PM usage counter. Return 0 if the runtime PM usage counter of @dev has been
+ * incremented or a negative error code otherwise.
+ */
+static inline int pm_runtime_resume_and_get(struct device *dev)
+{
+	int ret;
+
+	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	return 0;
+}
+#endif /* < 5.10 */
+
+#endif /* __BACKPORT_PM_RUNTIME_H */
\ No newline at end of file
-- 
2.45.2

