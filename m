Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275C360EC0
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286835; cv=none; b=G8D7eZakUF1mSUld3Bn9kvqSHqGyEnFVN6m63vSOoLge7GSiDz8zELdhWLwJ6mDiYjRO6e7ye/oWYfcCFcXwvDxTx5sS/5i2Z0xC02DeMp5UN2EOQq3CX8XfXhIYWkWFxKu842snL1DzkAJpnwpnnK8vKwz0M8XdP1nyJfB35Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286835; c=relaxed/simple;
	bh=AKdoe+EkfUlzVjrpCduo5jup8L+NqAUIINVKxdQMcMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNM/xs5EVxG8fJ5IpJUMVtyIVHA5l+JhxTw9KJDyXdc/SNMBXokyY24QygftluabjNXMvzTXT/j7CDYY9KPxhCwi/Dzkgeb2lq5ynqDQthZxpA03rqTR270A06i70pUSFWjxG0NOw+JzIV5OAYOF+/fee0erXvtQKLnrULuOJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NHBoOylh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NHBoOylh"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icMYzttxes6hInF4q4rVpx7qnxNePy+xoQzcK+lL5ZE=;
	b=NHBoOylhkGxFGxaQpKEqi6yt88qr4xmEwYq6n3E1ylYdFvU+tjESx/6WyvAF1F8SxQubaq
	4yHrvJKxHIcQtkfG7mX1tIFrA57FLXtUfH2bgwulN/GxSqVG3atNC9npauaXcHzu0WbsnG
	vdiXOrjn0I3+yIUSYyUP0tY0IFoou58=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 16/20] headers: add vcalloc() backport for kernels < 5.18
Date: Wed, 24 Jun 2026 15:38:40 +0800
Message-ID: <20260624073844.2097504-17-cong.yi@linux.dev>
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

vcalloc() was introduced in v5.18 to allocate and zero virtually
contiguous memory with overflow-checked multiplication. Provide a
wrapper using vzalloc() for older kernels.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/vmalloc.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 backport/backport-include/linux/vmalloc.h

diff --git a/backport/backport-include/linux/vmalloc.h b/backport/backport-include/linux/vmalloc.h
new file mode 100644
index 00000000..233c8608
--- /dev/null
+++ b/backport/backport-include/linux/vmalloc.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_LINUX_VMALLOC_H
+#define __BACKPORT_LINUX_VMALLOC_H
+#include_next <linux/vmalloc.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,18,0)
+/**
+ * vcalloc - allocate virtually contiguous memory and zero it
+ * @n:		number of elements
+ * @size:	size of each element
+ *
+ * Introduced in v5.18. On older kernels, fall back to vzalloc()
+ * with overflow-checked multiplication.
+ */
+static inline void *vcalloc(size_t n, size_t size)
+{
+	size_t bytes;
+	if (size && n > SIZE_MAX / size)
+		return NULL;
+	bytes = n * size;
+	return vzalloc(bytes);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_VMALLOC_H */
-- 
2.43.0

