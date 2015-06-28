Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48710 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/14] dependencies: build VIDEO_FB_IVTV only on kernel >= 4.2
Date: Sun, 28 Jun 2015 23:59:17 +0200
Message-Id: <1435528760-19913-12-git-send-email-hauke@hauke-m.de> (sfid-20150629_000350_830218_C1126330)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

VIDEO_FB_IVTV uses arch_phys_wc_add(), arch_phys_wc_del() and
pat_enabled() now which are not available in older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index e1bd663..54afee2 100644
--- a/dependencies
+++ b/dependencies
@@ -110,6 +110,9 @@ MEDIA_TUNER_IT913X 3.4
 VIDEO_CX23885 3.4
 VIDEO_EM28XX_DVB 3.4
 
+# this needs arch_phys_wc_add(), arch_phys_wc_del() and pat_enabled()
+VIDEO_FB_IVTV 4.2
+
 # missing kthread_freezable_should_stop()
 DVB_PT3 3.3
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
