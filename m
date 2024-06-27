Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210E1A2FB5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532133; cv=none; b=OPyxFN7rl3vQ1YUVUX6oXQVhoDTO1LVcYaZ2HS5/eKNUkLcXW0AD1VPfk7+TD1Dm9u25Bsvmzzhg8VxeOtC9E9Qcsk6cSHZGUuEpD1zxXxs28+WGLiA9X9CiV2GhtlH82bRJUhLAWfGgPwph2W5sF56Rm1e/BenWt3F5hbD+L3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532133; c=relaxed/simple;
	bh=jRs6wT6ZjP2eVl+AIU1JWu0gELpCDc5LA8BzZNoI3HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpKgfTgwQNR5P6RghcxAEPteVPol/0/o4WNSpm2ZQreh0Md6idInDJz701GlCGNoAgfaJYcB2E0iL5NldbGgJjy4bU7il7Ra28uGW/A5tLP55Ab9UgKjtDAiy09aEC0upx2Uujg3PX1si+Mw1ofNjBQABrEpyKs2Wzd7dbpBnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=HU0A3z70; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="HU0A3z70"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdQ3C5Dz9smq;
	Fri, 28 Jun 2024 01:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gn4l38gEiv22T59v5RlFdyhompfefZRI2nEOE7KiySI=;
	b=HU0A3z70WBXclVNra4QDxpsuDNn0HLn1bl7Qr1Y9zKwV7XBhSNT3cfTGltRqb+BiGQGY/+
	G5GhFNnvQ8dat6fYHVCd2t5INIcdJHkF+SQmcnaF0OMyhuSPXSlQ3LO8zOUqlx/vLG/M1y
	PjOlwyyKR5RFRQwlL2jihlktX9cmILRJFahBgBNbZZIYUwvwpgw9piKepk2lCeJsLXV7N+
	z3yfwvAL6iH57wEBVgvZvcUfwCG5n2mQmu7yENjgXdmuF4h/AH2m8iGd1JrosxlCukphFH
	aOULHMKL+3vC/4owitSupmLGmw5b+b6z32ehjfU8hFK7D4jRNF9M3wiRLPSLIQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 11/75] backport: add dev_sw_netstats_tx/rx_add() functions
Date: Fri, 28 Jun 2024 01:46:57 +0200
Message-ID: <20240627234808.1253337-12-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Coelho <luciano.coelho@intel.com>

Two new functions were added in v5.10 and are now used in mac80211.
Add them as bakcports in netdevice.h

type=maint
ticket=jira:WIFI-95070

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/139718
---
 backport/backport-include/linux/netdevice.h | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 354b399b..d95260c2 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -45,6 +45,31 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 
 #define netif_rx_any_context LINUX_BACKPORT(netif_rx_any_context)
 int netif_rx_any_context(struct sk_buff *skb);
+
+static inline void dev_sw_netstats_rx_add(struct net_device *dev, unsigned int len)
+{
+	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+
+	u64_stats_update_begin(&tstats->syncp);
+	tstats->rx_bytes += len;
+	tstats->rx_packets++;
+	u64_stats_update_end(&tstats->syncp);
+}
+
+#endif /* < 5.10 */
+
+#if LINUX_VERSION_IS_LESS(5,10,0)
+static inline void dev_sw_netstats_tx_add(struct net_device *dev,
+					  unsigned int packets,
+					  unsigned int len)
+{
+	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
+
+	u64_stats_update_begin(&tstats->syncp);
+	tstats->tx_bytes += len;
+	tstats->tx_packets += packets;
+	u64_stats_update_end(&tstats->syncp);
+}
 #endif /* < 5.10 */
 
 #if LINUX_VERSION_IS_LESS(5,10,0)
-- 
2.45.2

