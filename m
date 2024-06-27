Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DDD47F6F
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=b8ARpS8HtKpa0nKnfIfbaBHDbjMvcz6nIofsG4YRF3n28u88ap+cX81XzozOyrVQIDuiMSiTP7FApj9/P+a1QRU697ZGPISZQYVdBYkyx63mzdyK8YaTucyXKP1/i+tiOwxxoisl8RP4Y9VlwuwgJQ96AdyKbRqKnY1xhKu5ri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=5YtFCYe4BkN/Z91Ex/KIHnG1QHVbLYF6hMpGbjZqsrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqpBtRQLK2YMMpxqnkWQKkBiqt7hZ7kANx2ZSS1XmAfA45QzvZmEqMNXaqVQCFWR4ab6W1Ae+c1HP/hpvNwX38V1jVN4zKBnd2Lvjm3eSzp0FvaWe6VdEG5mNrflQkBrLCFapbzbFgToHpMrTV5yHUQ5yJBTsTUDRFr1ttaFQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=R4Z9iPIF; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="R4Z9iPIF"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdZ2d9Dz9swV;
	Fri, 28 Jun 2024 01:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Blri3zpwqCpZINHGKaKZMFQQYwuNAYfX2xcpNyJQYc=;
	b=R4Z9iPIFMKIfnIRTzB9YUCY2xdtLuAVmTqaXRDxRqxIgeyLwPrDxJw8G/Fde+gn7rmlUi9
	9vT1t+yxi9RDId0wMBQdoXu3yJ0Rh3ninf7j0OiGACMrHD3kAtZ/xInc8TJF/D/3mquFIX
	yIh6LPPs4oQBI1bdGJG+aA2Zk6pO/0objEh22JP9QD5F6VdnBAi8N9ogj4eY9zbkl/vht2
	rlLdiBnDaNlvce8OHKbFvcSkgZTWOcnbhKSI9AoOkNYIsNShmj02wk1bLTlx3vhnrL0Jrb
	DADW0o5EqeE9NqH5ikYYs0Goc9HEUePnp9nnQm0387g0rJ77eg817Q2x6s5rUQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 38/75] headers: backport device_get_mac_address api change
Date: Fri, 28 Jun 2024 01:47:24 +0200
Message-ID: <20240627234808.1253337-39-hauke@hauke-m.de>
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

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/etherdevice.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 059c4e51..f3fc6ed3 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -2,6 +2,7 @@
 #define _BACKPORT_LINUX_ETHERDEVICE_H
 #include_next <linux/etherdevice.h>
 #include <linux/version.h>
+#include <linux/property.h>
 
 /* This was backported to 4.19.291, but we do not support such high minor numbers use 255 instead. */
 #if LINUX_VERSION_IS_LESS(5,15,0) &&			\
@@ -20,4 +21,15 @@ static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
 }
 #endif /* LINUX_VERSION_IS_LESS(5,15,0) */
 
+#if LINUX_VERSION_IS_LESS(5,16,0)
+static inline int backport_device_get_mac_address(struct device *dev, char *addr)
+{
+	if (!device_get_mac_address(dev, addr, ETH_ALEN))
+		return -ENOENT;
+
+	return 0;
+}
+#define device_get_mac_address LINUX_BACKPORT(device_get_mac_address)
+#endif /* LINUX_VERSION_IS_LESS(5,16,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
2.45.2

