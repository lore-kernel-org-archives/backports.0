Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D57C4332F
	for <backports@archiver.kernel.org>; Mon, 21 Feb 2022 14:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354822AbiBUOMU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:12:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357838AbiBUOMS (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 21 Feb 2022 09:12:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D0D1EACF
        for <backports@vger.kernel.org>; Mon, 21 Feb 2022 06:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=cUKjrvLXXGPTEBL7mXtgRrtbMDTqdYHoiDfga5F+Dkw=; t=1645452713; x=1646662313; 
        b=sVAtfM5+G8sHVqBxjsv4VdEissntsQsiR87uyKlcswVPKivGIO50NlS+NfTp6MeknsEzqrtOFin
        37cQVPFCs7YnzePmt8Jlo7q273Ifv0J2AUwyQzXEsEL/0DbJHO5jPlD0mw2dVKNWrpCvu+PTIHEjZ
        3mN86Bg4IG8n9V7YvrA38FC3GtwU1DJ4RdQGt7aLhylCTxXg0lIUGe7VBjHxHAttBRrQfUL4uTuvW
        036fehbr/SbPQqeYdnK16A9FFpG8g3SPcGUjQZqMakABS2sbceYGHyyTtdLBFJQiC9clUNqiz8VPH
        zNdz+hLd0xe1xIf/fXUUaU9jbFK6TCwRZZZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nM9Pp-003r4r-UY;
        Mon, 21 Feb 2022 15:11:50 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] backports: stub structs but remove ndo_fill_forward_path
Date:   Mon, 21 Feb 2022 15:11:45 +0100
Message-Id: <20220221151147.f0ab663b932a.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
X-Mailer: git-send-email 2.35.1
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
index 2ef89e04c1a9..6214a69a3e65 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -192,4 +192,59 @@ static inline void backport_dev_hold(struct net_device *dev)
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
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
