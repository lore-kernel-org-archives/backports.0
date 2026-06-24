Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534F33F361
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286822; cv=none; b=EvP0yzHfdg9KiE5bCdsoSzUa7b+UCPpt9uBiiZrJfulJtajuuMADFa5TzkOadw2MmAwsUZndfhexCmT/FmTAbzc0pF3uc7aFf5rpPdhSbzFHUuaGBT2fm25H0z3lYHLAvlYuiBD+WRYkH1viS/G3c2ys4Ov03Km9My/NZcP/Q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286822; c=relaxed/simple;
	bh=s9bX25QdW0jVTm8LtFJjTwnxBgWnwQJplvUdSXGERm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpUJ21axqYeeAL96turZ7vNmyAEisgyDsVRayqGPC8yEI0j2x3MY7iZONGv8So1M9dlJmfMcgc28BFnag6J8Gp3qz4WIPWTiG2Lw5qzqwKZVoqaK7ouo2PkK7jLWSTms/wU3CaL3o5IfJUKyii8Xwg3MxCSnCUQ8k0CVZ0WV8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eQJX/wHy; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eQJX/wHy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9y2ger922VeEsRPQNvIWNULdttTLZXlUaf+LqPzTnM=;
	b=eQJX/wHy97h7YEyI0PVCiyP3TW9s/ZwivhnDVXMz77REhtFqYTnfELRkNhT9LJexqMoPIA
	jzF9Z9a1WE70itnWUxTnYnBH1mEZy24CcJsP7oW7u7Hy4SW5HEyEfYj4xCDYPUuY6BxFfs
	y47zRjqf3bCFjldRf4lM/14PFGwNaYs=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 09/20] headers: add dropreason.h backport for kernels < 6.0
Date: Wed, 24 Jun 2026 15:38:33 +0800
Message-ID: <20260624073844.2097504-10-cong.yi@linux.dev>
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

The subsystem-based drop reason infrastructure was introduced in v6.0
and extended in v6.4. Provide enum skb_drop_reason_subsys, struct
drop_reason_list, and no-op stubs for drop_reasons_register_subsys()
and drop_reasons_unregister_subsys() so that mac80211 compiles on
older kernels.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/net/dropreason.h | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 backport/backport-include/net/dropreason.h

diff --git a/backport/backport-include/net/dropreason.h b/backport/backport-include/net/dropreason.h
new file mode 100644
index 00000000..55b11c13
--- /dev/null
+++ b/backport/backport-include/net/dropreason.h
@@ -0,0 +1,43 @@
+#ifndef __BACKPORT_NET_DROPREASON_H
+#define __BACKPORT_NET_DROPREASON_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(6,0,0)
+/* On new kernels, the real header is already available. */
+#include_next <net/dropreason.h>
+#else
+
+#include <net/dropreason-core.h>
+
+/*
+ * Minimal backport of the subsystem-based drop reason infrastructure
+ * that was introduced in kernel 6.0 and extended in 6.4.
+ */
+
+enum skb_drop_reason_subsys {
+	SKB_DROP_REASON_SUBSYS_CORE,
+	SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE,
+	SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR,
+	SKB_DROP_REASON_SUBSYS_NUM
+};
+
+struct drop_reason_list {
+	const char * const *reasons;
+	size_t n_reasons;
+};
+
+/* No-op stubs for registration */
+static inline void
+drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
+			     const struct drop_reason_list *list)
+{
+}
+
+static inline void
+drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys)
+{
+}
+
+#endif /* < 6.0 */
+
+#endif /* __BACKPORT_NET_DROPREASON_H */
-- 
2.43.0

