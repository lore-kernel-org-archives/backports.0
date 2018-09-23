Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:40936 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIWXoC (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:02 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/10] patches: make mt76 use skb_pad() instead of __skb_pad()
Date: Sun, 23 Sep 2018 19:45:32 +0200
Message-Id: <20180923174535.16198-8-hauke@hauke-m.de> (sfid-20180923_194552_148162_1A548B79)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

__skb_pad() was only added with kernel 4.13.
The free_on_error parameter of __skb_pad() is set to constant true,
which is also the setting used by skb_pad() so it should be save to use
skb_pad() instead.
This patch should be added to the mainline Linux kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0090-use-skb_pad.patch | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 patches/0090-use-skb_pad.patch

diff --git a/patches/0090-use-skb_pad.patch b/patches/0090-use-skb_pad.patch
new file mode 100644
index 00000000..086328c1
--- /dev/null
+++ b/patches/0090-use-skb_pad.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/wireless/mediatek/mt76/usb.c
++++ b/drivers/net/wireless/mediatek/mt76/usb.c
+@@ -535,7 +535,7 @@ int mt76u_skb_dma_info(struct sk_buff *s
+ 	}
+ 
+ 	if (unlikely(pad)) {
+-		if (__skb_pad(last, pad, true))
++		if (skb_pad(last, pad))
+ 			return -ENOMEM;
+ 		__skb_put(last, pad);
+ 	}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
