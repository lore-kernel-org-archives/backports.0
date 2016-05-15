Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:38115 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcEOJNU (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 15 May 2016 05:13:20 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: genetlink: add define for GENL_UNS_ADMIN_PERM
Date: Sun, 15 May 2016 11:13:17 +0200
Message-Id: <1463303597-32397-1-git-send-email-arend@broadcom.com> (sfid-20160515_111325_348941_B121C38D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit 5ed071ec9992 ("nl80211: Allow privileged operations
from user namespaces") the definition GENL_UNS_ADMIN_PERM is used
by nl80211.c. Add definition if not defined by target kernel.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
Tried to add uapi/linux/genetlink.h, but ended up in inclusion issues that
I did not look into further so instead added the definition in already
existing net/genetlink.h in backport. Feel free to fix otherwise if that
is preferred.

Regards,
Arend
---
 backport/backport-include/net/genetlink.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 2e0bb3e..49661bb 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -154,4 +154,8 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 #endif /* < 4.4 */
 #endif /* < 3.13 */
 
+#ifndef GENL_UNS_ADMIN_PERM
+#define GENL_UNS_ADMIN_PERM	0x10
+#endif
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
