Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3813F42F
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532134; cv=none; b=Zb0cLBcLlk8wtny1vz20rbCsd3pxx12rbmjxSw0AA1uPX/Y8fOkpIZefkmXE8Bxv5LmI4ciicTya/JWX+Mbfit//iemTWnsSPfbZG5soY4AuvVfPnvUV42pqfR1LTRrzKGpej/uVNk6zoOysVA0Xp3g8kmeWB7rsIu+q7wSurFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532134; c=relaxed/simple;
	bh=xtmFC9h6Hyo3IreyrwipoZOAPevSil4wpzRAYdSD6wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BG+S93dsRHWSJsuJKhWGQ2ofLGOyL/toPCIylJK3rvdvnzBJAFxKq+fTES1+sQjyNAAz2QK3I7cUTAz5PeoqrwxFreChlCNY9yWFGiNXaZCR0p2WR5+Aq8qEyiMscTlsqZurCxZMmUPqrvFdS4Wkd9odiDlfjXgvUdVX8S+gtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=xZTo1MU2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="xZTo1MU2"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9FdR18XJz9sSm;
	Fri, 28 Jun 2024 01:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9KL40TKSVHnSN/rjzCSGaU4W6ZkK3MNGmHaGTmP54A=;
	b=xZTo1MU2aLGPQWdVcSRjlRi1LGFvwlYZgyh5Y8M6RniqpqK763ox6RCNG/iNpQ0BEU55Vq
	UgFtnWuFJWuRfZ8HN3deIViRYVJm82Nae8g5AIUiOkrkPNy2bUGF6gt6bNUj4P4sUoX/WE
	t1bj3EEyqUD0FVlhs92YP4Rg8k6oMhgPshD4u86Pdf2XQ4sKieNTRvCpHjUOLqX01qfIIz
	48oG11o45GxaqPzgOTNuTXEpP+KUh+Mw9qbefKQ2ndl0Fr9UgAbBYz15r2oKmZotR5V3xX
	DNc62YyV1/tB5m7DZFz3RY0ytu23GmOsiqtr7LAgWhOgoQolWgRmDsSmr3C33Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 12/75] backports: add kthread.h
Date: Fri, 28 Jun 2024 01:46:58 +0200
Message-ID: <20240627234808.1253337-13-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdR18XJz9sSm

From: Johannes Berg <johannes.berg@intel.com>

In 5.17, complete_and_exit() gets replaced by
kthread_complete_and_exit(), so support that API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/149477
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Tested-by: Luciano Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/kthread.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/kthread.h

diff --git a/backport/backport-include/linux/kthread.h b/backport/backport-include/linux/kthread.h
new file mode 100644
index 00000000..23a599e9
--- /dev/null
+++ b/backport/backport-include/linux/kthread.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_KTHREAD_H
+#define __BACKPORT_LINUX_KTHREAD_H
+#include_next <linux/kthread.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void __noreturn
+kthread_complete_and_exit(struct completion *c, long ret)
+{
+	complete_and_exit(c, ret);
+}
+#endif /* < 5.17 */
+
+#endif /* __BACKPORT_LINUX_KTHREAD_H */
-- 
2.45.2

