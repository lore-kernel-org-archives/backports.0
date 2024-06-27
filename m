Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A11A38D8
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=J1wTYwMSTcRnk9PV6v3z4lYfFlh7XIzyAnX7lg0ojQTLZdBkiXnVMNLYnppPweZN3mfviqB26H6TouThzcngOXI7kep2tDSdv8SsnttWhMZYzuQdcY+t1he6vjwtWH3pYY6Y02ggOa6HQR6lpCIx5UjZ3I+BGhEI/ouFavHZdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=5LhqDWUVAaKKPgSRX/JVasf0KKsF2zyQn7W6sF5wON4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETQlAEDzUBwJByIbhdTJVekPXnBz8n5mSmOau197FXJAvy8GETvjTaQBn6Q9wmwVLIPDB+fF0Rj5MAjutAP7NLUHCokQPs7qu7/tFGEenl1r5BH4BK2W2UUk4ANhkmUPRqJzUtG/+vYeFNfDo48kfSw0OPpBr95biiBuT6knnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=fsm2VzCV; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="fsm2VzCV"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9FdY462sz9sZ5;
	Fri, 28 Jun 2024 01:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVe+gtQmbF2mGW4Duv3bNcbBLZFy5fzOk1BNGvSWlAU=;
	b=fsm2VzCVCOQEEAtP8NfxoUyEgaCoUurY8PKOKiVIoPC+ZwwvrshZOZ/gQ/lioCfETLLBiw
	czfcTHgu4zi2HM0+AlbKrU3mQ+oU5KQk8G3XzFV95uup/ToUyXkvJqB2lvVgxGtnno/iB5
	TANyI8YPDbf60eqK5PlcHu9r4sKBfkJXsOR0+Ybh/52O2bu99r3MhqZmYpHt6qYfSy6uOF
	QlmtOVE5wmrinDsccm2o2LM2CzDmTZuF1mcpETsddnB2Sc+PhIArtm+NY4MaMhOSBwEVIK
	Mcz8jy1QF2CJSWXXyZIsa6T8waC1hkD22E8Az14u231m11QF9yiXYZ2LjqxJ9A==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 35/75] headers: add __vstring and __assign_vstr
Date: Fri, 28 Jun 2024 01:47:21 +0200
Message-ID: <20240627234808.1253337-36-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdY462sz9sZ5

From: Felix Fietkau <nbd@nbd.name>

Used within tracepoints on a few drivers

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/trace/trace_events.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/trace/trace_events.h

diff --git a/backport/backport-include/trace/trace_events.h b/backport/backport-include/trace/trace_events.h
new file mode 100644
index 00000000..fd6a4f3c
--- /dev/null
+++ b/backport/backport-include/trace/trace_events.h
@@ -0,0 +1,16 @@
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+#undef VSTRING_MSG_MAX
+#define VSTRING_MSG_MAX	512
+
+#undef __vstring
+#define __vstring(msg, fmt, va) __dynamic_array(char, msg, VSTRING_MSG_MAX)
+
+#undef __assign_vstr
+#define __assign_vstr(msg, fmt, va)					  \
+	WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg), VSTRING_MSG_MAX, \
+			       fmt, *va) >= VSTRING_MSG_MAX)
+#endif /* <6.0 */
+
+#include_next <trace/trace_events.h>
-- 
2.45.2

