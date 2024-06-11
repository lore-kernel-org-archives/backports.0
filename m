Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EC17C209
	for <backports@vger.kernel.org>; Tue, 11 Jun 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106106; cv=none; b=XmQnpaJNj86v8vjv5ymC3hnA/IpsFqjqxMdJn0w6gYby211wtmw4hbwGAjgSC8BVzUFFY1f0rwI0pehXchR3DG2zfdtWSX2+/i7LwAwelgppJEEL46e6j7PYrR+qCqqJ5UyW0C59pp3TL428k353UNHo3UEZF0/7ozN9uEgdtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106106; c=relaxed/simple;
	bh=DeVALrmJfVE5vRxGdj45uzegPCZoBu4u67dcsjG0bbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZel9BAf7XVwVjhwwcLpzd2G48aP9irI5Eyk2QYbaA2119SF0P4/pzjpFnCdJrAFeVvWbRhTcCqlaU9MtwtkUoDHD4hX5Bqi/w9ADhyECvJbM7GZHKHlTcX+4pKumab6voJeVcvSb9dSu9raAH5UA0b3QXKSNv06/mWef8JgFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RqjV+nnX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RqjV+nnX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZRpS1cUt/Jnj2WAGZIA6xscEFhnotHQwOEqtNzsJq0s=; t=1718106104; x=1719315704; 
	b=RqjV+nnXE4zZGBJmnuLfJ+dYvVwGWRLKbFrdBlpRGZqDn9UikMub9MDG8A8mu3ifzaiwnR30YSL
	5NMiwicSG3pqJvxT5ocGysMt8WUlWm/tt6O49ZYK60yILIqrPGXXC1yQHL+6dIMgiACr3QrhR2S3K
	XirFeO1lk3gCdtF+Kj7bnFrnb8K3joACsu+VWX9oo6NhPpFitEdvR6YwW28gKRH3pQvix2Va3qexE
	eyxNB6IQn8bykvH/PLDi8KxuLhxEI2KAahclx/hp8GS2ZhGFbev7sWYrW+XGoj+tFUeUAHTU07Dqb
	edMGg5Key7rSSyFXEEhz1ATIBJf4DFHEWw4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sGzP7-00000008WLU-3Af0;
	Tue, 11 Jun 2024 13:11:06 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] backports: add alloc_netdev_dummy and free_netdev
Date: Tue, 11 Jun 2024 13:11:00 +0200
Message-ID: <20240611111059.23455-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 7f72c3a8eb98..58b8d0c68ed2 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -212,4 +212,33 @@ static inline bool napi_is_scheduled(struct napi_struct *n)
 }
 #endif /* < 6.7.0 */
 
+#if LINUX_VERSION_IS_LESS(6,10,0)
+static inline struct net_device *alloc_netdev_dummy(int sizeof_priv)
+{
+	struct net_device *dev;
+
+	dev = kzalloc(sizeof(*dev) +
+		      ALIGN(sizeof(struct net_device), NETDEV_ALIGN) +
+		      sizeof_priv,
+		      GFP_KERNEL);
+
+	if (!dev)
+		return NULL;
+
+	init_dummy_netdev(dev);
+	return dev;
+}
+
+static inline void LINUX_BACKPORT(free_netdev)(struct net_device *dev)
+{
+	if (dev->reg_state == NETREG_DUMMY) {
+		kfree(dev);
+		return;
+	}
+
+	free_netdev(dev);
+}
+#define free_netdev LINUX_BACKPORT(free_netdev)
+#endif /* 6.10.0 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.45.2

