Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6ABC4167B
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJKVFW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJKVFC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B853740F
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dxhBacGFjnThP4LxViiGxu7iX4xCXXVv+rDNXG+DUdk=;
        t=1665522300; x=1666731900; b=Jt/bfWVTqDI+q3rZcrt7MvhaGdgrlICn+GhpkSYK8lUpH2J
        iO/XvZ6iocsjFIm5lqg219MwdiooxE4UBUd+k8b5ZjF/ttiEUnzrnWwtCXI7atjGFyV/RMpcmgODm
        +g2HffjwbShShjUTqvWFygqTYI1SLb7RAv4QPj8JALSQvJwdswxTi0BYSWs0kBZnDWErBLOKiybZ7
        j3GVPYQkcrWaSOIWTZnJ7EKBjbS8flUCelYmzqPAi/SBM25mubtxlMkqUxulutWECPIcFErsUux/J
        hLotDxEDXNIeSc0bSV9gNvur/s01LRhZWBhGUwS+8FmdylEuB44xgrDN9LjEpDtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQr-0045LP-1b;
        Tue, 11 Oct 2022 23:04:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 30/38] backports: add skb_get_dsfield()
Date:   Tue, 11 Oct 2022 23:04:38 +0200
Message-Id: <20221011230356.d7c89bc4d67c.Ia5da0970fd85b5844c99eae51c822dbe1e4ec81c@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

That may also require skb_protocol() and skb_vlan_tag_present()

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/inet_ecn.h | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 backport/backport-include/net/inet_ecn.h

diff --git a/backport/backport-include/net/inet_ecn.h b/backport/backport-include/net/inet_ecn.h
new file mode 100644
index 000000000000..df83d3e179ec
--- /dev/null
+++ b/backport/backport-include/net/inet_ecn.h
@@ -0,0 +1,66 @@
+#ifndef __BACKPORT_NET_INET_ECN_H
+#define __BACKPORT_NET_INET_ECN_H
+#include_next <net/inet_ecn.h>
+#include <linux/version.h>
+#include <linux/if_vlan.h>
+
+#ifndef skb_vlan_tag_present
+#define skb_vlan_tag_present(__skb)       ((__skb)->vlan_present)
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,7,10) &&			\
+	!LINUX_VERSION_IN_RANGE(4,14,212, 4,15,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,19,134, 4,20,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,4,248, 4,5,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,9,248, 4,10,0) &&	\
+	!LINUX_VERSION_IN_RANGE(5,4,53, 5,5,0)
+/* A getter for the SKB protocol field which will handle VLAN tags consistently
+ * whether VLAN acceleration is enabled or not.
+ */
+static inline __be16 skb_protocol(const struct sk_buff *skb, bool skip_vlan)
+{
+	unsigned int offset = skb_mac_offset(skb) + sizeof(struct ethhdr);
+	__be16 proto = skb->protocol;
+
+	if (!skip_vlan)
+		/* VLAN acceleration strips the VLAN header from the skb and
+		 * moves it to skb->vlan_proto
+		 */
+		return skb_vlan_tag_present(skb) ? skb->vlan_proto : proto;
+
+	while (eth_type_vlan(proto)) {
+		struct vlan_hdr vhdr, *vh;
+
+		vh = skb_header_pointer(skb, offset, sizeof(vhdr), &vhdr);
+		if (!vh)
+			break;
+
+		proto = vh->h_vlan_encapsulated_proto;
+		offset += sizeof(vhdr);
+	}
+
+	return proto;
+}
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,16,0)
+#define skb_get_dsfield LINUX_BACKPORT(skb_get_dsfield)
+static inline int skb_get_dsfield(struct sk_buff *skb)
+{
+	switch (skb_protocol(skb, true)) {
+	case cpu_to_be16(ETH_P_IP):
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			break;
+		return ipv4_get_dsfield(ip_hdr(skb));
+
+	case cpu_to_be16(ETH_P_IPV6):
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			break;
+		return ipv6_get_dsfield(ipv6_hdr(skb));
+	}
+
+	return -1;
+}
+#endif
+
+#endif /* __BACKPORT_NET_INET_ECN_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
