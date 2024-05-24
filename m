Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F212EBFA
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570609; cv=none; b=OcG7Ojr4ZDn5yuJDW00BwYnZwNfJQomK4aO4Vz6o3N5c/vjNKY35VOjjyIA/5os1DBZX2K76Rf+PrEN79kLhkd/pnoUjaF0ffQwtdtt6/9Zws6VxBrzIZdKgkK19eiTowG198ahZyVIKtCFio2sMifbvya5axAx88FqfYpSixqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570609; c=relaxed/simple;
	bh=GUiMoVGEUIr4puvL88BqGLhvbgcd+f1K2+QLd3U1vxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csqX6JnKaTS9vLcc7NCjT7MWsFuZgypr6DBR3gNSmvkXXQ75fyoR089sVyHO83PhnqwAJihsps637yRMIq1TaPNrF10QLjtBqDqSxwsoKrgkWxMK6V/VOVUkANPf4bbSwW4/fIFxCE4KnG0YE2FVn9TWs1w6iSHUnGfP1l7xieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KxK1xb88; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KxK1xb88"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7AQfP8+6lkDc7Wej61Ot907Ajhh13fey3BozZ8P+SyE=;
	t=1716570608; x=1717780208; b=KxK1xb88JGS4G3ssmxIyI+VnjpvzmTzdnmLhy6YTVAGFXiL
	jeC17DUbiFVjsTHH35D/+TivsTzJICDM5iCV7Ttjdv26U/HUycXzlikPDFJxKvb9j+HrzJ+hmmhov
	vV4B7d2g1wo9CxB2J7gtPpFQ8tsxjnDWLVqbJ6I+c9WAg3Ucwmy/JyJ7NNpswOqIMjVnSaJ9hkuYn
	x+GYRp2ZY0b75z+zM8wfFN2azquoknfcoUkON9cWuzMoCKZmihcTjVdrSC3nM+jTNuSeMwysHmRPE
	DeG4NWNjcRpMFyveq4CTjY3a1IawGq2356fFhe2yTD4OL+XBGmHKJErzCZtO888A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQf-00000008Xuw-4AVi;
	Fri, 24 May 2024 19:10:06 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 53/74] backports: add napi_schedule()
Date: Fri, 24 May 2024 19:08:05 +0200
Message-ID: <20240524190907.7a4b3ef2a400.I78f3e2b2279ed65ee357cf5f22cf5b339cc7e6a5@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

napi_schedule() was introduced in v6.7 by the commit
0a779003213b ("netdev: make napi_schedule return bool on NAPI successful schedule")

Adjust backports accordingly.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 96d47811f7d9..319a1a4eff05 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -176,4 +176,17 @@ struct net_device_path_ctx {
 };
 #endif /* NET_DEVICE_PATH_STACK_MAX */
 
+#if LINUX_VERSION_IS_LESS(6,7,0)
+static inline bool LINUX_BACKPORT(napi_schedule)(struct napi_struct *n)
+{
+	if (napi_schedule_prep(n)) {
+		__napi_schedule(n);
+		return true;
+	}
+
+	return false;
+}
+#define napi_schedule LINUX_BACKPORT(napi_schedule)
+#endif /* < 6.7.0 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.45.1

