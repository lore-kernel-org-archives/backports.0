Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFA1A2FDB
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532139; cv=none; b=M3FsiJwQyuvhJUQK+zmMVq7qIV1ByZgODaGLfh5BXO4LVVnlb1mquuTwENgnSifZhNIzA/1cQQuz7okqarXo2c+AXaUV8oUNBsE2gVi4XgA1yO8Qc3vYLC9UZjcDhlSdSUz3Lbj5lzxNrFnNN731L5JxpFFySYKh5ezEVM7Aaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532139; c=relaxed/simple;
	bh=zh87wg4QnUyk/G6bZDktH7CsK3rSPeWMzzoJkc5VtI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaNWagmflFVTeSuS3gqeADzy/FkOch6Gin5/LPhL8wkojhScQR2AzIedh38KAnCoKVt9jUcV6LA5QRuWDFEfFz4Rim3ULCGRSwrG8hQtOHqdoixneIEqmZC/e/tHy1WK63R6vSRmdHxWytYT+7yt8yHwpqZaNlg0VGdJJp+rGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=uhn/hsD4; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="uhn/hsD4"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdd6xLCz9ssZ;
	Fri, 28 Jun 2024 01:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVAdrkTa0CjWhefm0ifOYX6z8mKgBa/9a04if7fUxV0=;
	b=uhn/hsD4t8oRHF/xxNww2Gk5D/qIsfcqlOr+Ar1zwwZ9774/bDEoD7veaC4Ao+UJBirzWj
	3Tcn+E39Pr+5g1XYjWqjjdrLl+96i3bVViQh759ACshvo18N1fPWHteGk8IER1HHJ2fOoC
	54crnSAsBjjVk/f9vG6A7SnXi6neE0VkyqFSn8AXfEebbx92GlNM25a9rrdqX9HldBO+kn
	D6ED/Ixt8TmDpUoZ/S71JxY0gk8UoJL26pTV7DzKrZOrZKIYyIFqIoZUGgT5qXY42baiA5
	fjA6m41T+YapHgxYotNxly7rFRZhx7gR9uQewWBYKxPrmrfCQt5OH58kCU9JCQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 53/75] patch: Adapt struct pcpu_sw_netstats change to u64_stats_t
Date: Fri, 28 Jun 2024 01:47:39 +0200
Message-ID: <20240627234808.1253337-54-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kernel 6.0 the struct pcpu_sw_netstats which contains the counters
for network devices changes from attributes of type u64 to u64_stats_t.
The new types need special functions, use the old arithmetic operations
on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0111-pcpu_sw_netstats.patch | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 patches/0111-pcpu_sw_netstats.patch

diff --git a/patches/0111-pcpu_sw_netstats.patch b/patches/0111-pcpu_sw_netstats.patch
new file mode 100644
index 00000000..70f3fad6
--- /dev/null
+++ b/patches/0111-pcpu_sw_netstats.patch
@@ -0,0 +1,30 @@
+--- a/drivers/net/usb/usbnet.c
++++ b/drivers/net/usb/usbnet.c
+@@ -334,8 +334,13 @@ void usbnet_skb_return (struct usbnet *d
+ 		skb->protocol = eth_type_trans (skb, dev->net);
+ 
+ 	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
++#if LINUX_VERSION_IS_GEQ(6,0,0)
+ 	u64_stats_inc(&stats64->rx_packets);
+ 	u64_stats_add(&stats64->rx_bytes, skb->len);
++#else
++	stats64->rx_packets++;
++	stats64->rx_bytes += skb->len;
++#endif
+ 	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+ 
+ 	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
+@@ -1253,8 +1258,13 @@ static void tx_complete (struct urb *urb
+ 		unsigned long flags;
+ 
+ 		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
++#if LINUX_VERSION_IS_GEQ(6,0,0)
+ 		u64_stats_add(&stats64->tx_packets, entry->packets);
+ 		u64_stats_add(&stats64->tx_bytes, entry->length);
++#else
++		stats64->tx_packets += entry->packets;
++		stats64->tx_bytes += entry->length;
++#endif
+ 		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
+ 	} else {
+ 		dev->net->stats.tx_errors++;
-- 
2.45.2

