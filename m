Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:43406 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbdIQQ6u (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 17 Sep 2017 12:58:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] header: add UUID_STRING_LEN
Date: Sun, 17 Sep 2017 18:58:12 +0200
Message-Id: <20170917165813.17580-4-hauke@hauke-m.de> (sfid-20170917_185854_365871_BCB4CA48)
In-Reply-To: <20170917165813.17580-1-hauke@hauke-m.de>
References: <20170917165813.17580-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in commit 2b1b0d6670 ("lib/uuid.c: introduce a few more
generic helpers") and is used by ath10k.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/uuid.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/uuid.h b/backport/backport-include/linux/uuid.h
index 5ffe225b..bc6fbe17 100644
--- a/backport/backport-include/linux/uuid.h
+++ b/backport/backport-include/linux/uuid.h
@@ -3,6 +3,14 @@
 #include <linux/version.h>
 #include_next <linux/uuid.h>
 
+#ifndef UUID_STRING_LEN
+/*
+ * The length of a UUID string ("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee")
+ * not including trailing NUL.
+ */
+#define	UUID_STRING_LEN		36
+#endif
+
 #if LINUX_VERSION_IS_LESS(4,13,0)
 #define guid_t uuid_le
 #define uuid_t uuid_be
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
