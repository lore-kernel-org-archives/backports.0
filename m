Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6213E04F
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532131; cv=none; b=UYdOKcl6QLbKLfB+D5onZSxP3xG2VVtwJ/OwEWXicWKRfiGscyTtNaX4guc0jFYvCNA4ONW4FqTc573G+dabioWry7iw7ZPE4UHA3d+AnQNcIgrgMOoLWWlyFxAPDBzXl4wh39JGdwrvO/5Lqm7A4V6oggUR7ACDsA59ApaeQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532131; c=relaxed/simple;
	bh=1C2BuPkQhSDoVmqi4iI6dSOEaUpunCx7XHnmUW0t/08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnCkjCYZPOM+560CxhuS5HJYTx19kHMJvlOI1HEDAix4cceDW2xINyGtDDtYk3d0VOxqp5qh6A+3jgHWaSrjudMR3ZFOxdkZsh3pmZ33N8Mdak8lMkpdWzkmDuILCK33wFCgY9TKIXFNpCK21pwbXgvvxkdw7nmHJtt+l5g5+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=YVxVhiUH; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="YVxVhiUH"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdT4qV8z9spN;
	Fri, 28 Jun 2024 01:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sCD2wgNx0k7IaCfcGLWDdn7rKN6+XRAUpslzwwaiChY=;
	b=YVxVhiUHaU4kFhunXLdOI3BL6OZJani0KJWuwq2fzJg0QV29uYALPkvZkZ1gG7X70qXKSj
	XSyoL+9QeTtYL9nucqo9SlQiWMY1KijFDV0zM/lyyR0ybXlDW1uA7jYo7AnE7gu6JWCOTw
	zqCGPLzYqdtNaGtloPS/Y/8UIKxuO2MPspLp85tohQGpSF8FrnfRDRNcmtTincdcTfsz45
	bkE5C+iPjCkhcbr2gxlnzP/U+/tb+P9V1+3X0LrRRF/Q9A4dfTYfi0hdi8u/6RR/FL1zjn
	usyaADVXwPWZgdJf7NK1hmCZ+4dfEciwJ2YUNvYYysDUvYHTIizu3Zxwb9IzIA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 21/75] backports: add module namespace support
Date: Fri, 28 Jun 2024 01:47:07 +0200
Message-ID: <20240627234808.1253337-22-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdT4qV8z9spN

From: Johannes Berg <johannes.berg@intel.com>

Add EXPORT_SYMBOL_NS_GPL() and MODULE_IMPORT_NS(),
for kernels that don't yet know about it. Just do
nothing about namespaces in that case, of course.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/export.h | 12 ++++++++++++
 backport/backport-include/linux/module.h |  4 ++++
 2 files changed, 16 insertions(+)
 create mode 100644 backport/backport-include/linux/export.h

diff --git a/backport/backport-include/linux/export.h b/backport/backport-include/linux/export.h
new file mode 100644
index 00000000..c24c9f99
--- /dev/null
+++ b/backport/backport-include/linux/export.h
@@ -0,0 +1,12 @@
+#ifndef _COMPAT_LINUX_EXPORT_H
+#define _COMPAT_LINUX_EXPORT_H 1
+
+#include <linux/version.h>
+
+#include_next <linux/export.h>
+
+#ifndef EXPORT_SYMBOL_NS_GPL
+#define EXPORT_SYMBOL_NS_GPL(sym, ns) EXPORT_SYMBOL_GPL(sym)
+#endif
+
+#endif /* _COMPAT_LINUX_EXPORT_H */
diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index efe970f1..b93a56d9 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -67,4 +67,8 @@ extern void backport_dependency_symbol(void);
 	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,4,0)
+#define MODULE_IMPORT_NS(ns)
+#endif
+
 #endif /* __BACKPORT_LINUX_MODULE_H */
-- 
2.45.2

