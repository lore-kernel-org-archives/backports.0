Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B891A2FB5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532138; cv=none; b=QU8EIukaklLO7pMb2CrAZuP8oZ01R3c2trIpqv0cx89ZnkBHj1QrbZReBqaOORf4bGTAJXrIVLJCZYNshSqu3snbfjH8OVTuW5pDifXFrHeWZV+2B273Vm3DaXyZ9ywj58QH0wmEFZBhuMWr6zoGZbOVOXqqDfcjcChiG3ULLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532138; c=relaxed/simple;
	bh=r2pHXVCSDTkl/1AR50BJzL3Jku5SflRixR8flbDW0LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjOY6MXhWVDSzsgg3EwTsbcv2w+hDr5sBR/WDl+jHHRfE2+pzh7U/tSHETfomrVaNZY24oRvLz+JA0E3T3NzA4K/kf06oLVCrml97imtT3nThEqktYq3J+ZlcspLrUwm8Vc8KhmCr6jnkauroWSO9tpS9hQKA5Mo/TAURPuKReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=cSuY+jFt; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="cSuY+jFt"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdd0KPRz9sR1;
	Fri, 28 Jun 2024 01:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdyqxEkYb6PGs1F51N1cCRuF/ptpXkBsiap56Y0LNBs=;
	b=cSuY+jFtQKCE6sN6cBzafwQ15sb1ammvwgLErqLk97qOagoMUzoLRKS3ow1cGm3a06+xx6
	veW6PZs4UaV56cpYdz5JMrQa6MPgiezEgwWC7POO+oOvFl/VKSjpd/NDz+CVCyOB/0fBtI
	kpsk0PXaScHtVYSVbjVRF6cD1iZ4HgmiBxtFuBd/SSeA24c1KHVLW+g0kS+dUS5PjhBw6m
	ep3sIkwLIEcVZvBtHg4WporkXPzrGMeTfI11nnp+1J/bVfZ7xIpVKo/4D9NuOzubit09FR
	bEXnUdcSns7av1XaLlPR69I7dSJ2RBr1XOJrFnXHp1rRa4YQf+426mRtSfk28Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 49/75] headere: add netif_napi_add_weight()
Date: Fri, 28 Jun 2024 01:47:35 +0200
Message-ID: <20240627234808.1253337-50-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdd0KPRz9sR1

netif_napi_add() was renamed to netif_napi_add_weight() in mainline
kernel. Call the old function instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 1a0fc0eb..530cbb07 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -211,6 +211,17 @@ static inline int LINUX_BACKPORT(netif_rx)(struct sk_buff *skb)
 #define netif_rx LINUX_BACKPORT(netif_rx)
 #endif /* < 5.18.0 */
 
+#if LINUX_VERSION_IS_LESS(5,19,0)
+#define netif_napi_add_weight LINUX_BACKPORT(netif_napi_add_weight)
+static inline void netif_napi_add_weight(struct net_device *dev,
+				   struct napi_struct *napi,
+				   int (*poll)(struct napi_struct *, int),
+				   int weight)
+{
+	netif_napi_add(dev, napi, poll, weight);
+}
+#endif /* < 5.19.0 */
+
 #if LINUX_VERSION_IS_LESS(6,1,0)
 static inline void backport_netif_napi_add(struct net_device *dev,
 					   struct napi_struct *napi,
-- 
2.45.2

