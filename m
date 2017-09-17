Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:43318 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdIQQ6h (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 17 Sep 2017 12:58:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] header: add uuid backports
Date: Sun, 17 Sep 2017 18:58:11 +0200
Message-Id: <20170917165813.17580-3-hauke@hauke-m.de> (sfid-20170917_185838_404557_88624BC9)
In-Reply-To: <20170917165813.17580-1-hauke@hauke-m.de>
References: <20170917165813.17580-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backports the following upstream commits:
f9727a17db9: ("uuid: rename uuid types")
df33767d9fe: ("uuid: hoist helpers uuid_equal() and uuid_copy() from xfs")

ath10k now makes use of them.

Some parts should go into the uapi/linux/uuid.h file, but
then #include_next hack is not working correctly any more, so place it
all into the normal file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/uuid.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 backport/backport-include/linux/uuid.h

diff --git a/backport/backport-include/linux/uuid.h b/backport/backport-include/linux/uuid.h
new file mode 100644
index 00000000..5ffe225b
--- /dev/null
+++ b/backport/backport-include/linux/uuid.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_LINUX_UUID_H_
+#define __BACKPORT_LINUX_UUID_H_
+#include <linux/version.h>
+#include_next <linux/uuid.h>
+
+#if LINUX_VERSION_IS_LESS(4,13,0)
+#define guid_t uuid_le
+#define uuid_t uuid_be
+
+static inline void guid_gen(guid_t *u)
+{
+	return uuid_le_gen(u);
+}
+static inline void uuid_gen(uuid_t *u)
+{
+	return uuid_be_gen(u);
+}
+
+static inline void guid_copy(guid_t *dst, const guid_t *src)
+{
+	memcpy(dst, src, sizeof(guid_t));
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_UUID_H_ */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
