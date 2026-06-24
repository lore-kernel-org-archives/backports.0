Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E372ED870
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286824; cv=none; b=FqdsEsCzMaJrMJOYh925aWI4vi6JA7I4AlaZo72H1x+0wUE6P/j8DeBZpETWWTpDbfsyAX7KkBHf++SnSKEyWBgtju1/ghg+iwLoC6PVLHGRzTbH8N87Q/vzToujr90yjJk3teEpiXMKynY4rV8tKHLsan/gMkRKAmBqts5TJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286824; c=relaxed/simple;
	bh=7McKa8cV2q8r9bYpmj7R0uV5F2ptXz+NkI2ODx+SCHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plvTaNOCVMLl9ux05oyeuWnLJ+VxVIP6mYDRD28h9G1LtjqtO7j8HSirTC3NHyL1ndAiuHfKJQO9kRA70Mu30uP3GApzwsNKR5chdfhMmW8z9+5DMd+Ke0UlHXE4eBBpJIVgrcdHhIZM+1bMQL+idxGoZwHVEe/yPRDpOIbRTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f2XXRtkT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f2XXRtkT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60fHVIKAe8/T/cyJoRJe/UyJtj+n5f833De6Nttn4rQ=;
	b=f2XXRtkTksrriAOSpfvqIPA21yxKTstDftPLC5C4C+KTrJXaXg9E1dZgxZupU8OqmxtiLo
	xTqORNSsbwsTs6qvYsAqA06BTYgZewp2m5egk88R2tRjKLy9DY1fctoQr2JKn+2BI6TaQD
	vIW9nz16u0HasWzgcbXbUEYm1tAnJjo=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 10/20] headers: add kfree_skb_reason() backport for kernels < 5.17
Date: Wed, 24 Jun 2026 15:38:34 +0800
Message-ID: <20260624073844.2097504-11-cong.yi@linux.dev>
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

kfree_skb_reason() was introduced in v5.17 along with enum
skb_drop_reason. Provide an inline wrapper that discards the reason
and calls kfree_skb() on older kernels.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/skbuff.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 36b83fdf..8193448d 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -103,4 +103,21 @@ static inline bool skb_queue_empty_lockless(const struct sk_buff_head *list)
 }
 #endif /* < 5.4 */
 
+#if LINUX_VERSION_IS_LESS(5,17,0)
+/*
+ * kfree_skb_reason() was introduced in kernel 5.17 along with
+ * enum skb_drop_reason. For older kernels provide a simple wrapper
+ * that discards the reason and calls kfree_skb().
+ *
+ * The enum is provided in our backport dropreason-core.h header.
+ */
+#include <net/dropreason-core.h>
+
+static inline void kfree_skb_reason(struct sk_buff *skb,
+				    enum skb_drop_reason reason)
+{
+	kfree_skb(skb);
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.43.0

