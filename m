Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58766 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbBVBmU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 20:42:20 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] header: add skb_vlan_tag_{present,get,get_id}
Date: Sun, 22 Feb 2015 02:42:04 +0100
Message-Id: <1424569328-12514-3-git-send-email-hauke@hauke-m.de> (sfid-20150222_024224_835714_271054CE)
In-Reply-To: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
References: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These macros are used by some Ethernet drivers now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_vlan.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
index 7d39d52..be2e259 100644
--- a/backport/backport-include/linux/if_vlan.h
+++ b/backport/backport-include/linux/if_vlan.h
@@ -24,4 +24,16 @@
 #define __vlan_find_dev_deep_rcu(real_dev, vlan_proto, vlan_id) __vlan_find_dev_deep(real_dev, vlan_proto, vlan_id)
 #endif
 
+#ifndef skb_vlan_tag_present
+#define skb_vlan_tag_present(__skb)	((__skb)->vlan_tci & VLAN_TAG_PRESENT)
+#endif
+
+#ifndef skb_vlan_tag_get
+#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci & ~VLAN_TAG_PRESENT)
+#endif
+
+#ifndef skb_vlan_tag_get_id
+#define skb_vlan_tag_get_id(__skb)	((__skb)->vlan_tci & VLAN_VID_MASK)
+#endif
+
 #endif /* __BACKPORT_LINUX_IF_VLAN_H_ */
-- 
1.9.1

