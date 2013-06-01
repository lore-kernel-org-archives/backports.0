Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33276 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab3FAQAz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/11] backports: protect pcmcia_enable_device
Date: Sat,  1 Jun 2013 18:00:16 +0200
Message-Id: <1370102417-6711-11-git-send-email-hauke@hauke-m.de> (sfid-20130601_182936_606318_359E5D5E)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is already defined in RHEL 6.4

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/pcmcia/ds.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
index f0cc5fe..48e8fb4 100644
--- a/backport/backport-include/pcmcia/ds.h
+++ b/backport/backport-include/pcmcia/ds.h
@@ -27,7 +27,9 @@
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#define pcmcia_enable_device(link)	pcmcia_request_configuration(link, &link->conf)
+#ifndef pcmcia_enable_device
+#define pcmcia_enable_device(link)	pcmcia_request_configuration(link, &(link)->conf)
+#endif
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-- 
1.7.10.4

