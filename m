Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49148 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdJMJmc (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:32 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 01/11] backports: move headers to be clearer
Date: Fri, 13 Oct 2017 11:42:16 +0200
Message-Id: <20171013094226.10021-1-johannes@sipsolutions.net> (sfid-20171013_114233_967075_8A3E310A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Those uapi header files are always needed, so don't mark them as
being for wwan drivers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 copy-list | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/copy-list b/copy-list
index 678ebe2f59fc..11fd3455d611 100644
--- a/copy-list
+++ b/copy-list
@@ -39,6 +39,10 @@ include/linux/rndis.h
 include/linux/bcm47xx_wdt.h
 include/linux/usb/usbnet.h
 include/linux/usb/cdc.h
+include/uapi/linux/usb/cdc.h
+include/uapi/linux/usb/cdc-wdm.h
+include/linux/usb/cdc_ncm.h
+include/linux/usb/cdc-wdm.h
 include/linux/usb/rndis_host.h
 include/linux/spi/libertas_spi.h
 include/linux/platform_data/brcmfmac.h
@@ -92,13 +96,6 @@ drivers/net/usb/rndis_host.c
 drivers/net/usb/cdc_ether.c
 drivers/net/usb/usbnet.c
 
-
-# wwan drivers
-include/uapi/linux/usb/cdc.h
-include/uapi/linux/usb/cdc-wdm.h
-include/linux/usb/cdc_ncm.h
-include/linux/usb/cdc-wdm.h
-
 drivers/usb/class/Makefile
 drivers/usb/class/Kconfig
 drivers/usb/class/cdc-wdm.c
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
