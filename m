Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935131A38C3
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532136; cv=none; b=T6/UqvNJVy4GYNa2px0+L0Gw4AYxmoHwYzC3DVkcsn7PfI2zN29Sp83N6IBE8kLFQuDqZsyx45KqnpfoznzlNtJQ8S9DvML9vXvOaZdkJ4BW3NnO3c8pEI4wIXr+8mzdj5pOp8to/fH+LUBmVVWiNPHpTvl3R/EiPYDrsvT95O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532136; c=relaxed/simple;
	bh=mScnpNkDIWFCKwit9Y/snLExwZH6nR0w7Zeb6Xj2mQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niHJsCIgojDlHieXx15iQrOGbEWPtmvjoXDwRlT/WLiNf5chLdtPy1Ytg15pN/I+VspyL1vOLWzOcxQ6LeIV9yO0b2txFpppHWYhb+FZiLnCNfXltVMErAuT44olyGIzL5/avcrODYTfsBY2MlsKRNWBauxFDS7P/iuFHAJQym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=degzpyz6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="degzpyz6"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9Fdb1G6bz9sZg;
	Fri, 28 Jun 2024 01:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AndZ8jzdR1gigUYEcw/bYG8BG/DnafSgUqW/+AR+FTs=;
	b=degzpyz6/lHIUtgzUV/+1IXw+xFK0XN1uJdm4Kt2JrwjpOJNCeVOhlDMh6QHM3zqCKn8fw
	kegeusD7VZ4aw4AACsjpQlvs3N0WOpXmyvPj4q4tHfTue6fn2Bg9iWAKg/yFhfGqCSKvPb
	Tbli4l8lZeS8l7THh9s4Dp+MPS2Okg3nqBAzM0s305N7RAycfG43RuHUtT+nIwk16oaejS
	aI0DLfp855hDnlzXW7a9RDisToc+Wb43uhfOo0KDRM25rQkEkEIBz8eibgyIu7hDi28xx/
	DsvZNAH0lCgN6g1vd1H8KwifLqpAzx9J8xzX9sIWNlXq29QchHrCwyiEWbalWQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 41/75] headers: backport hwrng_msleep
Date: Fri, 28 Jun 2024 01:47:27 +0200
Message-ID: <20240627234808.1253337-42-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdb1G6bz9sZg

From: Felix Fietkau <nbd@nbd.name>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/hw_random.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 backport/backport-include/linux/hw_random.h

diff --git a/backport/backport-include/linux/hw_random.h b/backport/backport-include/linux/hw_random.h
new file mode 100644
index 00000000..293621df
--- /dev/null
+++ b/backport/backport-include/linux/hw_random.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_HW_RANDOM_H
+#define __BACKPORT_HW_RANDOM_H
+
+#include_next <linux/hw_random.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+
+#if LINUX_VERSION_IS_LESS(6,1,0)
+
+#define hwrng_msleep LINUX_BACKPORT(hwrng_msleep)
+static inline long hwrng_msleep(struct hwrng *rng, unsigned int msecs)
+{
+	return msleep_interruptible(msecs);
+}
+
+#endif /* < 6.1.0 */
+
+#endif
-- 
2.45.2

