Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E091A38CE
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532134; cv=none; b=KUFMiM36gWxRDgBvGLDhYAqgjiGwBFhqccmdt5pPq8RFyFm95Pf3vtwJWhEeH1l8XSYStdciaa2FQ8zYGYfqItZgwBTzWUk29qbeD695YJQNou4tuBjxqCQ20j4K8zTAzKIMSwoGxUPgMU+QGdY9pau7H0wXkAHQ7S7Aut2jhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532134; c=relaxed/simple;
	bh=fDAtaFYTrSpeKJsGC533+Cd6XSzYCqa787BmxAfJTJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEQxZzMhx5kkrD3b6ZYjaWyHJi44gyIcxLSvWtkX922TXB+qTWHnWT4bZPzXGoE2x+FVgY35fAjLCOOF/32spyW0Lpy8+jh91ayDRl+fAvm2cfT2OyTP4pyN5rY6J5YQuwu4pzgybqJqzxuRdFYCOTeOvw4c3Td3QnzZ2RKuVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=J+RIqf6i; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="J+RIqf6i"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdR4kcWz9spd;
	Fri, 28 Jun 2024 01:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRBrVR6g/XjzpC6Ka1b8Ot5y36KS70tZx1rmjBPScS8=;
	b=J+RIqf6iy++un3lPq94FhyYyv993XsZ6ZsDcECyXjCZDcxxGy0YUr0rTpJA+xqn9A3KcBY
	1eX/o9Q6Whw0yQcuO4X3YuG++IwKGqr+y+OWTynZjeonNLi6h66Uw+PVWZ0TFeZWIL+20o
	YQgGK/M+iRZght1t/NZ1QRS18r4uoc7PiaSRpsR6uaYLlHJYLEjG3+7sQnaARldWmP2gSc
	9ZQj12mbmsoCxDOKLRLU6GUVeMVcp4N/6dGYeOBRcZbEySE+m9/tcYVMyI7gYNDGqSQMI/
	NuND3qQ2LWjrPweSGiDfgCEDlQC98lxHKaNyZOAZHchTb3NpdtYOghYjidfLNA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/75] backports: add memset_after/memset_startat
Date: Fri, 28 Jun 2024 01:47:00 +0200
Message-ID: <20240627234808.1253337-15-hauke@hauke-m.de>
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
---
 backport/backport-include/linux/string.h | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 backport/backport-include/linux/string.h

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
new file mode 100644
index 00000000..af21ac51
--- /dev/null
+++ b/backport/backport-include/linux/string.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_LINUX_STRING_H
+#define __BACKPORT_LINUX_STRING_H
+#include_next <linux/string.h>
+
+#ifndef memset_after
+#define memset_after(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetofend(typeof(*(obj)), member), __val,	\
+	       sizeof(*(obj)) - offsetofend(typeof(*(obj)), member));	\
+})
+#endif
+
+#ifndef memset_startat
+#define memset_startat(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetof(typeof(*(obj)), member), __val,		\
+	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
+})
+#endif
+
+#endif /* __BACKPORT_LINUX_STRING_H */
-- 
2.45.2

