Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:21628 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbcEQJB4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 17 May 2016 05:01:56 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH v2] backports: genetlink: add define for GENL_UNS_ADMIN_PERM
Date: Tue, 17 May 2016 11:01:51 +0200
Message-Id: <1463475711-11318-1-git-send-email-arend@broadcom.com> (sfid-20160517_110200_632158_323516A4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit 5ed071ec9992 ("nl80211: Allow privileged operations
from user namespaces") the definition GENL_UNS_ADMIN_PERM is used
by nl80211.c. Add definition mapping to GENL_ADMIN_PERM for kernel
not having it thus reverting to previous permission check.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
change log:
 - v2: map definition to GENL_ADMIN_PERM.
---
 backport/backport-include/net/genetlink.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 2e0bb3e..cf3e67c 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -154,4 +154,8 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 #endif /* < 4.4 */
 #endif /* < 3.13 */
 
+#ifndef GENL_UNS_ADMIN_PERM
+#define GENL_UNS_ADMIN_PERM	GENL_ADMIN_PERM
+#endif
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
