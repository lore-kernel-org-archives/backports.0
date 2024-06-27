Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F31A38E4
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532138; cv=none; b=YHXmBvYsD9a7q56sJVmc3KguLHSbHzitJGsvt9SU3PGIUH+zyjcCcc2XdmtZk05RF0VDSlVFdykG8lQUHlOHAjRF306BFFfQ8Im5WE09PqRVyzsLJZtAHP1Q1pI8XCCXEhNPFH8nbEh3+qs2XKwCfav1AK3E/v1VHH64RfhRBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532138; c=relaxed/simple;
	bh=zU1TK298yqI3uz1XJdk1q0ijEFq+G8u2WLiaTEMy87k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCWG9FyCnakgE9b24xHG7fFZ/LH3nY0SM2Ye3hAYMjcjoerX3LP3uDBjq9Qlhk54tKn5jC9pB5qEP4GStVKdrc8SodRx6B7/+sWIcPVMPkuyhUFT/WjoxsdYCRjTCHHWs8B8Y6VGopiz12TiXnsOEfAmKrVb+vAS3gWd86g84uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=uDYv1Y/U; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="uDYv1Y/U"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9Fdc45lCz9sTV;
	Fri, 28 Jun 2024 01:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR1dqC2wxuYg1bGs0IbqoDUoLc5SeYHxPrQqVDdfHic=;
	b=uDYv1Y/UvuUotrKsQWzDcP+EeYQlbQLnVHlq/+7yic88ngTqsDHKswA4H4fhLbKJ390fak
	Q0vsgRyB/c/s8swO00K1GxKSM6H2SxzoYOLElBoj4Z9TGlz9V1hizb0oF2thdE9Kj4BfWm
	m7t3wtLsxHQNK3Gy6+FFkVkj93dKp2kIt3RpfQuPJ+lxkDUH30Y9l5V4THfObWi8fzWMSx
	PMql3GXWoMl9gqGBh2Ti17ycG++1D1/MubsKw0p9ifXc/Ifv8YaDuOyfL07e+sZMmlf3fq
	Pk1wrLd6UTVcXQMuplJIsllfwg+BUWvnhI5Rx+iTr/1HLMducLtGxkckbLMPYQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 47/75] headers: Handle skb_recv_datagram() signature change.
Date: Fri, 28 Jun 2024 01:47:33 +0200
Message-ID: <20240627234808.1253337-48-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older kernel versions have an separate boolean option for the
MSG_DONTWAIT flag. Adapt drivers using the old code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/skbuff.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index d407752f..b40d25c5 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -80,4 +80,12 @@ static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
 #define napi_build_skb build_skb
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,18,6)
+static inline struct sk_buff *LINUX_BACKPORT(skb_recv_datagram)(struct sock *sk, unsigned int flags, int *err)
+{
+	return skb_recv_datagram(sk, flags & ~MSG_DONTWAIT, flags & MSG_DONTWAIT, err);
+}
+#define skb_recv_datagram LINUX_BACKPORT(skb_recv_datagram)
+#endif /* < 5.17 */
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.45.2

