Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB402EEE9E
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286829; cv=none; b=b3RHVHxKjXBq8sHpmDKtv7n+vJ4Qu0sMni5txtN77G22TE9Cq6nN8IPpZ17rKr9iJN5WfYv+VjgsedHyrgvWL0XYOHkoGqLG9L3Kc1re28vCsAbEflMF8+m/feQJKB1w4N4kSMumywqTGuVsASY5DtIyPNh7UQRpvUZlfkERcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286829; c=relaxed/simple;
	bh=zcv5ttlUlZqkc5vt4dGdl3ZnRdZU9cp4mHmsFSJKgDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o16IdutZwnS6SZZKpFeguU5fSmVYSxhH3GiV1eqQKFLh0wapNqKnI8md5CljHm73Q08l6Fhu9wlVs5Ozegdex2ozNGlD+ua/6wNYFGSuIcP3jmNum+NWxheIkAu68kPjEMMywSsVl/UmjxyAXszaDSoBY1dvwOhzKhAm37YNXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ir1de/BX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ir1de/BX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfYxP2N0zris0Y74FeQEt27970LcYpuJoQlyoPDbWrg=;
	b=ir1de/BXaGGfYmPVsZiWhd64wfiaX/01OhUWGlILuJEW9ODdw98MpmagUpatGkrsXITrLQ
	MXOyqc5NROb3s9DzenPTh8INe0qpMC8iwcZCCmIwRERCXwspN9Cj6n3UFeYfEV71DoJkjU
	oE+m6vvOR9mBMyNpQ7peloeo7yiBHHQ=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 13/20] headers: add class_create() single-argument backport for kernels < 6.4
Date: Wed, 24 Jun 2026 15:38:37 +0800
Message-ID: <20260624073844.2097504-14-cong.yi@linux.dev>
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

In v6.4 class_create() was simplified to take only the name argument,
using THIS_MODULE implicitly. For older kernels, provide a wrapper
that forwards to the two-argument __class_create() macro.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/device.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 06595285..069337b7 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -12,4 +12,18 @@
 	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
 #endif
 
+#if LINUX_VERSION_IS_LESS(6,4,0)
+/*
+ * class_create() in v6.4+ takes only the name argument and uses
+ * THIS_MODULE implicitly.  For older kernels, provide a wrapper
+ * that forwards to the 2-argument macro version.
+ */
+#undef class_create
+#define class_create(name) \
+({ \
+	static struct lock_class_key __key; \
+	__class_create(THIS_MODULE, (name), &__key); \
+})
+#endif
+
 #endif /* __BACKPORT_DEVICE_H_ */
-- 
2.43.0

