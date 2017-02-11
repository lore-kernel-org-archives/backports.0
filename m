Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:55491 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751093AbdBKXPY (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 11 Feb 2017 18:15:24 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backports: add "MBIM Extended Functional Descriptor" structure definition
Date: Sat, 11 Feb 2017 23:14:59 +0000
Message-Id: <1486854899-13118-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170212_001555_428221_3909FA4D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

commit 477c6d345604 ("backports: add USB_CDC_MBIM_EXTENDED_TYPE if needed")
added define but the structure definition that goes with it is also needed.
As they were introduced in the same kernel version we can add the structure
with the same #ifndef USB_CDC_MBIM_EXTENDED_TYPE.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/usb/cdc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/usb/cdc.h b/backport/backport-include/linux/usb/cdc.h
index 2097949..5ad31bf 100644
--- a/backport/backport-include/linux/usb/cdc.h
+++ b/backport/backport-include/linux/usb/cdc.h
@@ -15,6 +15,17 @@
 
 #ifndef USB_CDC_MBIM_EXTENDED_TYPE
 #define USB_CDC_MBIM_EXTENDED_TYPE 0x1c
+
+/* "MBIM Extended Functional Descriptor" from CDC MBIM spec 1.0 errata-1 */
+struct usb_cdc_mbim_extended_desc {
+	__u8	bLength;
+	__u8	bDescriptorType;
+	__u8	bDescriptorSubType;
+
+	__le16	bcdMBIMExtendedVersion;
+	__u8	bMaxOutstandingCommandMessages;
+	__le16	wMTU;
+} __attribute__ ((packed));
 #endif
 
 /*
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
