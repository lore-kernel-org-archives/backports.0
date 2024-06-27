Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE01A38C3
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532134; cv=none; b=p/1tsaCDX5Nnmj88nNee0I39nnG1j8QIuvGRRvGg7UHdMA/hxOOVGjo+iUf0JhNXqJ0/8zrLax5SP3k8GEwxdS53uwZutcRglX6vvc9p8YMLORuJZfGABLsN1YPju3Wa0EFcZ2Pb9xsZZ/EmIV93Ban07WIJGIROcqr1ETb+He4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532134; c=relaxed/simple;
	bh=tqt9Az00FeL3wLbjywPQGa8W6tTfjt6FyPFgFRHirAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asVMvsEVuIGmaIGxZgE020z7HaCPFnFdUq79ZGvK/muJPgXHqchPmH54jzGj2RDu7ZMn7Zb8KoBLKtVTqAjpYDrutbvXAQkmMBeuWRUyodqZcTCoxyD8GLnTe3cpsBwlGbPiNW5ciDRg5qUFi1sWyo7Wox+/Ryh9q4DID5dz120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=s6ZykuzO; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="s6ZykuzO"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdP61N2z9sTK;
	Fri, 28 Jun 2024 01:48:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8R90g+Ck+7BaWQOdKKBep3jPraN6OVVKT91+N8liFU0=;
	b=s6ZykuzOD00Dhx/nXyngUlGDC2UkjVsGMDvV33SF417gLkEgqk7moj5WY4pUbuCE8ueZ9w
	XhW5zyC/AbmlANeIg3cNeZTw14zbU1h0PZsFmi1k8re8C1R6SnGJNRHCRtmqsOAwL1PRAu
	7wThhQLavPYiLW/Sapgyq2aWfNZ9f3kei5aKRE7x5OqKxweiUU4QYTO6ajpBrvz8S3I+pn
	1Px4ptjg6+Mj+e85fWx+Y165m31nsZoHh9BBUo+MRD/hiMpbTIJdcAqmQfVGl53EkJ6jcf
	qAPh5KQdkE8AUaszZAB/Ix49FxeswMydrZErAPnMTdNzvBY/v8c5X13CpAu89Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 09/75] backport: implement NLA_POLICY_RANGE for NLA_BINARY
Date: Fri, 28 Jun 2024 01:46:55 +0200
Message-ID: <20240627234808.1253337-10-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdP61N2z9sTK

From: Luca Coelho <luciano.coelho@intel.com>

The range checks for NLA_BINARY are supported since v5.10.  Unwrap the
macros and introduce a new function to test type.

type=maint
ticket=jira:WIFI-85592

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/135576
---
 backport/backport-include/net/netlink.h    | 31 +++++++++++++++++++---
 patches/0097-nla_policy_binary_range.cocci |  5 ++++
 2 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 patches/0097-nla_policy_binary_range.cocci

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index ad588234..7192153b 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -346,10 +346,33 @@ enum nla_policy_validation {
 }
 #endif /* < 4.20 */
 
-#ifndef NLA_POLICY_MIN_LEN
-#define NLA_POLICY_MIN_LEN(_len) {		\
-	.type = NLA_BINARY			\
+#if LINUX_VERSION_IS_LESS(5,10,0)
+// pre-declare all the minimum lengths in use
+#define MIN_LEN_VALIDATION(n)						\
+static inline								\
+int nla_validate_min_len_##n(const struct nlattr *attr,			\
+			     struct netlink_ext_ack *extack)		\
+{									\
+	if (nla_len(attr) < n)						\
+		return -EINVAL;						\
+	return 0;							\
 }
-#endif
+
+MIN_LEN_VALIDATION(2)
+MIN_LEN_VALIDATION(16)
+MIN_LEN_VALIDATION(42)
+
+// double-expansion to expand _min to the actual value
+#define NLA_POLICY_BINARY_RANGE(_min, _max) _NLA_POLICY_BINARY_RANGE(_min, _max)
+#define _NLA_POLICY_BINARY_RANGE(_min, _max)		\
+{							\
+	.type = NLA_BINARY,				\
+	.len = _max,					\
+	.validation_type = NLA_VALIDATE_FUNCTION,	\
+	.validate = nla_validate_min_len_ ## _min,	\
+}
+#else
+#define NLA_POLICY_BINARY_RANGE(_min, _max) NLA_POLICY_RANGE(NLA_BINARY, _min, _max)
+#endif /* < 5.10 */
 
 #endif /* __BACKPORT_NET_NETLINK_H */
diff --git a/patches/0097-nla_policy_binary_range.cocci b/patches/0097-nla_policy_binary_range.cocci
new file mode 100644
index 00000000..cb3b8be5
--- /dev/null
+++ b/patches/0097-nla_policy_binary_range.cocci
@@ -0,0 +1,5 @@
+@@
+expression MIN, MAX;
+@@
+-NLA_POLICY_RANGE(NLA_BINARY, MIN, MAX)
++NLA_POLICY_BINARY_RANGE(MIN, MAX)
-- 
2.45.2

