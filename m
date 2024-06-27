Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96321A38FE
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532137; cv=none; b=TLeoBaRHCvRWFu17iBU0bncmoWU+K4ieAZ1oVJNZixk5Zan+SllltpG79O4J03SRr9tJDP5+YGy3MFre1fHRyWuO1+jMGgKCmCaXWe/CQGf2ihonJ3x7C6rNrAT74WIReXnH1K7S+O9sdwdzGBfhFbKrddFlC/9wTPODNWvB9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532137; c=relaxed/simple;
	bh=1m5IhTb+HQ51Ldr0wGHzamAhWe8jlaDFAUT4+FJlehc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3YJkgvRhLtQpdtgTQDXXNug0Wms9K61zxZ77k+I0L91fdYA8SPk76byBOwVn1c9OGkw3ih3fYB22te+c6UwBNa1vKf59IO5aALAUgHX4k5NFxIwZAZBOaPVgEQo9W9VXAcvb/I1h7avuRjZekR4JjM3glXOi/QlCgUXX4lh8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Hb40sPL9; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Hb40sPL9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdW6zCTz9slL;
	Fri, 28 Jun 2024 01:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGgNnAJ88Igmn8hLNnvAPjOer7j0E+VyiWND9X+2Mcc=;
	b=Hb40sPL9dZzo/57bn5dNdRwq9kyahes3D3sM72r1i1O75xVnLf20pC9BX04UcYoyqL3sBE
	ey/Fd1vph8+/5vz8MKgEbZdVhpjwT4jb3KfmMZNlb8DiENg5I4+8QiM/eErZV+oG5BISsx
	qFkZwcZR1iauyj9LFYqOMoWraITCRZxbbryLtevwD3Q7G/8+Z6ons3BhVeAxe9d7zLtl9Z
	xRm1RW/DU9Eeqfqm0lunmY2ZZ/DhTudJBFXmOh0dgslMB6U8gXiDyVM5wNAAoR2XDf6Je7
	Rf9CzXdbZaZ763w/hI7ZF8UAYzlJlo/ATK5Lh8tLxxuQleWSYyHSMfPo5zN6ZA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 31/75] backports: add virtio_reset_device
Date: Fri, 28 Jun 2024 01:47:17 +0200
Message-ID: <20240627234808.1253337-32-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdW6zCTz9slL

From: Johannes Berg <johannes.berg@intel.com>

We need this for hwsim.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/virtio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/virtio.h

diff --git a/backport/backport-include/linux/virtio.h b/backport/backport-include/linux/virtio.h
new file mode 100644
index 00000000..98c84491
--- /dev/null
+++ b/backport/backport-include/linux/virtio.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_VIRTIO_H
+#define __BACKPORT_LINUX_VIRTIO_H
+#include_next <linux/virtio.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+#include <linux/virtio_config.h>
+static inline void virtio_reset_device(struct virtio_device *dev)
+{
+	dev->config->reset(dev);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_VIRTIO_H */
-- 
2.45.2

