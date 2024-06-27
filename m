Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C21A38DD
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=s4uFMulFm4TShvGaoVqWooKCZ2c7Rsqlr8BFu5ZLKzPetZSyKcIJFIjgd3A7yEmFagNd8+jI2WGg693Tq41IF8YcuFdvgD9WPhijDnCsZ8Nx4ZnAdKWnOPz3NBqa6/9/q5V7zrD5rkTLrGPOCalyPoo6QbT+3G1+JPFvLyoAP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=+4femUi5nJMvbMBE/cfZnrkH6RnpwLNJGfvzr8eLzP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1AHavzsdDpFF6tgRg6WwzttAd8FGKS6MtHwA//rsYAdm98q8mcm2OIQMeR3APC4WWf98ALQCHyJWgwpK80r1SmrOfh71W0mvvyAl+VkS0TcbPcRbubP7mPpXDk/o1kd7VLv1hZlbCMLWYxzFKRwbbW9QFUeC+2DmnAyidc8z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=lcSs8kZJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="lcSs8kZJ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdS3cB6z9spB;
	Fri, 28 Jun 2024 01:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqetON4u65iz1RtlHmMFS4rW5Og8YvZolMS2Kr5eEhk=;
	b=lcSs8kZJCxIjd/n0oEW68BHFcRXFYknMDZAkcGXKmKOFVnMQFcHpJu3A0B1ug7EzxIUPDU
	TayOJDO9kIrB2DWukpn/cNnWuQdfMaWXbESuTag5lI/3pEbeZZ4oqAc9vFveOgGK4P13ZL
	uwBpms6hTrjsuyMsB7lbGI/VKYSVM60sW5YhRq+E9gh7S0y9dABJqt6xNKuCDmjzVyxP1I
	+p4EVB5PycD+TaaM5xZl0ZuOKXwow141yfM8DmJ+kK/jLBM7kbxba5xAdNyO0Fqskq7+IC
	p+9bQo3aYoL37YdShbNYNDMMgoXmKSMlhW95sU+y/e8uZ61Q3ZoxBlwlSnQwNw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/75] backports: define __is_constexpr() for older kernels
Date: Fri, 28 Jun 2024 01:47:03 +0200
Message-ID: <20240627234808.1253337-18-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdS3cB6z9spB

From: Gregory Greenman <gregory.greenman@intel.com>

type=maint
ticket=none

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 backport/backport-include/linux/kernel.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 backport/backport-include/linux/kernel.h

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
new file mode 100644
index 00000000..e2cd309e
--- /dev/null
+++ b/backport/backport-include/linux/kernel.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_KERNEL_H
+#define __BACKPORT_KERNEL_H
+#include_next <linux/kernel.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(4,17,0)
+
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+#endif /* < 4.17.0 */
+
+#endif /* __BACKPORT_KERNEL_H */
-- 
2.45.2

