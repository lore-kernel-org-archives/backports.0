Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F61A38EF
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532136; cv=none; b=LR7it7aRIcy1GZHKNUIgciwY1K9BvFffo2xHKwpslQp6HonXFdhYHvlwPPzqNaZyJjwAOwUyKxE+dRrCrFqQzwhGmaUdCz5p+Aoopk0cVu5ZkMG7jYsENYPZaU9fd022r541jezw/mR/39ZozV7qQ2xvV8+rci7UJzOB3Fks8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532136; c=relaxed/simple;
	bh=Zj4Jv7NKZHc4erhTyU1zaG2zR2Z5S7lJr3Wl8GqhJHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH0TXI/MSfOu+Eu0hTp3TUIlHnEoqymj3bnX4didxUyw+PJMVRnVrTMJYVo/IeQ0SG3CQ6BEJ/hms86G4JLNx5zOVGKegTJbd71ifEUmUVpOls00D5o543TRql4W2Fj/mnYNFulfMwV0qsjumfXYzSg3ev3Z/A7Lz2M4tVfI7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=e8t6Uy4m; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="e8t6Uy4m"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdZ6B3rz9t1B;
	Fri, 28 Jun 2024 01:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVcajzyamOo7hQHyMt/wA7i6wrJ3Rhpqs7LNf3QASpw=;
	b=e8t6Uy4mGTJnBVHao3ydGtcCynGd3hKfT6Z4vlXIQ5d1e9ufZVbYtcWKbh4GGvEYkHsBYj
	GYCKCVwHyiI3SM6/08Q6k6V7N9H/vkc+qVd1XJSSLEYyIN5xQ/Ff8OA6jlunOZglMKbkcJ
	w3a+6KvOPPuhOh+jX7vexgPuZjL69YBwGk0XN00FtWO1fczLwVyEM2Qq9O6yG3CsKbjpI2
	hhn99NpWjnHNWRWw3JjcXA1g5f/aiuJzek6piA57LL5CfA0Rqs+hYX+3lScJAAHbXJKVvs
	wtAKOmWEpMQn2sedETKnpZoY0zvBDvw0RK0C0EwYEKzLC0B04GUnQBoyWVwAyg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 40/75] headers: backport get_random_u16, get_random_u8
Date: Fri, 28 Jun 2024 01:47:26 +0200
Message-ID: <20240627234808.1253337-41-hauke@hauke-m.de>
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
 backport/backport-include/linux/random.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 backport/backport-include/linux/random.h

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
new file mode 100644
index 00000000..f4fd47dc
--- /dev/null
+++ b/backport/backport-include/linux/random.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_RANDOM_H
+#define __BACKPORT_RANDOM_H
+#include_next <linux/random.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,1,0)
+static inline u8 get_random_u8(void)
+{
+	return get_random_u32() & 0xff;
+}
+
+static inline u16 get_random_u16(void)
+{
+	return get_random_u32() & 0xffff;
+}
+#endif
+
+#endif /* __BACKPORT_RANDOM_H */
-- 
2.45.2

