Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B771A3BB2
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532141; cv=none; b=RWwUOyvDUMhqWy0UlzOYykR0DoRSnBsWnHtz1QOQleQbr4F4BsKE8q5Sl3iaxKndBpLzzK6J4+FxqD4LBSWnramPQjMx7AEQjADoyoimrLdshwctZc3LsHSIlvYMTIbFvC42r7vlG54dE9PlG8dfZ8CVv0/meDu/3BEWL+g8GxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532141; c=relaxed/simple;
	bh=wEcKQhpCgHj3+N+vxrxN6iFL7yD7UaChwAEl61iJU1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reR4Z38pRUVe1SKSXfSCcKK04hOFb8vxPTkKXNZhYCRd0mD+Mb7y5eGcaw3WKnBmaj8+UIvddiFjlaCQ7IzKqV8eiVloM6WDXXLWTxl4JDFeTbQSd2Zu2eshWXjM2mUcFmZ8G5oxmbXAAVH4CX4ea5qBqYcZZrslPStyBryQRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=TdiOh7+I; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="TdiOh7+I"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdh6C2Xz9sy9;
	Fri, 28 Jun 2024 01:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxM6LG6zChVo9CXyrqONsifZEKBBPxpGogkHPKtgN88=;
	b=TdiOh7+IR6ZB+MS45/lGNtD/UHxCLZvZkoA3nZU7NCq7Uv3ssWc2jXPhEmaDSGNW++XeLy
	UZCcCIPGDqMBjgHoJZFH4BZAxeH1DHvQ3AxLLmA6C5CCCcCTsG/2FWW0xvJZpWJnwSlN48
	Z+4/3Dxky8DHwqD0yUur4XGvzOo/+eAg3NDSlbdYDIKP30EU/U6X0uPXXMH49W8WJh2SYm
	ob+JrxXfX/hB7DwWHGfOjwDx/yGPdR/X0fX5j0ecKILfhFyjUzFYA3NOvgvMWEXPF4ey7m
	8atIAeeTVY0/C0gNOu9BYoQG/sd/W6uR9VPcdBvpeRl1CSo0ZfpVesrNfTxCIA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 65/75] header Add SENSOR_DEVICE_ATTR_RO
Date: Fri, 28 Jun 2024 01:47:51 +0200
Message-ID: <20240627234808.1253337-66-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These new attributes are used by the mt76 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hwmon-sysfs.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 backport/backport-include/linux/hwmon-sysfs.h

diff --git a/backport/backport-include/linux/hwmon-sysfs.h b/backport/backport-include/linux/hwmon-sysfs.h
new file mode 100644
index 00000000..84a4e149
--- /dev/null
+++ b/backport/backport-include/linux/hwmon-sysfs.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_LINUX_HWMON_SYSFS_H
+#define __BACKPORT_LINUX_HWMON_SYSFS_H
+#include_next <linux/hwmon-sysfs.h>
+
+#ifndef SENSOR_DEVICE_ATTR_RO
+#define SENSOR_DEVICE_ATTR_RO(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL, _index)
+#endif
+
+#ifndef SENSOR_DEVICE_ATTR_RW
+#define SENSOR_DEVICE_ATTR_RW(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0644, _func##_show, _func##_store, _index)
+#endif
+
+#endif /* __BACKPORT_LINUX_HWMON_SYSFS_H */
-- 
2.45.2

