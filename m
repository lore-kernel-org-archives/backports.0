Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40655 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbaJYSpy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] dependencies: deactivate SOC_CAMERA on < 3.5
Date: Sat, 25 Oct 2014 11:19:26 +0200
Message-Id: <1414228770-20047-8-git-send-email-hauke@hauke-m.de> (sfid-20141025_204558_321910_FFBCCDBE)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Deactivate SOC_CAMERA because of missing backport for vb2_expbuf() in
kernel < 3.5.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 874f1a3..e24febf 100644
--- a/dependencies
+++ b/dependencies
@@ -61,6 +61,9 @@ DVB_PT3 3.3
 # missing spi_finalize_current_message() and struct spi_master.transfer_one_message
 USB_MSI2500 3.4
 
+# missing vb2_expbuf()
+SOC_CAMERA 3.5
+
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
 
-- 
1.9.1

