Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E412EBD5
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570608; cv=none; b=LCH+uf4yAFiV1uP5YeeRozU6wQ9VgX+OhOQvJ+tigCoPCJchtGRp5VViLPdgulUOmsg8tgl5fRj6Up/OfznN5oxeAXS3HjwfqJ7hkSZJeF2gY+wyEk/4kyV7AUypuzBhxvfNCGlMtd7naE2bj/jIp+cu1nPVPTHHMq4Ozq6YkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570608; c=relaxed/simple;
	bh=HyYtRO0WzrjnKiXyDREMsN0R07+QlRO0nJxtgISLFYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+9zWMM9K8fzNH28d8SyLcjkqIXjTTxbmmKvYKU2BAx6aEcYYWjjMkS80w9G2BMCKuF1nrjBObVDhUvCjRth41AlCZgjA0uqp83EZMYNgiPB/9Z5kR6NsPU9zQufiij/Eh9fAS4GTQdppg6Ehhkakpx69eTlaNugrwpFqaQ4Nl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ImN0x3wG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ImN0x3wG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HGjW7pwT5cSepVGOgqp4qpDZyIE6zZ6zN2ByGky97Lo=;
	t=1716570606; x=1717780206; b=ImN0x3wGj7096RV3S3TgTphaqEMbCV7Cff7v52MXXrGBAAH
	yHdFeWtnLOd3S9EZbOI8SHs9sF9gPch7H8uOKF1j5ExBzi5CquAT05X0cbXSPHSLOJ26aB9eH5Cs2
	Kb5glApi4z3T7eBrVZ7MJK+BgEaK/ZgDiOQqXUvnzbS7WJHQtqv33KF/5u4Y0D0KcWNIny6hb7hKk
	dTvO3TiiUVAJSkYMQpNS8gb6ni41UXTimfFUS0Nipl4r+84zJ6YlTYp8iYknr2lk9eSe/Z0kRNpmC
	gapenDSjlny8ZolCVy7bLOjS4eObLcM3+F7ofm3jGdjxaes7/rM5NcQxHNz/7nNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQe-00000008Xuw-0Iiq;
	Fri, 24 May 2024 19:10:04 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 51/74] headers: backport napi add functions
Date: Fri, 24 May 2024 19:08:03 +0200
Message-ID: <20240524190907.3b3d786abe91.Iea3af0a6245c8b6eb0a7b5ffa8e6cf76f6b48fc2@changeid>
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

From: Felix Fietkau <nbd@nbd.name>

Deal with the removed weight argument

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index ebc137a3bf2f..96d47811f7d9 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -4,6 +4,24 @@
 #include <linux/version.h>
 #include <backport/magic.h>
 
+#if LINUX_VERSION_IS_LESS(6,1,0)
+static inline void backport_netif_napi_add(struct net_device *dev,
+					   struct napi_struct *napi,
+					   int (*poll)(struct napi_struct *, int))
+{
+	netif_napi_add(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+#define netif_napi_add LINUX_BACKPORT(netif_napi_add)
+
+static inline void backport_netif_napi_add_tx(struct net_device *dev,
+					      struct napi_struct *napi,
+					      int (*poll)(struct napi_struct *, int))
+{
+	netif_tx_napi_add(dev, napi, poll, NAPI_POLL_WEIGHT);
+}
+#define netif_napi_add_tx LINUX_BACKPORT(netif_napi_add_tx)
+#endif /* < 6.1 */
+
 #if LINUX_VERSION_IS_LESS(4,15,0)
 static inline int _bp_netdev_upper_dev_link(struct net_device *dev,
 					    struct net_device *upper_dev)
-- 
2.45.1

