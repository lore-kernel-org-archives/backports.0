Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E912F368
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570576; cv=none; b=E+7PxTwL6q6/AgHPRdoTNmEIjwmd4burEfyOitepkaSE3G+ry+0CevI8Fnrrtq96CMJDIoSQaCipgpCG3+5fsxL6a9n1PLCsVe3GNvY6CMjW9xZN9WpEI/D1OD7Gcvkacf8kca94rWzK6wtYaWyHHGZNPwM1wcii73eq3C1aWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570576; c=relaxed/simple;
	bh=qj+Bcd3qbYorZbxkdHjxaRJKpvWZ8LobtGOxeYGk9HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIWJM05uqSRJLdJ6Y+Vm7mtaerhIcovJgQdV+YZ+22KO1hfJMoVc9UvRv+KL1uoHw/BYx+aDKfGBvpzeurbHkR7Hgbo6S0Q0mrQU/yyl8iyv7PMHpY22R5Tb1D5pcmjbSuzY3xgzPPg+uecHiC0+590pKn7VDSAcEJjHRmHHFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hF1WiRo5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hF1WiRo5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Y4qYnzn88ihs60EAAiaPdXwSrsGGe7UUxhErbn/GWxo=;
	t=1716570574; x=1717780174; b=hF1WiRo5ZqGoirH8oG/dMtmHqF7wLiuZKBJyON8CxP9+X8/
	J9yDPYxTVM3KocjKhV/GFxYGePuHGtNhdaMgYLxAhYRMpWh2sw3db3Wy0a22rXABUc5OnFM2iaokK
	0eFRyJH4ZrbEpjuNHg61YasT1gH+RY2FAQB9e83kYTKuZ2wNPN5m4WQCuE75Ruyn/wx6Pj3cuIVO6
	X61s3BHc2l4ClF3ArUp9zdlRJU5exZcXEsMn0dmcBhb/0oPgVvblIzfs6r/D5f1K1glNrtT3z/F7a
	0adS8zTom413TO7AMFNpQJbpoOWXdpmjT7juowq8M5ngz4duaK71BRRdMlbr5Pyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ8-00000008Xuw-2R7s;
	Fri, 24 May 2024 19:09:32 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 25/74] backports: stub structs but remove ndo_fill_forward_path
Date: Fri, 24 May 2024 19:07:37 +0200
Message-ID: <20240524190907.6994a5b9ef0d.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 55 +++++++++++++++++++++
 patches/0107-net-forward-path.cocci         | 19 +++++++
 2 files changed, 74 insertions(+)
 create mode 100644 patches/0107-net-forward-path.cocci

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 354b399b1ade..ebc137a3bf2f 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -103,4 +103,59 @@ static inline void backport_dev_hold(struct net_device *dev)
 #define dev_hold LINUX_BACKPORT(dev_hold)
 #endif /* < 5.15 */
 
+#ifndef NET_DEVICE_PATH_STACK_MAX
+enum net_device_path_type {
+	DEV_PATH_ETHERNET = 0,
+	DEV_PATH_VLAN,
+	DEV_PATH_BRIDGE,
+	DEV_PATH_PPPOE,
+	DEV_PATH_DSA,
+};
+
+struct net_device_path {
+	enum net_device_path_type	type;
+	const struct net_device		*dev;
+	union {
+		struct {
+			u16		id;
+			__be16		proto;
+			u8		h_dest[ETH_ALEN];
+		} encap;
+		struct {
+			enum {
+				DEV_PATH_BR_VLAN_KEEP,
+				DEV_PATH_BR_VLAN_TAG,
+				DEV_PATH_BR_VLAN_UNTAG,
+				DEV_PATH_BR_VLAN_UNTAG_HW,
+			}		vlan_mode;
+			u16		vlan_id;
+			__be16		vlan_proto;
+		} bridge;
+		struct {
+			int port;
+			u16 proto;
+		} dsa;
+	};
+};
+
+#define NET_DEVICE_PATH_STACK_MAX	5
+#define NET_DEVICE_PATH_VLAN_MAX	2
+
+struct net_device_path_stack {
+	int			num_paths;
+	struct net_device_path	path[NET_DEVICE_PATH_STACK_MAX];
+};
+
+struct net_device_path_ctx {
+	const struct net_device *dev;
+	const u8		*daddr;
+
+	int			num_vlans;
+	struct {
+		u16		id;
+		__be16		proto;
+	} vlan[NET_DEVICE_PATH_VLAN_MAX];
+};
+#endif /* NET_DEVICE_PATH_STACK_MAX */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/patches/0107-net-forward-path.cocci b/patches/0107-net-forward-path.cocci
new file mode 100644
index 000000000000..f612239404a6
--- /dev/null
+++ b/patches/0107-net-forward-path.cocci
@@ -0,0 +1,19 @@
+@ops@
+identifier ops, fn;
+@@
+const struct net_device_ops ops = {
++#if LINUX_VERSION_IS_GEQ(5,13,0)
+  .ndo_fill_forward_path = fn,
++#endif
+  ...
+};
+
+@@
+identifier ops.fn;
+@@
++#if LINUX_VERSION_IS_GEQ(5,13,0)
+int fn(...)
+{
+...
+}
++#endif /* LINUX_VERSION_IS_GEQ(5,13,0) */
-- 
2.45.1

