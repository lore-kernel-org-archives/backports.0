Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9231A38F1
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532136; cv=none; b=ag0NdFH9fyiqx+uHjmDw5o1MzwnMXNYz3hwmbR6nrkEbABlSoF3YHs/2dTQyijOKtrfAlUNrdmj52YRWHKMVNLR73VFyiglXNtXXElOgvW0thHzcIXF1hlb/DoauqPDDmjrT8pep7Czg7c1m0j7XgAKscJH38yZlEXrGpHk+aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532136; c=relaxed/simple;
	bh=KyCVWCTE6lt4I7C/WFf7RSkevedkGE0JPfpbU778qXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bt1er2AOOt2p/hcTo5L/C16pHJNTIyQr+PAmlQVmOEFhIqRmFREgIdu+82JLfdJqIVdS0vw4j6RUGFiAZXz8IHYzn6gmn4fra+eGs/T+oO2iXgUHVppJrn0q2yytv/ekgSS9CePg3/Jz6vp2cTxcWdqLwZVTvG9m0FPFR3MB4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Bvs3BvSX; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Bvs3BvSX"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9Fdb2LYNz9swq;
	Fri, 28 Jun 2024 01:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kQYb6d9+sbsD/zKzyDlLwuhoIktke89uGISYRqF0e0=;
	b=Bvs3BvSXs8HMHha6lcHcUMSMxQlo2UcyIuYZZlX6NRjozuYkYbWSIvTKq3jp0fm/uxBNuq
	pzYrISdfmlwEvD4bVfGwA6AkX9s4/ChiOcwxuTvsU6kb4OT8BqAOfesju2e0JebAkG5dMD
	11EPqSlqLwdl6EDMY5cJWp9EKbnjAfw2cmSa3QcY7RSlWo9Zkg8lzwsO4K0cTpIkwEfLFy
	HMWq8Qkf5coSS37p9VdEmnwWAifzc4z6mZkHUFtVeW7kofZK5ho3Ykbdaxv/ATF0Xt2sOz
	vFTGqIVz6nqX+qEm0B+8Z2GLrkGsiBjdNyqXD8Wb6NrUONL2CuEix9MeKzhZtA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 42/75] headers: backport napi_build_skb
Date: Fri, 28 Jun 2024 01:47:28 +0200
Message-ID: <20240627234808.1253337-43-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdb2LYNz9swq

From: Felix Fietkau <nbd@nbd.name>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/skbuff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2daf0601..d407752f 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -76,4 +76,8 @@ static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,11,0)
+#define napi_build_skb build_skb
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.45.2

