Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF73B28F
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572915; cv=none; b=UT/S/R7WBTQUCfEoECPC8vQptRyZvkuS48J4sdiaoTlCvy2g2XuWJpi65etJsCquUBbd5p32pt0g6MiAEYcwyP+tv9tfeZadGgqmBVlmPUbPVsvlkZm0hx4v08fcempvriEe5932mET4txotVRCK+UnWJzl5HVNcV6qsT3FTEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572915; c=relaxed/simple;
	bh=rSO04xPxtkcKp4Y9ZOUU4PI1k1z4xjQb5dpT0QZt2Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5SUR9Ykj1UUmpVjA0Vr0c1hQDXLlmy03rn5W9HEE9uMGT6WtZjYX57le02+T4ZVLv20lJq/soqsSpQRB1AtQsYvWz3euF5LL9Xmqg8j7nUikcHeF00YomQmuhQXTwWkFl51SJ7yhfYW6Q9UB/s2mkY1EerXf9WAyOp1ElLM1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KNHr+nJ1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KNHr+nJ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=W8aPtXg/5Zdy2K03f98nZs2rFgEtQVgFfavMKkJRaN4=; t=1716572914; x=1717782514; 
	b=KNHr+nJ1K7wpLypvRAIHGubU5eWTmWjMtjNC2ow8/t2DfI6V1shilaSJ7mE1M7JR2gex05GTzl7
	qI9NQR0mxIr3YBO08J71J4g1TJo5zDhn1d4g+ybZ5riah8f6+JzM3L/F2t0cPj2EfkzijqeU411Vl
	LJbIOTdsX74hkr033JYBDmFUE7oMEjS/X9EFa7qsl0nBtWD+wR+rjxB2yetnA5OW07WR+yuvoQXGe
	ulO7EUtaFhiXgWbV5YkWJdkgywN3raF0l9sDN9P9a8p99f3riZQd+8o17xGlECLqgl+7mE/g+Noep
	YnX2NIkOmssgg8GQidlUPHZuUCnH8+FqIOqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAZ1r-00000008alk-2IzQ;
	Fri, 24 May 2024 19:48:31 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] backports: add list_count_nodes()
Date: Fri, 24 May 2024 19:48:16 +0200
Message-ID: <20240524194829.f11312298857.I2921f495b9feefbfe464ffd71c7350c66be119a8@changeid>
X-Mailer: git-send-email 2.45.1
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
 backport/backport-include/linux/list.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 backport/backport-include/linux/list.h

diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
new file mode 100644
index 000000000000..8495fd419a95
--- /dev/null
+++ b/backport/backport-include/linux/list.h
@@ -0,0 +1,19 @@
+#ifndef __BP_LINUX_LIST_H
+#define __BP_LINUX_LIST_H
+#include_next <linux/list.h>
+
+#if LINUX_VERSION_IS_LESS(6,3,0)
+#define list_count_nodes LINUX_BACKPORT(list_count_nodes)
+static inline size_t list_count_nodes(struct list_head *head)
+{
+	struct list_head *pos;
+	size_t count = 0;
+
+	list_for_each(pos, head)
+		count++;
+
+	return count;
+}
+#endif
+
+#endif /* __BP_LINUX_LIST_H */
-- 
2.45.1

