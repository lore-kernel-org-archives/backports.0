Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525C1A3BA8
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532139; cv=none; b=uSHLIyZx9AFhCrieqRVjn7Ie2OX05n+gqZfYyCRpCqj4rPwAI4r+ZUv+MA+DSxSNOKGRkE6ylca+BiRu1Q79A7J+ZVjbZAvsOz+bB7mYRnPURfPn55QkwdVUKSDBPdddPjFlnZAXL4Uw+rf1GMa5zxgJC+ikSV/3KMG9oLiLU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532139; c=relaxed/simple;
	bh=cd849A2TTIu7D1kiNdhmAef/h9vc0EsPSDviDb6Q7qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDBAPEobZ50qYbK7Kr/hWQPh45eBJk+FfUrlBGuyv1A8fWkDD2wew3oRrKzO1S9Zo2207ZwktUBKP96WpctOUe7Vii1l+V0/dBM4pTxT5fQ3vPkyTvv+SJI5+q2lRREGPibbe8OESsIU1C82dOBDA50TBoVrvICrCG0AivUaBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=tFoeS8B9; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="tFoeS8B9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdf6qshz9spd;
	Fri, 28 Jun 2024 01:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5X1L0HprZ1tkLsYFbEq+z79jo0gjtBcvqBPwKJO8Pg=;
	b=tFoeS8B9dvzLkbWH+KboouW9yqsNfdfE5Tyyk58dPtPoFFYSLfdcgdu1/NnZKZS2iyTw9p
	M58uyJZ41yghI8rY8h3bVi5FrshJX4jCNtfqTYXZthJR6ceGYwRv9UkzlPIQcQfaacufBo
	jhJ+wy9msk/3IHZCkqCEZ9Hp1BevCzo1undO62TYkVvuh0jK9+JsWdsjLrZ+cHJp24bVv6
	cNj+QgSvGbmQVrem1LawdscnLELRMHsrbHrTxVWRu8MOhr5lhz2zDt5yqj95va6ADEHHPr
	MO5L3RRM7Ut9eQWPesdCnv2d9YAKaUoEHY+adrV3OwqD0Cu2VfqtAlL4BTDwhA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 57/75] headr: Add empty dev_set_threaded()
Date: Fri, 28 Jun 2024 01:47:43 +0200
Message-ID: <20240627234808.1253337-58-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdf6qshz9spd

dev_set_threaded() allows to deactivated threadded NAPI, threaded NAPI
is only supported in kernel 5.12 and later. If some code wants to set it
in older kenrl versions just return an error.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 1ec5b1d2..cbc96124 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -250,4 +250,12 @@ dev_addr_mod(struct net_device *dev, unsigned int offset,
 }
 #endif /* < 5.15 */
 
+#if LINUX_VERSION_IS_LESS(5,13,0)
+#define dev_set_threaded LINUX_BACKPORT(dev_set_threaded)
+static inline int dev_set_threaded(struct net_device *dev, bool threaded)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* < 5.13 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.45.2

