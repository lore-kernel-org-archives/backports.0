Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48814 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdJKObv (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 11 Oct 2017 10:31:51 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] backports: remove genregdb Makefile change
Date: Wed, 11 Oct 2017 16:31:45 +0200
Message-Id: <20171011143147.3337-3-johannes@sipsolutions.net> (sfid-20171011_163300_658851_6193E789)
In-Reply-To: <20171011143147.3337-1-johannes@sipsolutions.net>
References: <20171011143147.3337-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This piece of code no longer exists.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0013-fix-makefile-includes/net_wireless_Makefile.patch | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/net_wireless_Makefile.patch

diff --git a/patches/0013-fix-makefile-includes/net_wireless_Makefile.patch b/patches/0013-fix-makefile-includes/net_wireless_Makefile.patch
deleted file mode 100644
index ff94708212f3..000000000000
--- a/patches/0013-fix-makefile-includes/net_wireless_Makefile.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/net/wireless/Makefile
-+++ b/net/wireless/Makefile
-@@ -19,6 +19,6 @@ cfg80211-$(CONFIG_CFG80211_INTERNAL_REGD
- CFLAGS_trace.o := -I$(src)
- 
- $(obj)/regdb.c: $(src)/db.txt $(src)/genregdb.awk
--	@$(AWK) -f $(srctree)/$(src)/genregdb.awk < $< > $@
-+	@$(AWK) -f $(src)/genregdb.awk < $< > $@
- 
- clean-files := regdb.c
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
