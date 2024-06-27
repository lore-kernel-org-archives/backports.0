Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9E1A38D3
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532134; cv=none; b=MBOC8bCrvEiyziRvPsdcBqEW+2vDiSdHkpl0EUAUXnYoseW09lAzcWM0TJ0O9ZkXBtRS+ezvoADPbFILcmHccfQP+NUAF82T1INLTdUOE9s0gD5aQxRNcX3QzRODvHFCZnfb2hAlDDf/x0uYat8hgdfO0p8tnIgpCOjh0PDvvp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532134; c=relaxed/simple;
	bh=ZuXnpLssyj/092iVp4MKa8e7fGotW4iyKX+AfCswnlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8E0GGJEqIGItqgR9XTkMBl2blBZ9NQunzoSEoXhwFEx+KwzwDEp3CG/7B+Qgl68M3zgNnCMsynvpXFk8oJOd5wEfwHQVsKtOoDvtNxugMtDrIuaxRdq0slzWExsIel3RlMP/TlsS6Be8m7mi50N1xMLGWk1gQNDJmkZej2dAFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=mU3h8p+T; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="mU3h8p+T"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdY1T0Yz9swH;
	Fri, 28 Jun 2024 01:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3S47XM2RQV4bP86A9ey8Vh6Th9ap3y2hxmy8/3h6Do=;
	b=mU3h8p+TQbfBJtRZ/BacRck5XYulgiv/gIqHAFXGlsogS8J0BO83olvKqt8CdCEUE02Uuk
	ogO+HOa0J3M8Tk0RzmyJpeaekaguHeksHHF7tb0dwGNuVzAKJFrQzRGcJ7v6y7CtnONX3c
	XLMWGwbQ4L+EQsdvgOzRcrg3h1Jej0c1i8JwJ91T/r5iJWubyoqezPvXEHXw5OGmBtH9Yn
	wo0PVxe7mRByEC1J4KkCrpYFSS2OU0A4P/kCQIY6qDVjEGW0juChvRcX6rdQ85aeGGzFd/
	oS3SwIKRW8iNpFOUkP8ejkErVAiXcLmJOlnUZqCKq9AjiyAbpTQDdCIXWzsm3A==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 34/75] headers: add txq_trans_cond_update
Date: Fri, 28 Jun 2024 01:47:20 +0200
Message-ID: <20240627234808.1253337-35-hauke@hauke-m.de>
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
 backport/backport-include/linux/netdevice.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index d7504531..1a0fc0eb 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -183,6 +183,17 @@ struct net_device_path_ctx {
 };
 #endif /* NET_DEVICE_PATH_STACK_MAX */
 
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void backport_txq_trans_cond_update(struct netdev_queue *txq)
+{
+	unsigned long now = jiffies;
+
+	if (READ_ONCE(txq->trans_start) != now)
+		WRITE_ONCE(txq->trans_start, now);
+}
+#define txq_trans_cond_update LINUX_BACKPORT(txq_trans_cond_update)
+#endif /* < 5.17 */
+
 #if LINUX_VERSION_IS_LESS(5,18,0)
 static inline int LINUX_BACKPORT(netif_rx)(struct sk_buff *skb)
 {
-- 
2.45.2

