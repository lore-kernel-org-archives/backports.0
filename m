Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770822538F
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286841; cv=none; b=Wt7DYKXD0mWiRZmzwwr83gwYDaZj7WjP7ra15cCX0IU73TOsQCg7DO2QvSitvA7moNNN2hGS2tE1OKDR3Jnvvermoy2NVOMUTjZ8Qs2zGJ5qBR1ydoFR/7HqymaLQUY5pJYNQ9Q60Tl6iQlwAeEvruhx4mUGkKqA/34Y5anO98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286841; c=relaxed/simple;
	bh=a9i98l6/BYi3hLGs29lPmgMM+ltRqtJRS0/XOZYHeGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rqr7IAc1UZzzdACW/kMXkRtDraQud87xXGf73JJQ7/j83YXGRWd6PUzbT/KsHmBnzj995Zva51+0J6Mc3PPVjk1cSrQi2aMOCBHm7qnb8BeLKCMRrfAFLxM6AQJuyHGZv9h/K7iTD0VTPqqe7MvCwDoJqjaVx1zpkv+IZ0r7YuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RhdisUTK; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RhdisUTK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPHzxwDdjPXPhIthz0PVCrw7HwHWc/8zOymgpdFxjH0=;
	b=RhdisUTKcUWzmvufUSrogkskO7drpKfaQo5arGeVP8/gIE7yr3SoiLz7KTv6aSzpR7x/++
	comlAHIob99u7pVoNcZV37zHhB2URiDMD1YAPy5ZZyP57Xs1Kk7WbSNfwa7a9VY01qXCVl
	rBkxmi4vM0tXfWptl0rKwbF2fBDZbvI=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 20/20] headers: add of_property_present backport for kernels < 5.18
Date: Wed, 24 Jun 2026 15:38:44 +0800
Message-ID: <20260624073844.2097504-21-cong.yi@linux.dev>
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

of_property_present() was introduced in v5.18 as a wrapper around
of_property_read_bool(). This is needed when CONFIG_OF is enabled
(e.g. arm64, loongarch defconfigs) as brcmfmac/of.c uses it.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/of.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/of.h

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
new file mode 100644
index 00000000..7dc83e1f
--- /dev/null
+++ b/backport/backport-include/linux/of.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_LINUX_OF_H
+#define __BACKPORT_LINUX_OF_H
+#include_next <linux/of.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,18,0)
+static inline bool of_property_present(const struct device_node *np,
+				       const char *propname)
+{
+	return of_property_read_bool(np, propname);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_OF_H */
-- 
2.43.0

