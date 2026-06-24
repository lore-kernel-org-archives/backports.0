Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE121EFF8D
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286833; cv=none; b=e5LJG13Lj2aWnBxsh1KDqaGLPNqfVXEkWFCIIxUjUuOq3NkechAiyavhkEsRKv5A5xywJ37ZfnIR6ZJAGC8YjYZwjT+G5yXFtT0Ibq0fctwQqB6ReB+v3CGuvIHvyAEKswxI9EqXy6Z8QGUCcLUq5SOYSScHbgVvdIGUtZgKeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286833; c=relaxed/simple;
	bh=Gs/Ud5TLbzn171KEabP87kt5eHlQlIm0dw4zNsDlQRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdGDS5aHpjn2pNqpWJqjNtUNMaDGBJkmbNHyleHJXHKuVAtM1M8yy0k59DP7En2TQaW5G1p1g0vjsQPkDwtFUhd59MAZH84MJUb2uEPbja1TNlnyPtfoMdEwgMu2cNG23BXcpeyK0f/lUQ4hLfSvkEVEUPcOR6T4j2zoTcNXM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E9nZueFi; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E9nZueFi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IshXMl2+i9VDQ85oLpVf9bghLYf+qu83TXn2tn+ktpI=;
	b=E9nZueFiMtUqkJ3LVfNfZASjT6MaxEVwV2dr2rzFAjlLsyOUjZmzDCNY1/cVAGrdnBmIod
	OjjYOnVPbe+QiVvi4zQ+t+EPc2xc56bpfSLpblRHeqVDXWus6Y2hSp/P0dcn4gIEPE/X71
	BGKAe3lP7z0hZuDqpCSPxR/T+KzWgbQ=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 15/20] headers: add net/gso.h backport for kernels < 6.5
Date: Wed, 24 Jun 2026 15:38:39 +0800
Message-ID: <20260624073844.2097504-16-cong.yi@linux.dev>
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

In v6.5 GSO helpers (skb_gso_segment, etc.) were extracted from
linux/netdevice.h into a new net/gso.h header. For older kernels,
this backport simply includes the existing headers where these
functions are already defined.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/net/gso.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/net/gso.h

diff --git a/backport/backport-include/net/gso.h b/backport/backport-include/net/gso.h
new file mode 100644
index 00000000..ccc1e3d4
--- /dev/null
+++ b/backport/backport-include/net/gso.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_NET_GSO_H
+#define __BACKPORT_NET_GSO_H
+#include <linux/version.h>
+
+/*
+ * net/gso.h was introduced in v6.5 by extracting GSO helpers from
+ * linux/netdevice.h and linux/skbuff.h.  On older kernels these
+ * functions are already available through the existing headers, so
+ * this backport simply pulls in the relevant includes.
+ */
+#if LINUX_VERSION_IS_LESS(6,5,0)
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#endif
+
+#endif /* __BACKPORT_NET_GSO_H */
-- 
2.43.0

