Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/23] compat: add empty struct watchdog_device
Date: Tue, 26 Feb 2013 21:59:10 +0100
Message-Id: <1361912354-29498-20-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This is needed in some header file but so driver accesses this struct.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.1.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compat-3.1.h b/include/linux/compat-3.1.h
index 9d78b7d..2b5eb8b 100644
--- a/include/linux/compat-3.1.h
+++ b/include/linux/compat-3.1.h
@@ -105,6 +105,10 @@ void ida_simple_remove(struct ida *ida, unsigned int id);
 
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
 #endif
+
+struct watchdog_device {
+};
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)) */
 
 #endif /* LINUX_3_1_COMPAT_H */
-- 
1.7.10.4
