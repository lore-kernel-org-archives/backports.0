Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19701A2FDC
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532139; cv=none; b=F/VZZtbut82/fqnDf0YKaPYUUbI6h25aXgC6kj4xth2ETmzikUvlpMu8AW8EPuf66PK/eN6GdXObXMC+tpF7LbCyXzS+jCLM+Dw9K8asWWxQLXmba6BqMj86U4QhuUMi8UXGfrBsPUoijHJxYrIYiwFBSniFak8NOFXU6HkX0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532139; c=relaxed/simple;
	bh=TndbF9JW5ie+gpMkwJJ5Uhu9hbk71N9VJ9FvhRxfJC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeCH9htXnzFp2avkPESIro2NIoyMNumhOlgXzQE21e/oyWALWDk5VAghn1n4I9ZPnPIG8DTazl+uNjMb/4v1bOxoprlpH8iqYj639HKVvMV4ePCyGSaXxzWnu+pPqDJ8dFCq2aWjQ1YJHcRG0/frews3QTuTLYANsU9Q6K8L2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Dqx+hZ2I; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Dqx+hZ2I"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9Fdf328pz9sWB;
	Fri, 28 Jun 2024 01:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AtQrgEnqdRLe8/TUr8lmQ6lWcfp/ve/BQ0AwGWxm4w=;
	b=Dqx+hZ2ICSLfIW8XmaGewBisF3+dDrUSUZWwBHMdlDCktqepMVTjUoNbH0hhrjrbqmprYF
	q7yrKvJPYb3MEKRTU6n6iEhaJ37TlH4LBUsJ+82N/ay6GfOtR+oi3YWQ9QSH3ddxXAayaT
	LCuGX9S2aapPKtPb29JhkiwwvkJ1O+wAMu03+dZQZV8SDJUl+IgFYkuZ0moKHwnwAsNoUt
	M25gefhBJmvNLA4j/eyN4lBh+i/5WWgGMCo44QrxGMcoWsBI5Vur/RC9LNcjoGgPD0jKSt
	bZJ7tO4nq1pWMFn7eR4RuHJo4U1BH6XhXQ/dJH/B+VzUEizOsvQDq8ZN1KO35w==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 55/75] header: Add dev_addr_mod()
Date: Fri, 28 Jun 2024 01:47:41 +0200
Message-ID: <20240627234808.1253337-56-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the dev_addr_mod() function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 530cbb07..1ec5b1d2 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -240,4 +240,14 @@ static inline void backport_netif_napi_add_tx(struct net_device *dev,
 #define netif_napi_add_tx LINUX_BACKPORT(netif_napi_add_tx)
 #endif /* < 6.1 */
 
+#if LINUX_VERSION_IS_LESS(5,15,0)
+#define dev_addr_mod LINUX_BACKPORT(dev_addr_mod)
+static inline void
+dev_addr_mod(struct net_device *dev, unsigned int offset,
+	const void *addr, size_t len)
+{
+	memcpy(&dev->dev_addr[offset], addr, len);
+}
+#endif /* < 5.15 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.45.2

