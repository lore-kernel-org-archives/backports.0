Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA01A3BA6
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532137; cv=none; b=msJXx7lR57ajlvvK/8mTQjiuHqOP9qBPCspniaH37lnFK8Ktx9EAZsrY3IC8666dvev00iijMiX07xfe341ZkzRbdgZJATT6S7J0TAGdRcCL3VZpQYU3euViubDTuPy+MGlkqUZ8s/JeXeGe8peORnJhUs34eqI99sjFaWhbQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532137; c=relaxed/simple;
	bh=c15sDsvc9H2BGEFlQlBYbpnmw+7snDtQyC4F0g3QGY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU2DgLtLyscGVApx5a2NGZb9hY3dy7swf4ANHxQK/6XenIckq2PIA5UjNu921RC8e+vHblphTa0ZVft4VJo9EUZk9bR2w/K/iWK37zX3AnyVbjyWuKXUGHpfCIVOByxsnk13WKCYZFHyYwNreKklVE6Sgf/G/idpz9YacaSebWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=nVTEwF9V; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="nVTEwF9V"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdX2gKbz9srj;
	Fri, 28 Jun 2024 01:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgqdym7V30pAqgJyPprEye0063/viRJa1TmAy0Pn5U8=;
	b=nVTEwF9VOglH7OiD/xXay6UyWnIScCizHHFI0UJX84pNhSmZ3x19FQUjsSX9HNr5Xkgd8L
	6Tgf2UWLEHz+fZDL3vjCY3RafE49LUfjUnjAcO40Uh1+RLw+8XlzzKyyjHThypkvzZ5v63
	Wrn79VcUZdkCLkciKt/xV4zuZgGfSC33Z1DQL6bnA+9ZHaoNyTXGp2uVRbmDyqPE37YHdL
	LDrOY+jkZKBr9ewdhH87n1RjpMoIyXOZ4s0LwFNnUNjCKZ2YFo+MNkYaSDzJjJchmLAz0+
	CKP21VxN/3jiEmzcSPUQf5dSaEmFfKjCreERwm3ja0rb4/Rt/jqeHkDe8s3Jyw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 32/75] headers: backport napi add functions
Date: Fri, 28 Jun 2024 01:47:18 +0200
Message-ID: <20240627234808.1253337-33-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdX2gKbz9srj

From: Felix Fietkau <nbd@nbd.name>

Deal with the removed weight argument

Signed-off-by: Felix Fietkau <nbd@nbd.name>
[Move functions to end of file]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 2523cfed..d7504531 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -200,4 +200,22 @@ static inline int LINUX_BACKPORT(netif_rx)(struct sk_buff *skb)
 #define netif_rx LINUX_BACKPORT(netif_rx)
 #endif /* < 5.18.0 */
 
+#if LINUX_VERSION_IS_LESS(6,1,0)
+static inline void backport_netif_napi_add(struct net_device *dev,
+					   struct napi_struct *napi,
+					   int (*poll)(struct napi_struct *, int))
+{
+	netif_napi_add(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+#define netif_napi_add LINUX_BACKPORT(netif_napi_add)
+
+static inline void backport_netif_napi_add_tx(struct net_device *dev,
+					      struct napi_struct *napi,
+					      int (*poll)(struct napi_struct *, int))
+{
+	netif_tx_napi_add(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+#define netif_napi_add_tx LINUX_BACKPORT(netif_napi_add_tx)
+#endif /* < 6.1 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.45.2

