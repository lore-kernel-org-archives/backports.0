Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37043 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab3G3J0S (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:18 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so5744352pbc.25
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:17 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 03/14] backports: fix DMI_EXACT_MATCH() backport
Date: Tue, 30 Jul 2013 02:25:48 -0700
Message-Id: <1375176359-1331-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112620_016447_9005B52A)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

DMI_EXACT_MATCH uses struct dmi_strmatch's new member exact_match:

	@@ -456,7 +456,8 @@ enum dmi_field {
	 };

	 struct dmi_strmatch {
	-       unsigned char slot;
	+       unsigned char slot:7;
	+       unsigned char exact_match:1;
		char substr[79];
	 };

Prior to 5017b285 we only had slot so to use DMI_EXACT_MATCH with its
intent we'd have to do something like slot |= 1 if its called. This
however assumes though that older code has the sanity check as changed
in 5017b285 on drivers/firmware/dmi_scan.c. dmi_scan.o gets linked
with CONFIG_DMI. At least for x86 that gets objects sprinkled on
arch/x86/, but more importantly CONFIG_DMI is bool. I've argued how I
envision us being able to backport core components before (see
0935deab for the hint) but as it is right now we can't. We only
backport things we can throw in as modular.

Since we only backport modularly for now we can't backport DMI_EXACT_MATCH()
and as such all entries defined with DMI_EXACT_MATCH() should be ifdef'd
out for usage only on kernels >= v3.11 but to help reduce code churn we
can also just force such entries to be ignored for now. We therefore
backport DMI_EXACT_MATCH() for now to match something that will not be
found.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/mod_devicetable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index 5b63637..c09793b 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -3,7 +3,7 @@
 #include_next <linux/mod_devicetable.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
-#define DMI_EXACT_MATCH(a, b)  { a, b }
+#define DMI_EXACT_MATCH(a, b)  DMI_MATCH(DMI_PRODUCT_NAME, "BACKPORT_IGNORE")
 #endif
 
 #ifndef HID_BUS_ANY
-- 
1.7.10.4

