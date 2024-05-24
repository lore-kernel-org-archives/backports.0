Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C286AD6
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570621; cv=none; b=UjUPdpBnCVKAogNo1GkUa6d9dMUPmd0vYdEVqmj3ZmHVWbvxnKxn9HjceDAch87+ivp8J1hMNNvyoUuOkR1DQpV88MFAHl57LL5RgJclNd7CdP/WpcWeDA+zmowpEDFo0A4/eJ/amNAcrppxfvsVD84Tfj9tpWQ2TlgFtvo16HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570621; c=relaxed/simple;
	bh=8g29JsbVzhBZGGAdgAE0nra5qs3jBONPsBdLYZZaeEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOs3/9ZVHYjDx77+e8KVuf12b2XyCXRfwjefCi64pJF8wKnpxmCNva0nQdCltjJrSW5Gp2CJ1hHVzHYcOO36AQKQPz//bCotIYnb8G62Ew2R0A3ikyAi/1QyXliPDAO51iXN5pJ5uwgH1B6ZrhIU/WyVTnyCMPYaMI5Wh2PAOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PBNR5HIT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PBNR5HIT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gP2bdSlYRyM+hmYMUCHWNTN86uLOTGJ+uYUnWZt4LuI=;
	t=1716570619; x=1717780219; b=PBNR5HIToyVaF3EJOz0IBO8ipRd0Nap8HK8maxJFewyRa7Y
	fAPzFu58nmLO7e5g97nI6+5vaMiIFWjUMlyd5KfpIcYDVhd80KA2MhnGcyHH+lcH5ioAizlkxuQUb
	TJLfnKLXn/92BmwmqxkuA7ifrTNwaRFBieUYJw21aZbTJnIJ7r3/pGqskheZZZCrMMXz2UpMI0ePE
	K95NX/Klpfp25KODaqfJ08LWGhJinvuKw/0vDSPF2VxylbZGM9KsV78iYYCCer80l7oHbrqNtOoG9
	Ie75nvKYrEYJCLjRWOe4kUhFdpo3+Pf89Jk0R3nf8MDFcCJCRTgsGAWcRi5wO42w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQr-00000008Xuw-2HM1;
	Fri, 24 May 2024 19:10:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 65/74] patches: add spatch to adjust to changed ethtool ringparam API
Date: Fri, 24 May 2024 19:08:17 +0200
Message-ID: <20240524190907.3b62f721f5c4.I18f41541a5b4c6f8285a78d32203e6dbc35a5105@changeid>
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

This changed in 5.17-rc1, so add the necessary ifdefs via a
new spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0106-ethtool-ringparam.cocci | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 patches/0106-ethtool-ringparam.cocci

diff --git a/patches/0106-ethtool-ringparam.cocci b/patches/0106-ethtool-ringparam.cocci
new file mode 100644
index 000000000000..b131d52039ca
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
2.45.1

