Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51891 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423394AbbEENTw (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 5 May 2015 09:19:52 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: include missing device.h
Date: Tue,  5 May 2015 15:19:49 +0200
Message-Id: <1430831989-2716-1-git-send-email-johannes@sipsolutions.net> (sfid-20150505_151955_603507_0792B8E6)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

debugfs.h needs device.h, otherwise you get a warning

backport-include/linux/debugfs.h:11:10: warning: ‘struct device’ declared inside parameter list

Change-Id: Ic669c855d47a8114649d1d319fcb1bcdc024415c
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/debugfs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 77b2e642e228..ef9b6e45d217 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_DEBUGFS_H_
 #include_next <linux/debugfs.h>
 #include <linux/version.h>
+#include <linux/device.h>
 #include <generated/utsrelease.h>
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.1.4

