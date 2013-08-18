Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60819 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab3HRXiU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:20 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Patrick Ziegler <patrick.ziegler@fh-kl.de>
Subject: [PATCH v2 02/19] backports: usb_translate_errors() is needed for < 3.2
Date: Mon, 19 Aug 2013 01:37:47 +0200
Message-Id: <1376869084-16513-3-git-send-email-hauke@hauke-m.de> (sfid-20130819_013821_513639_4FC900F4)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

usb_translate_errors() is needed for every kernel < 3.2 and not <
2.6.39.

This fixes a problem introduced in this commit:
commit aee2dc1d7fd03d3900e06e88793b519e21049de0
Author: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Date:   Thu Aug 15 14:40:20 2013 +0200

    backports: add usb_translate_errors()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/backport-include/linux/usb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index a717b7a..70d89b8 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -145,7 +145,7 @@ extern void usb_unpoison_urb(struct urb *urb);
 extern int usb_anchor_empty(struct usb_anchor *anchor);
 #endif /* 2.6.23-2.6.27 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 static inline int usb_translate_errors(int error_code)
 {
 	switch (error_code) {
-- 
1.7.10.4

