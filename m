Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE141A38ED
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532711; cv=none; b=FZVaKaru8nGRIQ0wFBFtyfQAvZQX8Lu77pq7pgqRvwS8aezxSVXlQt0vR8mZMQxb/GsRYE4NxHsLma9NmSYW3lRg9dnLhHqR01EV55qNJ/bsOLaMwdmkwlmPOtYh7FY80GPz8b8dMFtJE4jqBpuMaL9r8mudnNaz1m1VvnnMh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532711; c=relaxed/simple;
	bh=O19LZoL8iDwNRMINbAEQg8jWW/MJH/qXzpkGtvwQwX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgmjxermvkTYWtQyF8RJ9DEC13/hnIHIAwSt7mrPx8/UlYVUWyTMpTHtVpLIYhdF7Wez1NxGAW4J9RSDenKnC/ZoqwLSKy642sxXlahFhVITQmEYGyVm99EYjNurpNbK6Kn8L8JhZO6uoNUWlYUe/udxU7uous+29Oyd7JAU7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=AYHNHXud; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="AYHNHXud"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdR6GL5z9sp2;
	Fri, 28 Jun 2024 01:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpgP1cJB4vcgbcJWl+/BhupVh6WBHXUxc6AVKQRejIg=;
	b=AYHNHXudtf1CiVtMD6hf/I/XnEHPwFu55TExjAH+jf5L1BWs3vgCcBD4ADQiHpi4j92xbC
	WePlvd/hHv3brpzHHvK4pLFCR3OfJiWha5ydbSqqElkM5rGguIRXCIHYfLYkc41vDQK/i8
	PSe6x4R083ZqPoinGrP29O7NrX0fUjwlCLylARFWIADCJqf84rRwp0/eHXvq/xNAhXcNAk
	HdzFN5pgQHKlLbXjMssNuR+5n95kdJWuH4u6N2iXU7xiwON3WuECCu++CagLc5JS4ZC/J1
	1tdmSWeJgUpRAle3oKD+sPuA0kj5caQewAHIe7sZHUhG0Yptdg4k+mgcOmhatw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/75] patches: add spatch to adjust to changed ethtool ringparam API
Date: Fri, 28 Jun 2024 01:47:01 +0200
Message-ID: <20240627234808.1253337-16-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This changed in 5.17-rc1, so add the necessary ifdefs via a
new spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0106-ethtool-ringparam.cocci | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 patches/0106-ethtool-ringparam.cocci

diff --git a/patches/0106-ethtool-ringparam.cocci b/patches/0106-ethtool-ringparam.cocci
new file mode 100644
index 00000000..b131d520
--- /dev/null
+++ b/patches/0106-ethtool-ringparam.cocci
@@ -0,0 +1,45 @@
+@set@
+identifier ops, fn;
+@@
+const struct ethtool_ops ops = {
+  .set_ringparam = fn,
+  ...
+};
+
+@@
+identifier set.fn;
+identifier dev, rp, krp, extack;
+@@
+int fn(struct net_device *dev,
+       struct ethtool_ringparam *rp
++#if LINUX_VERSION_IS_GEQ(5,17,0)
+       , struct kernel_ethtool_ringparam *krp,
+       struct netlink_ext_ack *extack
++#endif
+      )
+{
+...
+}
+
+@get@
+identifier ops, fn;
+@@
+const struct ethtool_ops ops = {
+  .get_ringparam = fn,
+  ...
+};
+
+@@
+identifier get.fn;
+identifier dev, rp, krp, extack;
+@@
+void fn(struct net_device *dev,
+        struct ethtool_ringparam *rp
++#if LINUX_VERSION_IS_GEQ(5,17,0)
+        , struct kernel_ethtool_ringparam *krp,
+        struct netlink_ext_ack *extack
++#endif
+       )
+{
+...
+}
-- 
2.45.2

