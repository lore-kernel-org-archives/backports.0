Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742F22538F
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286839; cv=none; b=ScNJpgDdc8DrWK3kKpNpE0IwN3e7klu8JkVmfYIeOV8SNWYE6uV0k6mcgDSbY8S/JqfjxSec34ccxf5cPb5BXh6oE2Z17hCjqwlssW+lc42xo8HF5MSK4u/Zuy71NZZ2To89wveyERj5siKYI8AkPdHTnH1wzGvJK1jfV1Ua0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286839; c=relaxed/simple;
	bh=aTf9LAxsBVzuF0n9CQBsO+R63UINLDrk17t/PEMH7V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pujxXs4wsWtWqYean2+oKyIZnyswr17hgZjUdrwOJz7NkadB7RS/a2egL1btj9zv8iWdeVhK31i1t4zU9psN89ye+vV71YTg3/7rU0q6toL08LQiTyfmxlOc1sRpV2AINgiunBU9knPqj97t1NfAFC1FA3ws5HIp9SsWtyZoAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KBxbF/hw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KBxbF/hw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNv3GXvGN7kTQOU0jDnB8a312uch0C/X6acn1g0mBwc=;
	b=KBxbF/hwYA7ROQhaN/XE3I5GrL87yr3tkBSzirmjWHsgQKHcbWuhE8ZWj0c8DV50yIdJqF
	UUrIK2DsM5LldIt1x0q3NuDJct+wr50HXpYVqJe3uh2OpCYIxj71RdoSfnGvkV6/Fe8SNl
	jZld1uLUCzviJ0l8LVLs+xM1JvzPoEE=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 19/20] headers: add led_trigger_blink/oneshot value-to-pointer backport for kernels < 6.5
Date: Wed, 24 Jun 2026 15:38:43 +0800
Message-ID: <20260624073844.2097504-20-cong.yi@linux.dev>
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

In v6.5 led_trigger_blink() and led_trigger_blink_oneshot() changed
their delay_on/delay_off parameters from 'unsigned long *' to
'unsigned long'. mac80211/led.h and led.c call these with value
arguments (v6.5 style). For older kernels that still expect pointers,
provide wrappers that accept values and forward them via pointers to
the original functions.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/leds.h | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 backport/backport-include/linux/leds.h

diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
new file mode 100644
index 00000000..c922c5df
--- /dev/null
+++ b/backport/backport-include/linux/leds.h
@@ -0,0 +1,39 @@
+#ifndef __BACKPORT_LINUX_LEDS_H
+#define __BACKPORT_LINUX_LEDS_H
+#include_next <linux/leds.h>
+#include <linux/version.h>
+
+/*
+ * In v6.5 led_trigger_blink() and led_trigger_blink_oneshot() changed
+ * their delay_on/delay_off parameters from pointer to value:
+ *   v5.4: led_trigger_blink(trigger, unsigned long *delay_on, ...)
+ *   v6.5: led_trigger_blink(trigger, unsigned long delay_on, ...)
+ *
+ * mac80211/led.h and mac80211/led.c call these with value arguments
+ * (v6.5 style).  For older kernels that still expect pointers, provide
+ * wrappers that accept values and forward them via pointers.
+ */
+#if LINUX_VERSION_IS_LESS(6,5,0)
+#undef led_trigger_blink
+static inline void LINUX_BACKPORT(led_trigger_blink)(
+	struct led_trigger *trigger,
+	unsigned long delay_on,
+	unsigned long delay_off)
+{
+	led_trigger_blink(trigger, &delay_on, &delay_off);
+}
+#define led_trigger_blink LINUX_BACKPORT(led_trigger_blink)
+
+#undef led_trigger_blink_oneshot
+static inline void LINUX_BACKPORT(led_trigger_blink_oneshot)(
+	struct led_trigger *trigger,
+	unsigned long delay_on,
+	unsigned long delay_off,
+	int invert)
+{
+	led_trigger_blink_oneshot(trigger, &delay_on, &delay_off, invert);
+}
+#define led_trigger_blink_oneshot LINUX_BACKPORT(led_trigger_blink_oneshot)
+#endif
+
+#endif /* __BACKPORT_LINUX_LEDS_H */
-- 
2.43.0

