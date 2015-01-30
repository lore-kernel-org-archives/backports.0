Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55334 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbbA3RO6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 30 Jan 2015 12:14:58 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add IFF_TX_SKB_SHARING
Date: Fri, 30 Jan 2015 18:14:50 +0100
Message-Id: <1422638090-20059-1-git-send-email-johannes@sipsolutions.net> (sfid-20150130_181459_631263_CE06F7D7)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This was introduced on kernel version 3.1, so a kernel (3.0) without
it is still just within the support window. Define this constant if
it isn't defined.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/if.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/if.h

diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
new file mode 100644
index 000000000000..d471340490ca
--- /dev/null
+++ b/backport/backport-include/linux/if.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_IF_H
+#define __BACKPORT_IF_H
+#include_next <linux/if.h>
+
+#ifndef IFF_TX_SKB_SHARING
+#define IFF_TX_SKB_SHARING 0
+#endif
+
+#endif /* __BACKPORT_IF_H */
-- 
2.1.4

