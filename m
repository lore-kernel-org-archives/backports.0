Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41037 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/21] dependencies: make DVB_M88DS3103 and DVB_TS2020 depend on kernel > 3.8
Date: Sun, 14 Jun 2015 16:29:10 +0200
Message-Id: <1434292162-2261-10-git-send-email-hauke@hauke-m.de> (sfid-20150614_162946_256472_DFBCA918)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The drivers DVB_M88DS3103 and DVB_TS2020 are accessing some member in
struct regmap_config which is not available in kernel version < 3.8.
These drivers are getting selected by some other drivers, which are now
also depending on kernel >= 3.8, otherwise KConfig would ignore the
dependency on kernel >= 3.8

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/dependencies b/dependencies
index c8f174a..8692497 100644
--- a/dependencies
+++ b/dependencies
@@ -37,6 +37,16 @@ DVB_USB_RTL28XXU 3.4
 DVB_USB_RTL28XXU 3.8
 DVB_RTL2830 3.8
 DVB_RTL2832 3.8
+DVB_M88DS3103 3.8
+DVB_TS2020 3.8
+DVB_USB_DW2102 3.8
+DVB_USB_LME2510 3.8
+DVB_USB_DVBSKY 3.8
+VIDEO_EM28XX_DVB 3.8
+VIDEO_CX23885 3.8
+VIDEO_CX88_DVB 3.8
+DVB_DM1105 3.8
+DVB_SMIPCIE 3.8
 
 # missing linux/gpio/consumer.h
 # consumer.h cannot be backported currently, as functions rely
-- 
2.1.4

