Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/23] compat: add missing platform devid constants
Date: Tue, 26 Feb 2013 21:59:09 +0100
Message-Id: <1361912354-29498-19-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

They are both set to none and will result in no id being added to the
device.

This is a backport of:

commit 689ae231afbac8979f96100b372a5a73458baaa9
Author: Jean Delvare <khali@linux-fr.org>
Date:   Fri Jul 27 22:14:59 2012 +0200

    platform: Add support for automatic device IDs

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.7.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index 6b1d2cf..dd05e00 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -197,6 +197,9 @@ static inline s64 nla_get_s64(struct nlattr *nla)
 	return tmp;
 }
 
+#define PLATFORM_DEVID_NONE	(-1)
+#define PLATFORM_DEVID_AUTO	(-1)
+
 #else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,7,0)) */
 #define netlink_notify_portid(__notify) (__notify->portid)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-- 
1.7.10.4
