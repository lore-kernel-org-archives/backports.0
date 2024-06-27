Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ACB1A38F5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532137; cv=none; b=EFdrzWjypKNnWzA9JNjXt4C41st6wMRhYst3XQZfzGNz/ggZUaWvsYh8o/NTGHpmtlfCl3yjwVIzoWzMBrSvvTXS6U2lOQmftVMl+ZdMyUWTuSg0Gc202aghTsl2Ao/4klosyK3dwfmHicL13tGRbA4aAtQUM6c32wXL5CX88E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532137; c=relaxed/simple;
	bh=7Opzz6s5m5kriihGfyTlXd105RgmJ3ERhy2ZunN+BDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpUW7M3Q79Jp/d0FJ5vanq+kGkKzAMjhGBYsSonruSi4nKMZcVSDtIheL8hXGMZMkoWipURC63NIRVOUSbLfEq76Ge8mWqEwad3S3Fqo38sARGysIPlo1V5t9QJ8DzW5mWljLhar+yWFZcMC/zlQKSe2o+FVjBfF+II2FwjILuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=wXWGBUzs; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="wXWGBUzs"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9Fdb63VVz9spN;
	Fri, 28 Jun 2024 01:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glgQg+OPlJPyhagadRdtPf7tThCJYiJye6YvOhBN/OM=;
	b=wXWGBUzs8X15h0jJWhHH9S3Z5PjMX0BbJ5jBOZEMNmiUQ8tCatwwMD+moTgBoqWAfw6A96
	rB4X57jjfp0KrI61VhWwnHp/BvzZeEdKQIJQfaT8k8H4OCNBeXXFeiD5jcM0rRT6IB4Tth
	dm8ocOQAFjwWcak1wWkhQovPcRPZO7LzNGUJWp6JeXtn7CzdwckRiBOsVptW0PaycZy6Gu
	5Gn8n7Qp5T3pex3h97rAEyuC8zh6HNQVwqsZ0r3lkmkMC8DRGv/iqQGMV8QikwsZa2PO4u
	8U/DHFLfO/GaR6BuH2ugRmtmVHj5RL5ey9VxlNvOVrPTuv9ZnlgxR/jxQ1XGlQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 44/75] headers: Add linux/soc/mediatek/mtk_wed.h
Date: Fri, 28 Jun 2024 01:47:30 +0200
Message-ID: <20240627234808.1253337-45-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mt76 driver uses the structures and enums from this header file. We
are not activating this feature on older kernel versions, but allow to
build the mt76 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../linux/soc/mediatek/mtk_wed.h              | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 backport/backport-include/linux/soc/mediatek/mtk_wed.h

diff --git a/backport/backport-include/linux/soc/mediatek/mtk_wed.h b/backport/backport-include/linux/soc/mediatek/mtk_wed.h
new file mode 100644
index 00000000..46caa89f
--- /dev/null
+++ b/backport/backport-include/linux/soc/mediatek/mtk_wed.h
@@ -0,0 +1,58 @@
+#ifndef __BACKPORT_MTK_WED_H
+#define __BACKPORT_MTK_WED_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(5,19,0)
+#include_next <linux/soc/mediatek/mtk_wed.h>
+#else
+#include <linux/kernel.h>
+#include <linux/rcupdate.h>
+#include <linux/regmap.h>
+#include <linux/pci.h>
+
+#define MTK_WED_TX_QUEUES		2
+
+struct mtk_wed_hw;
+struct mtk_wdma_desc;
+
+enum mtk_wed_bus_tye {
+	MTK_WED_BUS_PCIE,
+	MTK_WED_BUS_AXI,
+};
+
+struct mtk_wed_ring {
+	struct mtk_wdma_desc *desc;
+	dma_addr_t desc_phys;
+	u32 desc_size;
+	int size;
+
+	u32 reg_base;
+	void __iomem *wpdma;
+};
+
+struct mtk_wed_device {
+
+};
+
+static inline int
+mtk_wed_device_attach(struct mtk_wed_device *dev)
+{
+	return -ENODEV;
+}
+
+static inline bool mtk_wed_device_active(struct mtk_wed_device *dev)
+{
+	return false;
+}
+#define mtk_wed_device_detach(_dev) do {} while (0)
+#define mtk_wed_device_start(_dev, _mask) do {} while (0)
+#define mtk_wed_device_tx_ring_setup(_dev, _ring, _regs) -ENODEV
+#define mtk_wed_device_txfree_ring_setup(_dev, _ring, _regs) -ENODEV
+#define mtk_wed_device_reg_read(_dev, _reg) 0
+#define mtk_wed_device_reg_write(_dev, _reg, _val) do {} while (0)
+#define mtk_wed_device_irq_get(_dev, _mask) 0
+#define mtk_wed_device_irq_set_mask(_dev, _mask) do {} while (0)
+
+#endif /* >= 5.19.0 */
+
+#endif /* __BACKPORT_MTK_WED_H */
-- 
2.45.2

