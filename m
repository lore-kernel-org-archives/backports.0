Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:48216 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbeIFLbw (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 6 Sep 2018 07:31:52 -0400
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Cc: john@phrozen.org
Subject: [PATCH 6/6] backport: add firmware_request_nowarn and firmware_request_cache
Date: Thu,  6 Sep 2018 08:57:50 +0200
Message-Id: <20180906065750.89673-6-nbd@nbd.name> (sfid-20180906_085756_821855_BB0A9E33)
In-Reply-To: <20180906065750.89673-1-nbd@nbd.name>
References: <20180906065750.89673-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/firmware.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index 186eec3e..b5bc16be 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -5,5 +5,16 @@
 #if LINUX_VERSION_IS_LESS(3,14,0)
 #define request_firmware_direct(fw, name, device) request_firmware(fw, name, device)
 #endif
+#if LINUX_VERSION_IS_LESS(4,18,0)
+#define firmware_request_nowarn(fw, name, device) request_firmware(fw, name, device)
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,17,0)
+#define firmware_request_cache LINUX_BACKPORT(firmware_request_cache)
+static inline int firmware_request_cache(struct device *device, const char *name)
+{
+	return 0;
+}
+#endif
 
 #endif /* __BACKPORT_LINUX_FIRMWARE_H */
-- 
2.17.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
