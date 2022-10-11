Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17083C433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJKVFE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJKVE6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF3C237DC
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yUBGen2yuvnIFskP9INjCc7v3FSjgu7Azyc07Mp54QI=;
        t=1665522295; x=1666731895; b=WZZpKWpADrrsj1Z4u+tOdl3qS+cwrVait+zhkmWTZ8DslqL
        QiTQsXQzeAd5s1kixkyGIoxhbKLBvcHHhHqLw6RU6enNgeu/e1ZwIn35PSWkyhqQ7J/bqYUB8ytta
        FqEv2i0j2x7jcjLwdQBLF7qkkT2kSFAx4GNyjqU73BkE40zXt/UIv5fmbGC4x1XybShtxPprbq+0K
        mdw/UPh0BoYvNdl7KNIbmHoMYnVkhv5IktAHj92zYGkDzM1A8Qb2c7g6d1tKSumphnmtY1IMVYzgD
        bNlsESfehJKf0e9p0lr3rKvrjLtZaMvNrtm0t4plgCFLjzOZVq36+T2tTitOvlSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQl-0045LP-2E;
        Tue, 11 Oct 2022 23:04:51 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/38] backports: stub structs but remove ndo_fill_forward_path
Date:   Tue, 11 Oct 2022 23:04:19 +0200
Message-Id: <20221011230356.fc6d493894a6.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 55 +++++++++++++++++++++
 patches/0107-net-forward-path.cocci         | 19 +++++++
 2 files changed, 74 insertions(+)
 create mode 100644 patches/0107-net-forward-path.cocci

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index c6ca8b5556d5..d2e175243560 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -199,4 +199,59 @@ static inline void backport_dev_hold(struct net_device *dev)
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
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
