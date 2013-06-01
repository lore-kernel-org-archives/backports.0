Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33215 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab3FAQAd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/11] backports: add RedHat version
Date: Sat,  1 Jun 2013 18:00:07 +0200
Message-Id: <1370102417-6711-2-git-send-email-hauke@hauke-m.de> (sfid-20130601_181036_886244_BD287399)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We have to deactivate some backports when a RedHat kernel was found,
the LINUX_BACKPORT preprocessor statement is not sufficient enough.
This is done based on RHEL_RELEASE_CODE. When backports is compiled
against a non RedHat kernel the RHEL_RELEASE_CODE is set to 0, so these
defines are defined to some value.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/version.h |    9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/version.h

diff --git a/backport/backport-include/linux/version.h b/backport/backport-include/linux/version.h
new file mode 100644
index 0000000..d356613
--- /dev/null
+++ b/backport/backport-include/linux/version.h
@@ -0,0 +1,9 @@
+#include_next <linux/version.h>
+
+#ifndef RHEL_RELEASE_VERSION
+#define RHEL_RELEASE_VERSION(a,b) (((a) << 8) + (b))
+#endif
+
+#ifndef RHEL_RELEASE_CODE
+#define RHEL_RELEASE_CODE 0
+#endif
-- 
1.7.10.4

