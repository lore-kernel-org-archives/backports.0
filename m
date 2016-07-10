Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56149 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757207AbcGJVPB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/19] patches: remove usage of the head_frag member of skb
Date: Sun, 10 Jul 2016 23:14:39 +0200
Message-Id: <1468185285-28265-14-git-send-email-hauke@hauke-m.de> (sfid-20160711_013914_780420_84F5A613)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel < 3.5 the skb header can not be fragmented, because this
feature is not implemented, so assume that head_frag is false.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0071-skb-head_frag/wireless.patch            | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0071-skb-head_frag/wireless.patch

diff --git a/patches/collateral-evolutions/network/0071-skb-head_frag/wireless.patch b/patches/collateral-evolutions/network/0071-skb-head_frag/wireless.patch
new file mode 100644
index 0000000..d05cf53
--- /dev/null
+++ b/patches/collateral-evolutions/network/0071-skb-head_frag/wireless.patch
@@ -0,0 +1,16 @@
+diff --git a/net/wireless/util.c b/net/wireless/util.c
+index 9f440a9..18ff313 100644
+--- a/net/wireless/util.c
++++ b/net/wireless/util.c
+@@ -746,7 +746,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
+ 	u8 *payload;
+ 	int offset = 0, remaining, err;
+ 	struct ethhdr eth;
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
++	bool reuse_frag = 0;
++#else
+ 	bool reuse_frag = skb->head_frag && !skb_has_frag_list(skb);
++#endif
+ 	bool reuse_skb = false;
+ 	bool last = false;
+ 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
