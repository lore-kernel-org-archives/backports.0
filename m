Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41852 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbbFOVOO (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Jun 2015 17:14:14 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 22/22] header: fix warning in lockdep_assert_held()
Date: Mon, 15 Jun 2015 23:14:10 +0200
Message-Id: <1434402850-22567-1-git-send-email-hauke@hauke-m.de> (sfid-20150615_231416_793206_1A49DB20)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When building the kernel there are lots of warnings like this:
drivers/net/wireless/ath/ath10k/ce.c:404:21: warning: unused variable ‘ar_pci’ [-Wunused-variable]
  struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);

They are caused by an empty lockdep_assert_held() which does nothing
with this variable in kernel version < 3.9. This patch replaces this
macro with the version from a recent kernel and silence this warning.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/lockdep.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 backport/backport-include/linux/lockdep.h

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
new file mode 100644
index 0000000..3974b8d
--- /dev/null
+++ b/backport/backport-include/linux/lockdep.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_LINUX_LOCKDEP_H
+#define __BACKPORT_LINUX_LOCKDEP_H
+#include_next <linux/lockdep.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#undef lockdep_assert_held
+#ifdef CONFIG_LOCKDEP
+#define lockdep_assert_held(l)	do {				\
+		WARN_ON(debug_locks && !lockdep_is_held(l));	\
+	} while (0)
+#else
+#define lockdep_assert_held(l)			do { (void)(l); } while (0)
+#endif /* CONFIG_LOCKDEP */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+
+#endif /* __BACKPORT_LINUX_LOCKDEP_H */
-- 
2.1.4

