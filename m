Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49180 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757764AbdJMJme (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:34 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 09/11] backports: RSI_SDIO depends on 3.13
Date: Fri, 13 Oct 2017 11:42:24 +0200
Message-Id: <20171013094226.10021-9-johannes@sipsolutions.net> (sfid-20171013_114237_366341_8DF6FDDB)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 220ccf47232e..2741cbeba5af 100644
--- a/dependencies
+++ b/dependencies
@@ -159,3 +159,6 @@ NFC_WILINK 4.8
 # struct ethtool_link_ksettings is missing, I'm lazy
 USB_USBNET 4.6
 USB_NET_RNDIS_WLAN 4.6
+
+# depends on struct mmc_card::ocr
+RSI_SDIO 3.13
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
