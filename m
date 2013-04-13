Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44250 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3DMXz3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:29 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 37/42] backports: fix USB PM in case of !CONFIG_USB_SUSPEND
Date: Sun, 14 Apr 2013 01:53:57 +0200
Message-Id: <1365897243-31214-38-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015641_291586_E4D133C9)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Even in this case, the variable is an int on old kernels.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/usb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 3821575..8ea9d75 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -83,11 +83,19 @@ extern void usb_autopm_put_interface_no_suspend(struct usb_interface *intf);
 #else
 static inline void usb_autopm_get_interface_no_resume(struct usb_interface *intf)
 {
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 	atomic_inc(&intf->pm_usage_cnt);
+#else
+	intf->pm_usage_cnt++;
+#endif
 }
 static inline void usb_autopm_put_interface_no_suspend(struct usb_interface *intf)
 {
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 	atomic_dec(&intf->pm_usage_cnt);
+#else
+	intf->pm_usage_cnt--;
+#endif
 }
 #endif /* CONFIG_USB_SUSPEND */
 #endif /* < 2.6.33 */
-- 
1.8.0

