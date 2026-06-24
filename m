Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F02EC0A6
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286821; cv=none; b=QD+AOJbRZgWA6aoo8PbBybeGbolZViHUHCk+7F6u0kgnWJBKlFqUFOxYjSErJNdoQN1kUtgUkdupc5W+MQWZdvxvQtys0kBmPaCp4kxywNabaSQUDS+zQi171+PDeO1ISnc7Syk8FtKG1HnY6SU0QI0TAfHb3G29lBZ64VxXlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286821; c=relaxed/simple;
	bh=oySnMhITliX0/8iq18neU5O4eYmkuM7BhlfUApW4OZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3r9Jc9yu8dfA45oXdkMQLg4GNmhQLNAV2e7o+jeLsx0MlKA8EhsR6LH+mtK0MhH3BwoFgSCqq08aR+6OKBSfyrwVdrtY/uT5fvzpPkABIeSeECUCL6nCkuyXsq5dDBKbE8j0S0y6/lOsEiMPLvU+HP9g+1dVlMEWN49pLwafbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tJibYreD; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tJibYreD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMl8N3vSEs9SM8VJ0brmWZsYXEAA3nVjYeIQh4traMw=;
	b=tJibYreDLD53VKZMxi9fK6NuV11VfnchjNyC3uFRmAw17hUJYcmUBAq8S5O15lIC1Gq5FU
	9LJcTSIj/aNKPal1mzZefZSZx8gjsVTDtb8R/pZQmXwQ8f74dGrvdCoB4gHOR5hgL5Bpjw
	3zO8LEYZNrpzFrxQg8t+hXCUfgKvMbk=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 08/20] headers: add dropreason-core.h backport for kernels < 5.17
Date: Wed, 24 Jun 2026 15:38:32 +0800
Message-ID: <20260624073844.2097504-9-cong.yi@linux.dev>
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

The skb drop reason infrastructure was introduced in v5.17. Provide
minimal enum skb_drop_reason definitions (SKB_NOT_DROPPED_YET,
SKB_CONSUMED) and SKB_DROP_REASON_SUBSYS_SHIFT/MASK constants so that
mac80211 drop.h compiles on older kernels.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 .../backport-include/net/dropreason-core.h    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 backport/backport-include/net/dropreason-core.h

diff --git a/backport/backport-include/net/dropreason-core.h b/backport/backport-include/net/dropreason-core.h
new file mode 100644
index 00000000..2b02a8f1
--- /dev/null
+++ b/backport/backport-include/net/dropreason-core.h
@@ -0,0 +1,34 @@
+#ifndef __BACKPORT_NET_DROPREASON_CORE_H
+#define __BACKPORT_NET_DROPREASON_CORE_H
+#include <linux/version.h>
+
+/*
+ * On kernels >= 5.17, enum skb_drop_reason and the related helpers exist
+ * in the kernel's own skbuff.h / dropreason-core.h.  For older kernels we
+ * provide minimal definitions so that backported wireless drivers compile.
+ */
+#if LINUX_VERSION_IS_LESS(5,17,0)
+
+/**
+ * enum skb_drop_reason - reasons an sk_buff was dropped
+ *
+ * This is a minimal backport that only defines the few values used by
+ * the mac80211 subsystem.  The full upstream enum is much larger.
+ */
+enum skb_drop_reason {
+	SKB_NOT_DROPPED_YET = 0,
+	SKB_CONSUMED,
+	SKB_DROP_REASON_NOT_SPECIFIED,
+};
+
+/*
+ * Subsystem support was added in 6.0.  For kernels between 5.17 and 6.0
+ * the subsys fields do not exist; for kernels < 5.17 we define them here
+ * so that the mac80211 drop.h header compiles.
+ */
+#define SKB_DROP_REASON_SUBSYS_SHIFT		16
+#define SKB_DROP_REASON_SUBSYS_MASK		0xffff0000
+
+#endif /* < 5.17 */
+
+#endif /* __BACKPORT_NET_DROPREASON_CORE_H */
-- 
2.43.0

