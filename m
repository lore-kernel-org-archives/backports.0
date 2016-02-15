Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51556 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbcBOPZL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/12] dependencies: make some NFC drivers depend on kernel >= 3.18
Date: Mon, 15 Feb 2016 16:24:55 +0100
Message-Id: <1455549899-14564-9-git-send-email-hauke@hauke-m.de> (sfid-20160215_184437_387597_7737ACA0)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Some NFC drivers are now using some of the device_property..()
functions which were introduced in kernel 3.18.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 7017c2c..75b3ee9 100644
--- a/dependencies
+++ b/dependencies
@@ -85,6 +85,9 @@ NFC_NXP_NCI_I2C 3.17
 
 # this needs device_property..() functions
 NFC_FDP_I2C 3.18
+NFC_ST21NFCA_I2C 3.18
+NFC_ST_NCI_I2C 3.18
+NFC_ST_NCI_SPI 3.18
 
 # missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
 VIDEO_MT9V032 3.3
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
