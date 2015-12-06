Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37448 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbbLFNSh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:37 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/12] header: fix genl_notify() on kernel 4.4
Date: Sun,  6 Dec 2015 14:18:23 +0100
Message-Id: <1449407908-15547-8-git-send-email-hauke@hauke-m.de> (sfid-20151206_141841_869675_E13C3016)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The change of the parameters of genl_notify() is in kernel 4.4. This
backport should not be applied for kernel 4.4 and newer kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/genetlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 6c6d3e4..2e0bb3e 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -146,10 +146,12 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 #define __genl_const
 #else /* < 3.13 */
 #define __genl_const const
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
 #define genl_notify(_fam, _skb, _info, _group, _flags)			\
 	genl_notify(_fam, _skb, genl_info_net(_info),			\
 		    genl_info_snd_portid(_info),			\
 		    _group, _info->nlhdr, _flags)
+#endif /* < 4.4 */
 #endif /* < 3.13 */
 
 #endif /* __BACKPORT_NET_GENETLINK_H */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
