Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86511A2FB5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532131; cv=none; b=TQ4YRqor+PclfUJPA8Iu46Ukn11TMV+LGzve+7rtBwu1BYibj5eCTu4+Xn3VkKgLdI0MKvCvxAQMeaXvmx64KptR710TRPfpSyFVydISlKFqb/hKUt/Etemfy56PoMKlTFBRht8rNYIcVcPx3yI1R6ke2qCSiTFc5z9Jb7+DWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532131; c=relaxed/simple;
	bh=sqL4BW3M6aLsqEL5BbzjaoiachGgIIzhaW7DC0WImcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyIyZwEX8WtiSt9rJeO02O6xcodon+ssnJ22zD9dM8CAGVlZhVL5HtXDAWtC5dvgQBf7y5RiUXYFsHeI5unF45O0BTcrMyoXToxa8MJpjahJVYY/zRQBC7Z/aWMbbflRAo5NAQfEn3zyKX955jT7YAeZ4kr1m6E3p7WECjZQNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=cm19NgZP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="cm19NgZP"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdT36phz9spX;
	Fri, 28 Jun 2024 01:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dqj1r9PlOycZxOmnBQ5lGqsQIEV89nNaF+zdIN1tAHE=;
	b=cm19NgZPjB6Ku9T1QUvF4rnZZJ6Ywlpoj8B4TX6RrKFkJ2bolhdlHMVUluXEdR6ugUA3Q4
	VRsDIm0KAhl9RJ23srTB0Qis4hrC5XYJv/mHRAgAh1tClW6tCrpN+HzW6e1sy+huYcksBd
	jkg2yOaKeP4gYNLqdvnX3cwxcRM29PN1wEglknBah9YjkR8cNLOnOXUV3x1sQ46RhNXwaI
	u1pto9TlhXguz/+sDA90cAAqg/vDwWlz1t1DsX+OMvjThdEgcgbywy9nmkWe38lTtOfYab
	siTGIp2dFen/Hqlum20roUq3PBD5JQQfJVLBCn4BcrgnUcAMUpVSB8TMPO6j8w==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 20/75] backports: add eth_hw_addr_set()
Date: Fri, 28 Jun 2024 01:47:06 +0200
Message-ID: <20240627234808.1253337-21-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Fix kernel condition]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/etherdevice.h | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 backport/backport-include/linux/etherdevice.h

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
new file mode 100644
index 00000000..059c4e51
--- /dev/null
+++ b/backport/backport-include/linux/etherdevice.h
@@ -0,0 +1,23 @@
+#ifndef _BACKPORT_LINUX_ETHERDEVICE_H
+#define _BACKPORT_LINUX_ETHERDEVICE_H
+#include_next <linux/etherdevice.h>
+#include <linux/version.h>
+
+/* This was backported to 4.19.291, but we do not support such high minor numbers use 255 instead. */
+#if LINUX_VERSION_IS_LESS(5,15,0) &&			\
+	!LINUX_VERSION_IN_RANGE(5,4,251, 5,5,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,19,255, 4,20,0)
+/**
+ * eth_hw_addr_set - Assign Ethernet address to a net_device
+ * @dev: pointer to net_device structure
+ * @addr: address to assign
+ *
+ * Assign given address to the net_device, addr_assign_type is not changed.
+ */
+static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
+{
+	ether_addr_copy(dev->dev_addr, addr);
+}
+#endif /* LINUX_VERSION_IS_LESS(5,15,0) */
+
+#endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
2.45.2

