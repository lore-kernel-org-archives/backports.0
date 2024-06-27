Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CC1A3BA7
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532138; cv=none; b=ZxSdvFeTNp/fhTqN/nbCchrqeJ8FDK4LdXiePoVkXWNzJwID+ILNQTXmHvHzUfmOwGoo4R/qrrNeu7iZnIOpOxptMyA1J57K+fe4o7wEOohAQB9ZqYnif1YQYFhDxWh4VA6ZLOBNBjCLOCTHCzPH8N0TaB3W5kM6w3rYG5vLj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532138; c=relaxed/simple;
	bh=He/j4aV8EWGyJEekr3RFL18aut/G9qWBNCkHb61+RdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1LxlEMZOE6dkcRBKvWwT/aG22O4PwYImZyEt4flgMfuqomPrNk3H/CQDourkYEoge9MhedspK0OnoXvtejKGg54/OUgFmJeo5/Y6zzh7/X5k+kbck3Ihtsz6tiQcchWSE89EUIY+/F73+CrskhxP5Tj0a2vnDLrixfYed6pGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=GEAywbzJ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="GEAywbzJ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdZ48Tpz9ssV;
	Fri, 28 Jun 2024 01:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/aKmDN7BC13s/DgW+pHlr1Ahi2G2Hx7XDfn3rn8zMk=;
	b=GEAywbzJl1TljZkiJZgbLt9SZmd3Wg7Bwxqk3LhXp8BRJ2/J8EFYVoLo5uPJn6h6z8wCk0
	xbAh8u0Fip00KfHmAOFZSMBLWQhpQ5/z4jQNF5iKoEWyUeiHJCxVr42LqKi9sxpqXol+Rd
	E4zeTfLU6yFR5RxW4ojiLM9YuzcnkrOBeI9IvdOYTxlgjfLlLG6t4Lw7NunVDvhm4RV4lj
	lsFzpWP3/lL5tOWRWLM8l/5Dvi6t3k//7l6+aAeuBgeh1F5bVUS6fsQnsRIZziislx15cy
	PwgWAeY9AVn/0hZw37Ve0Yu6KwB7HS5r45xB943/nnK/9Ofws4FTg/g+tGab7A==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 39/75] headers: add skb_tcp_all_headers
Date: Fri, 28 Jun 2024 01:47:25 +0200
Message-ID: <20240627234808.1253337-40-hauke@hauke-m.de>
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
 backport/backport-include/linux/tcp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/tcp.h

diff --git a/backport/backport-include/linux/tcp.h b/backport/backport-include/linux/tcp.h
new file mode 100644
index 00000000..2483cbeb
--- /dev/null
+++ b/backport/backport-include/linux/tcp.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_LINUX_TCP_H
+#define __BACKPORT_LINUX_TCP_H
+
+#include_next <linux/tcp.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+static inline int skb_tcp_all_headers(const struct sk_buff *skb)
+{
+	return skb_transport_offset(skb) + tcp_hdrlen(skb);
+}
+#endif
+
+#endif
-- 
2.45.2

