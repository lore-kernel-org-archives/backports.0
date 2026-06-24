Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F02EC0A6
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286819; cv=none; b=X9BL7m4sdYtk8bOPoqJhUURDNRACgR2rR+XZ8PHZXcdMytXH5GoL4jUJV7tiDwZFldhm9olnIPn2eXmlkquyLajTTVQVN+lOJyQSTpg5bVrK5RXiv6dsx8KL10ThZR2CTJBvNkUp2CTj4hjAhox+xDFBAUI44nif01EwnONTpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286819; c=relaxed/simple;
	bh=4Eg5bng7lcVfTYAXywPinkdR07UZH+XlzNcFHdvIhqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKEHdXyUE64HhNA6jJiVODyJ4S+dl2svdZcwTiORTY094SHZbZWTdnbYO3cFv37PDSERlSCZd/nHKojGNYqowMxbSvjpDb4CDrylhmyz+oNiwS115DKhnfodJdvy1rigSyVd/ZI6a9Y62K0jXxbARueMiBHVbBxRJ9BO1hB1Ogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ip93ZuCa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ip93ZuCa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7Rk6JdGO4f7ROW5XwFfcad2ajCdApoyoO+kXc5V/Xc=;
	b=ip93ZuCacXSLLlvLRNceuNA52lDm2QxgaRoR2CqZ6NdAedGb3D6jsacT1AgWOlf970e3Nk
	QAjCi8sN7FiSf79FHycLuHMXfzff+2lYytXfRiodVjDlBA7XkBp+SuGKnqBsM2Rh4OmSor
	MGSwDmlUM83JhnKbG4vTP8bad1XVrWs=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 07/20] headers: add trace_sk_data_ready no-op for kernels < 6.0
Date: Wed, 24 Jun 2026 15:38:31 +0800
Message-ID: <20260624073844.2097504-8-cong.yi@linux.dev>
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

v6.3 qrtr/ns.c calls trace_sk_data_ready() which was added in v6.0.
Provide a no-op macro stub for older kernels.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/trace/events/sock.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/trace/events/sock.h

diff --git a/backport/backport-include/trace/events/sock.h b/backport/backport-include/trace/events/sock.h
new file mode 100644
index 00000000..7b068aa8
--- /dev/null
+++ b/backport/backport-include/trace/events/sock.h
@@ -0,0 +1,16 @@
+#ifndef __BACKPORT_TRACE_SOCK_H
+#define __BACKPORT_TRACE_SOCK_H
+#include_next <trace/events/sock.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+/*
+ * trace_sk_data_ready() was added in v6.0.  On older kernels, provide
+ * a no-op stub so that callers compile cleanly.
+ */
+#ifndef trace_sk_data_ready
+#define trace_sk_data_ready(sk) do {} while (0)
+#endif
+#endif
+
+#endif /* __BACKPORT_TRACE_SOCK_H */
-- 
2.43.0

