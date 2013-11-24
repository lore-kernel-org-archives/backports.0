Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48308 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab3KXVYT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:24:19 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/15] backports: remove usb_unlink_anchored_urbs()
Date: Sun, 24 Nov 2013 22:23:15 +0100
Message-Id: <1385328198-28520-13-git-send-email-hauke@hauke-m.de> (sfid-20131124_223808_108249_7A5C2379)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

kref_get_unless_zero() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb.h |    2 --
 backport/compat/compat-2.6.36.c       |   23 -----------------------
 2 files changed, 25 deletions(-)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 70d89b8..a5c2f2b 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -57,9 +57,7 @@
 #ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
 #define usb_scuttle_anchored_urbs LINUX_BACKPORT(usb_scuttle_anchored_urbs)
 #define usb_get_from_anchor LINUX_BACKPORT(usb_get_from_anchor)
-#define usb_unlink_anchored_urbs LINUX_BACKPORT(usb_unlink_anchored_urbs)
 
-extern void usb_unlink_anchored_urbs(struct usb_anchor *anchor);
 extern struct urb *usb_get_from_anchor(struct usb_anchor *anchor);
 extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
 #endif
diff --git a/backport/compat/compat-2.6.36.c b/backport/compat/compat-2.6.36.c
index ea6443d..331e991 100644
--- a/backport/compat/compat-2.6.36.c
+++ b/backport/compat/compat-2.6.36.c
@@ -23,29 +23,6 @@ static void __usb_unanchor_urb(struct urb *urb, struct usb_anchor *anchor)
 }
 
 /**
- * usb_unlink_anchored_urbs - asynchronously cancel transfer requests en masse
- * @anchor: anchor the requests are bound to
- *
- * this allows all outstanding URBs to be unlinked starting
- * from the back of the queue. This function is asynchronous.
- * The unlinking is just tiggered. It may happen after this
- * function has returned.
- *
- * This routine should not be called by a driver after its disconnect
- * method has returned.
- */
-void usb_unlink_anchored_urbs(struct usb_anchor *anchor)
-{
-	struct urb *victim;
-
-	while ((victim = usb_get_from_anchor(anchor)) != NULL) {
-		usb_unlink_urb(victim);
-		usb_put_urb(victim);
-	}
-}
-EXPORT_SYMBOL_GPL(usb_unlink_anchored_urbs);
-
-/**
  * usb_get_from_anchor - get an anchor's oldest urb
  * @anchor: the anchor whose urb you want
  *
-- 
1.7.10.4

