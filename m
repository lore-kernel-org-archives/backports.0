Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:47385 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBfT (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:35:19 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so6114281pbb.3
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:35:18 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 08/10] backports: bump bluetooth reqs to 3.2
Date: Fri, 11 Apr 2014 18:34:33 -0700
Message-Id: <1397266475-14442-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033520_593996_4468DCA6)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

As a prep to bump general requirements lets bump bluetooth
minimum kernel requirements to at least 3.2.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/dependencies b/dependencies
index 36c0b87..c5f727d 100644
--- a/dependencies
+++ b/dependencies
@@ -3,10 +3,12 @@
 
 # platform_get_device_id()
 ATH9K_AHB 2.6.30
-BT 2.6.27
-BT_RFCOMM_TTY 2.6.33
-BT_HIDP 2.6.28
-BT_WILINK 2.6.39
+
+BT 3.2
+BT_RFCOMM_TTY 3.2
+BT_HIDP 3.2
+BT_WILINK 3.2
+BT_HIDP 3.2
 
 MAC80211_HWSIM 2.6.31
 
@@ -29,7 +31,6 @@ USB_NET_RNDIS_WLAN 2.6.29
 
 CARL9170 2.6.29
 
-
 # depends on -EPROBE_DEFER and others now
 WL1251_SPI 3.5
 
@@ -197,9 +198,6 @@ DVB_USB_RTL28XXU DISABLE
 BCMA_DRIVER_GPIO 2.6.28
 SSB_DRIVER_GPIO 2.6.28
 
-# shash was only added in 2.6.29
-BT 2.6.29
-
 # GPIOF_OUT_INIT_HIGH definitions were only moved
 # out of #ifdef in kernel 3.0. These are required
 # by some users of BCMA_DRIVER_GPIO. We'd better
@@ -231,12 +229,6 @@ REGULATOR_AB3100 3.9
 # only introduced in kernel 2.6.30.
 BRCMDBG 2.6.30
 
-# HID_QUIRK_NO_INIT_REPORTS was only introduced in
-# kernel 2.6.33, so depend on that. We could instead
-# backport it, but I can't test that and this is a
-# lot easier right now.
-BT_HIDP 2.6.33
-
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
 NFC 3.1
-- 
1.9.1

