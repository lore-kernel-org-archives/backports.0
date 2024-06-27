Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA51A2FB7
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532131; cv=none; b=nZ8BinWCTn5h8/6Nk0WidYF1HsPOEwqHbI3tDXqEsqWxu5dV5U11ieGEPqg8JEojZad5nIpBpNWckMzO9DN9CUbKzDqh6ME7JWRJP1mdJE9hb4oDZsxYwL4ZLAdS2CSp9WGwzDKftoTD+AY7+3BkeWHUQp75F+VKB2SntnCAJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532131; c=relaxed/simple;
	bh=3kvnqZ9LxKpiYcLuT4w8HdOXAB0gLZBCCcxYaaizPZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qb6JO5BDqlKUYkUErohTxvzVd9TuN/bYgTxTl2j0DcjlOn+R8x3GR9vsdRrZHiA1c/pa5Z7K7qTRtfl8GVLLF1Ko2K2W3xlc9JZIx26q8VvvXbVEGFILlcMxivk/uzkwsVeabCHlJ0cgDxG3GuDsqxIwUGZen5GhJIEAhyHIx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=VSM64kNa; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="VSM64kNa"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdV16ptz9spj;
	Fri, 28 Jun 2024 01:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08eZYAC4hhLAeHFYq5MQ5yzM4l25sf8RXXc2NSnVv20=;
	b=VSM64kNamEIdSttkfTvSeTq/flPfR0Bqnv77WGrlvHiSRHLhdT5LOku3npt/JMVhGK5vOJ
	pOOlZ/Q85m9RcSCjykV7rkgKZM23FR8tgFAk4NymKr6KXOT6vYOkIcmB1qG7BLEDdi3oY6
	OU61BaJ/vzPrBJ2Ozun6hq40OezmHo9EZnaOASY++4rigeE3E6HR89SwbltrN2AI5u1pr+
	U2CCs5bw4vQOJVlFc62j25f9zphvlM3dvqe4NupiRrqU2rXTi3mKouFSzgWnJiSVk8cVq6
	YVxGfEcUf0b7/l8T9vfdKD9DKOTEDOnnxR49SJ+ZMwARAiEbd3RlcLqvDaLUEw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 23/75] backports: add netif_rx()
Date: Fri, 28 Jun 2024 01:47:09 +0200
Message-ID: <20240627234808.1253337-24-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdV16ptz9spj

From: Johannes Berg <johannes.berg@intel.com>

This got changed upstream to detect the context to get rid
of netif_rx_ni(), so just copy the new upstream version
with the detection.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 06d94fd7..2523cfed 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -183,4 +183,21 @@ struct net_device_path_ctx {
 };
 #endif /* NET_DEVICE_PATH_STACK_MAX */
 
+#if LINUX_VERSION_IS_LESS(5,18,0)
+static inline int LINUX_BACKPORT(netif_rx)(struct sk_buff *skb)
+{
+	bool need_bh_off = !(hardirq_count() | softirq_count());
+	int ret;
+
+	if (need_bh_off)
+		local_bh_disable();
+	ret = netif_rx(skb);
+	if (need_bh_off)
+		local_bh_enable();
+
+	return ret;
+}
+#define netif_rx LINUX_BACKPORT(netif_rx)
+#endif /* < 5.18.0 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.45.2

