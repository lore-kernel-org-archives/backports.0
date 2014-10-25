Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40656 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbaJYSpy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] dependencies: deactivate pt3 on kernel < 3.3
Date: Sat, 25 Oct 2014 11:19:25 +0200
Message-Id: <1414228770-20047-7-git-send-email-hauke@hauke-m.de> (sfid-20141025_204559_507069_A3C85514)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

pt3 needs kthread_freezable_should_stop() which is not available on
these old kernels.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 0537444..874f1a3 100644
--- a/dependencies
+++ b/dependencies
@@ -55,6 +55,9 @@ MEDIA_TUNER_IT913X 3.4
 VIDEO_CX23885 3.4
 VIDEO_EM28XX_DVB 3.4
 
+# missing kthread_freezable_should_stop()
+DVB_PT3 3.3
+
 # missing spi_finalize_current_message() and struct spi_master.transfer_one_message
 USB_MSI2500 3.4
 
-- 
1.9.1

