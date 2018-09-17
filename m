Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:56186 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbeIRDA7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:00:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] header: Add NL_SET_BAD_ATTR
Date: Mon, 17 Sep 2018 23:31:40 +0200
Message-Id: <20180917213142.7875-5-hauke@hauke-m.de> (sfid-20180917_233153_435649_50DA739B)
In-Reply-To: <20180917213142.7875-1-hauke@hauke-m.de>
References: <20180917213142.7875-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is  used by the mac80211_hwsim driver. The code was copied from the
mainline kernel.
This was introduced in mainline kernel commit c3ab2b4ec8f7 ("net: ipv4:
Add extack messages for route add failures")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 7da31aad..468a12d1 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -32,4 +32,11 @@ struct netlink_ext_ack {
 #define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).portid
 #endif
 
+#ifndef NL_SET_BAD_ATTR
+#define NL_SET_BAD_ATTR(extack, attr) do {		\
+	if ((extack))					\
+		(extack)->bad_attr = (attr);		\
+} while (0)
+#endif /* NL_SET_BAD_ATTR */
+
 #endif /* __BACKPORT_LINUX_NETLINK_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
