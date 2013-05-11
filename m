Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:40290 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab3EKAdw (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:33:52 -0400
Received: by mail-ia0-f182.google.com with SMTP id j5so3127729iaf.13
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:33:52 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 1/5] backports: backport rfkill now for < v3.10
Date: Fri, 10 May 2013 17:33:37 -0700
Message-Id: <1368232421-24123-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_023354_423707_2302CEC1)
In-Reply-To: <1368232421-24123-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232421-24123-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We want to backport rfkill now for < v3.10 to enable
NFC rfkill support. This is required as of next-20130423.

commit 44b3decb414919760c7327df05e63372c1bf5d9a
Author: Samuel Ortiz <sameo@linux.intel.com>
Date:   Thu Apr 11 11:51:36 2013 +0200

    rfkill: Add NFC to the list of supported radios

    And return the proper string for it.

    Acked-by: Johannes Berg <johannes@sipsolutions.net>
    Acked-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/rfkill.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index 01d18f1..3869bbf 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -2,10 +2,8 @@
 #define __COMPAT_RFKILL_H
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
-#include_next <linux/rfkill.h>
-#else
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(3,10,0))
+
 #define rfkill_get_led_trigger_name LINUX_BACKPORT(rfkill_get_led_trigger_name)
 #define rfkill_set_led_trigger_name LINUX_BACKPORT(rfkill_set_led_trigger_name)
 #define rfkill_set_hw_state LINUX_BACKPORT(rfkill_set_hw_state)
@@ -19,8 +17,11 @@
 #define rfkill_register LINUX_BACKPORT(rfkill_register)
 #define rfkill_unregister LINUX_BACKPORT(rfkill_unregister)
 #define rfkill_destroy LINUX_BACKPORT(rfkill_destroy)
-#endif
+
 #include <linux/rfkill_backport.h>
+
+#else
+#include_next <linux/rfkill.h>
 #endif
 
 #endif
-- 
1.7.10.4

