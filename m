Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2C1A38D6
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=kwl3vBsFnKf40dCMdrgdevCS0rn65OycvjtGk6HLVLFDZaAuj4R5HkexknxBirJsH1ij1IhXg3Hp/JwNkVib+FYNObs3W5abzlVtRbpaDaEtsdiKtdXB0bzo41Muq88J04QIAiEzyoHUSLX0u/wdmmSpxdy4f3FKRpZaMVxb0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=Q57syR4126wK+WnN0/Imeo0ASP9hIKB+kTCN72YyGCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoYrtQDUQT3k5+8egN74hxdYEQtN4cf/PrK62FPvP6st0t5cN2Kmduc9/OAKd5ix1iwdrz28lRy0GDzCfyoRSr6dec1iwmXT4cQ1E1YvLs2uarcmAunY6AdNJdK3uWV3pQcFylaLjjTPTv4+QeGq+WUaxJIOyZ1S9Abut7M9hsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=u8NlQSGX; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="u8NlQSGX"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9FdY6fndz9sZH;
	Fri, 28 Jun 2024 01:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBpOd1wNvk2VHb2kKgW8q3R0sNFFWv4QyPhu1YpTxUc=;
	b=u8NlQSGXWCdGYZBQ1QuJBYN9ygS7+kzHz2tKyRrWofYalz/JQATThyEsSj1iXU8ggWt3C4
	lSd8HMA8GhbK0oOHM1JsTZekmvR5KIMUGQu3AiMjmDSwhCnOsqATN3mtYEhEjNcDZFEi3S
	VYR5fhEhzEEODPSiKfWHqo3UMYS8DpLzBOTsL4nI8dW9HHuZgoSmhn31zSt0h/dyAZRpMy
	DpWTsc2Yr1FR6KUrPbUKvrjV9ppBkM8a5i4sCfRekazSM6kGUBly3UPAKaNrgjNt2dIA+b
	NgW++CYfIGnSh3OVkiXmZLa4tsdg9PuHc25pmLA6nbeqLVyjN3XAtGaMiWickw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 36/75] headers: backport mmc_sw_reset and mmc_hw_reset API changes
Date: Fri, 28 Jun 2024 01:47:22 +0200
Message-ID: <20240627234808.1253337-37-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

mmc_sw_reset() was added in kernel 4.18, do not add it to earlier
versions.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
[Update the kernel version checks]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mmc/core.h | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 backport/backport-include/linux/mmc/core.h

diff --git a/backport/backport-include/linux/mmc/core.h b/backport/backport-include/linux/mmc/core.h
new file mode 100644
index 00000000..83b7aced
--- /dev/null
+++ b/backport/backport-include/linux/mmc/core.h
@@ -0,0 +1,26 @@
+#ifndef __BACKPORT_LINUX_MMC_CORE_H
+#define __BACKPORT_LINUX_MMC_CORE_H
+
+#include_next <linux/mmc/card.h>
+#include_next <linux/mmc/core.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,19,0)
+#if LINUX_VERSION_IS_GEQ(4,18,0)
+static inline int backport_mmc_sw_reset(struct mmc_card *card)
+{
+	return mmc_sw_reset(card->host);
+}
+#define mmc_sw_reset LINUX_BACKPORT(mmc_sw_reset)
+#endif /* >4.18 */
+#endif /* <5.19 */
+
+#if LINUX_VERSION_IS_LESS(5,18,0)
+static inline int backport_mmc_hw_reset(struct mmc_card *card)
+{
+	return mmc_hw_reset(card->host);
+}
+#define mmc_hw_reset LINUX_BACKPORT(mmc_hw_reset)
+#endif /* <5.18 */
+
+#endif
-- 
2.45.2

