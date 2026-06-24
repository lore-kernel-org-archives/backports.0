Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D722538F
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286837; cv=none; b=WKtTsDX27aUiPkkc3jfM+RHjGrkoJJZyfWKSA25yher0aUPgQpwuqqHJchbQzpvEicYnBCl9rTRr2hzeTDdSIWHtvPbQmsDCYLm49tFq6jDU+fKNqAbPOQ7Nm34TxQPFNRjBQETvxHMkJ5A5WolcT84hiEepjAekiG4KO+uRoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286837; c=relaxed/simple;
	bh=hyGj4wLxzpNM8gWrLbYoSRKZraoXK8TnNBW1bqYqgwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zbqra1mIKjQTn0UfD/b8ir/ujuKHJCzjwqCCyCzGhQv9ue43LponAOJGK48Zcrkpu3wdt9Q6TisXK+NEArELyFQxczoSmU3HV7fijLZqRwCmpdXqQd1w2MPUSQMcREBw896bDYMsZ+V9X554CiKqzt4n2gChiEMazLf3TJISthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jOLgYNRw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jOLgYNRw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XA0kFf2imEL5qGf0729/ZqJNBH6i5st9vkaYIMKeN0g=;
	b=jOLgYNRwG8g9WpataD6VQuqkHBA23QCeF2greCZDwnKcyrtKlJ3Eeu0JI8hw94lfMb6tux
	WOLb9gCBygA4OxPQ0WgmyoylYgpY4zwd+YJTun6X/x5HyZMDhx9HzZMaX5Ho5ChSr1J9V2
	1Q4q7YiflU144JOpG66HAhOyA1BKoBg=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 18/20] headers: add crypto/utils.h redirect for kernels < 6.6
Date: Wed, 24 Jun 2026 15:38:42 +0800
Message-ID: <20260624073844.2097504-19-cong.yi@linux.dev>
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

In v6.6 crypto_xor(), crypto_xor_cpy(), and crypto_memneq() were
moved from crypto/algapi.h to a new crypto/utils.h header. For older
kernels, redirect to the original location.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/crypto/utils.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/crypto/utils.h

diff --git a/backport/backport-include/crypto/utils.h b/backport/backport-include/crypto/utils.h
new file mode 100644
index 00000000..7722b44a
--- /dev/null
+++ b/backport/backport-include/crypto/utils.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_CRYPTO_UTILS_H
+#define __BACKPORT_CRYPTO_UTILS_H
+#include <linux/version.h>
+
+/*
+ * In v6.6 crypto_xor(), crypto_xor_cpy(), and crypto_memneq() were
+ * moved from crypto/algapi.h to a new crypto/utils.h header.
+ * For older kernels, redirect to the original location.
+ */
+#if LINUX_VERSION_IS_LESS(6,6,0)
+#include <crypto/algapi.h>
+#else
+#include_next <crypto/utils.h>
+#endif
+
+#endif /* __BACKPORT_CRYPTO_UTILS_H */
-- 
2.43.0

