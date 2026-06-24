Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA532EEE9E
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286814; cv=none; b=QD01p4zpwlLBVcqyVgK+jpgjEYckPDE3XC2f0c8Irm+deXzH5kke9SDrfcB9w0NgAIiufmL4CwuWGDWLhMUSjxL/irepbwCY1QU22Xw+UNozM5x6wI1cIIB3kSI3YOTvW5UYKTzyBTjImt2o7L+ae9NHyKkds1hULq2AfcAs1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286814; c=relaxed/simple;
	bh=tlu1qmBvx/EGDXP2aORPKRXbktmE98NyZ1fVH1Vjqe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhoKvsG0UirGEh3oBttNN5SqeOHxLNhaEqjrpDJNrkFqHU7awmXyKaZTYv27p74ADKy0nARGhScsFRwpZOXBHcRoT93fNPur1anzo3DZSs7tHbKaZVHxAON7EaYpU5fp9A7nOU+BCyzM2qo+Y7VxUDUHJ/CCqPeT0l5moias+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n7sy5gIr; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n7sy5gIr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHVlEqcVj3yr8zPa3otR3N+f2zCANYtHGZOHHS7Fuxw=;
	b=n7sy5gIrFW35nQh/VPqcE98EvLEL3XFjmN4f3laZyj1/xVRcK220tUcFM7jpNXPsLOr2md
	y9SmMvSO8T5dn+V++yF1szhjNxq3svBEqLxfNLnfep9REi1J8Qpu0LqEB7l+ayYSimO8Bc
	WCxc7T1aCxNDrAtG09TbMmNuR9rqmBg=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 03/20] headers: add kstrtox.h backport
Date: Wed, 24 Jun 2026 15:38:27 +0800
Message-ID: <20260624073844.2097504-4-cong.yi@linux.dev>
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

The separate <linux/kstrtox.h> header was introduced in v5.14
(commit 29b25d81ef62).  Before that, kstrto*() declarations live
in <linux/kernel.h>.

Provide a compatibility wrapper that includes <linux/kernel.h> on
kernels older than v5.14.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/kstrtox.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 backport/backport-include/linux/kstrtox.h

diff --git a/backport/backport-include/linux/kstrtox.h b/backport/backport-include/linux/kstrtox.h
new file mode 100644
index 00000000..a17d072b
--- /dev/null
+++ b/backport/backport-include/linux/kstrtox.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_KSTRTOX_H
+#define __BACKPORT_KSTRTOX_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,14,0)
+/*
+ * Before Linux 5.14, kstrto* functions were declared in linux/kernel.h.
+ * The separate linux/kstrtox.h header was introduced in commit
+ * 29b25d81ef62 ("lib/kstrtox: move kstrto*() from lib/cmdline.c to
+ * lib/kstrtox.c, add tests").
+ */
+#include <linux/kernel.h>
+#else
+#include_next <linux/kstrtox.h>
+#endif
+
+#endif /* __BACKPORT_KSTRTOX_H */
-- 
2.43.0

