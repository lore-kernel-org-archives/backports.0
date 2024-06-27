Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC013E04F
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532711; cv=none; b=YaOvmWGDlTNzvOyxYJb8Zla8OK0j/6MY5FiiQgvSui+OMlY5iLhyBARnNKAVd5spXuGzQSuJMFdCU2XfwtRZLN0xM2PoeWqaCXzFlYgm+1J0B/CDOb+Jztf//hhcSlv+6RwN++4AJqN7dH1ujw0LSpdrhVNNWAb58ChfklKHyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532711; c=relaxed/simple;
	bh=evNm9lCTddgWQGwdCIq+maHWZ4o7r6CDSM0r5AQKPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2OxUQF7J+JHm7O9wiLD3d0L06k5EJwvXdqgyKFtzTw6sNZEbKR9btjfMvbf2wSxAGVnsvJzc4ztOhGI/nOqE5aDhViQfUePpGpyHZGnxGUxq+vUSpXtTqEEB4Ozcz3tJeP5fDJbZzCN0jrnA2WdYG35E6/CNXZ44AKWEEMLWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=x+kQrevm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="x+kQrevm"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdR2qsxz9smv;
	Fri, 28 Jun 2024 01:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmh+pGWoJRLX9DJZm0c85VBiFjDag6ufjVw6P2zJwnw=;
	b=x+kQrevmn5IS27slT0Tui39SkiCrxgkyL4wR630nOZF8FiSqswQYIgB9AAfDqoXgmivWSR
	6RYTNe6PvJ9MfjDnVYQSY5z162KGzMWc9+TVRjCKa8XLpGpB/9XNhmFQ3yJMK1dowJp8As
	us5DtHJlC6oPeXQj2KyK2mkShILsmSwp57RLG2AOko6JDHAKMUWmmsaS/DfgNQPXP3esup
	IoU1Caj2eD2UFL1dij+FjESHHj/mvlkfTsEjQl7RI8yrSyh/jZG1sshD/2HGYGcmuOKazj
	ggojjf6dlcIODLUa83lbbrVBVye4zPNt5nnZ31vFrlkY0a3qKHSn5lwIvFimGA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/75] backports: stub structs but remove ndo_fill_forward_path
Date: Fri, 28 Jun 2024 01:46:59 +0200
Message-ID: <20240627234808.1253337-14-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdR2qsxz9smv

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 55 +++++++++++++++++++++
 patches/0107-net-forward-path.cocci         | 19 +++++++
 2 files changed, 74 insertions(+)
 create mode 100644 patches/0107-net-forward-path.cocci

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index d95260c2..06d94fd7 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -128,4 +128,59 @@ static inline void backport_dev_hold(struct net_device *dev)
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
index 00000000..f6122394
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
2.45.2

