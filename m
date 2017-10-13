Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49160 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757573AbdJMJmc (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:32 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 04/11] backports: add hex_byte_pack
Date: Fri, 13 Oct 2017 11:42:19 +0200
Message-Id: <20171013094226.10021-4-johannes@sipsolutions.net> (sfid-20171013_114234_518439_289F457F)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This was just renamed at some point, needed by bin2hex()
in the next patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index ea55d7d3b143..0e9a69f9bcd2 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -159,6 +159,8 @@
 #endif /* rounddown */
 
 #if LINUX_VERSION_IS_LESS(3,2,0)
+#define hex_byte_pack pack_hex_byte
+
 /* kernels before 3.2 didn't have error checking for the function */
 #define hex2bin LINUX_BACKPORT(hex2bin)
 int __must_check hex2bin(u8 *dst, const char *src, size_t count);
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
