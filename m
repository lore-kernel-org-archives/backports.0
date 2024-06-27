Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5C1A38EF
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532711; cv=none; b=GVHAohwEN4zu9MWxulJgQCA+yQr0f92gxKVcEwT3KihWpCpfShLLzNn/2kj8/4ORAZsy9N6SZnT+vf3x7COp1hIQy/Skc0sh2xaoaH9edoBnpWAB0R2vIeuUHFPPDauJi3ojs4Cr1tpj7+V0AVQ+7tvbr1VAB5QkjsgILpT7fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532711; c=relaxed/simple;
	bh=bM2tR/QKZ5rsXIB4WLAFc19Rosc/Lsn2AgBmLZYL0MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu6JAvZZXPLDsJC0zQ2WjrklpnLU/F8K61JHL5pU3iayIYowqKVPn3kAfLK05d/YD2PiQiwlIXrWSDGkI0p/naUQ4j75jJLe8SaPBbHJnVKozJQKa9HLrdpVNQfO0qGu8tR1XbqyBdLlHHKQ7hoY2rWcnMEBhAsYVSi8vh8oM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=cITgcou9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="cITgcou9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdT0mSxz9sp4;
	Fri, 28 Jun 2024 01:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9GZQmSRNGaf7KHLjU4zqY/7MLhiFi59JGZnoYtlIIc=;
	b=cITgcou9JnSARyEXHqUROhtLqPc/421PM4wBZXNSERehUU+cETcHfXYWbwVE/zMfKGTYAr
	Xfs0RJ7JQUGt7D+lNf7ku8D6zshspYw+Ukqlx/rnPSqVw9OnLBLswBU+imDVzwycbpFz3m
	lp+TLo0RYq9cUk3/swRbY2zGcXkkSfWQ+92y7E9aJhray1uMz0OmTJN+eYJPgGGKc1ikYy
	ro/saUuhA2m3pZKpHmpY+A9YUxuzQJDcKLnHBeNb6AlSnGFwDPtuiSpnqwj45cBu2UXM56
	sR3oeNywdN/ac/Hx4MOpWDsspTe6cTwSo8gLVHfjo4Pofbg9wpeGA5aCxosEug==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/75] backports: add linux/efi.h
Date: Fri, 28 Jun 2024 01:47:05 +0200
Message-ID: <20240627234808.1253337-20-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdT0mSxz9sp4

From: Johannes Berg <johannes.berg@intel.com>

We need efi_rt_services_supported() on older kernels now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/efi.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/efi.h

diff --git a/backport/backport-include/linux/efi.h b/backport/backport-include/linux/efi.h
new file mode 100644
index 00000000..c2ac9dd9
--- /dev/null
+++ b/backport/backport-include/linux/efi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#ifndef __BACKPORT_LINUX_EFI_H
+#define __BACKPORT_LINUX_EFI_H
+#include_next <linux/efi.h>
+
+#ifndef EFI_RT_SUPPORTED_GET_VARIABLE
+#define efi_rt_services_supported(...) efi_enabled(EFI_RUNTIME_SERVICES)
+#endif
+
+#endif /* __BACKPORT_LINUX_EFI_H */
-- 
2.45.2

