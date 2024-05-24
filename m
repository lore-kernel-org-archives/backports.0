Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6F12F372
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570610; cv=none; b=XAZD8+bTPlkkw0/nbL1qsug4Obg6rxDBZC3TDWqRtSkmk5PZ/r34tAMMt8o8ZlFd2PFGxc18CtaRnErP+0ar2UIpcf2YB2Npno3fIL6z96dALTlgTuco6mGLyagcoLkze5W4NMn1oFiRVlmU2C535jTVdqhY8yPno4KWmF53A6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570610; c=relaxed/simple;
	bh=hibKhqLab2U86tjFP8qI7wBrSA9fM1vDiWradYql2L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGWH55lJS3xFAaPrObBAce84sjGLtGBOIqOQd7Eumf/ZUCaZ+p71+AwSaJinvBAE1FtxkBm1fnuemqnFs5lXfSWXh/YHjGSv8rssiLoBH1tQiIZI6NqhU63A7Nz8jjrlcToSJF1ed4UCEjb+qBXOniPhqz1VTot3XrdNvTci/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dBAsHDwt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dBAsHDwt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7TTy4r7QjyqqXP2TnNoyHk1Rs33TZcTEl/RbJiybAAs=;
	t=1716570609; x=1717780209; b=dBAsHDwtydfdDvaXnO+qPXZ+pf+Zn5m4qrgisWWqsYbFnui
	c/TtEkZpMw82+rgotWaKi4ixx5oUH0YqtshTOeLOavu9DthRSF37nIOI1M7eaZLwLORTcfQXPvwMA
	UWQ6HfjWOChQPuH5lSUrJyNi17+PdIxf1IZ9ZAF0p9lH0QCQx9bO26UBB1z40xYuKcuUrIx1nIFYx
	hRPJ3EdoupNYcpZFATo+qaUOL4JEPxeTiGILbHiE83xMiPVnWCoCBAZZVbmuOHFyTypnx3ViJLMhg
	tQbi9Ph2C5FrduuWAOy4/0E+urLmRYf4CKt3HExgTIIzqemBVubRvNyKAf4v1gZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQg-00000008Xuw-3S9Q;
	Fri, 24 May 2024 19:10:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 54/74] backports: add netif_rx()
Date: Fri, 24 May 2024 19:08:06 +0200
Message-ID: <20240524190907.99866985a48c.I4b1f5287579f615582a608782b8513f2f5cb374c@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This got changed upstream to detect the context to get rid
of netif_rx_ni(), so just copy the new upstream version
with the detection.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 319a1a4eff05..f720b7537f4b 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -176,6 +176,23 @@ struct net_device_path_ctx {
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
 #if LINUX_VERSION_IS_LESS(6,7,0)
 static inline bool LINUX_BACKPORT(napi_schedule)(struct napi_struct *n)
 {
-- 
2.45.1

