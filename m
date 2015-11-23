Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41644 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbbKWXLO (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/14] dependencies: make SOC_CAMERA_PLATFORM depend on kernel >= 3.9
Date: Tue, 24 Nov 2015 00:11:03 +0100
Message-Id: <1448320264-15070-14-git-send-email-hauke@hauke-m.de> (sfid-20151124_002251_807592_64890D39)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

soc camera uses the member link from the platform data struct
soc_camera_device, this member was added in kernel 3.9.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index d213fd7..4901e24 100644
--- a/dependencies
+++ b/dependencies
@@ -49,6 +49,8 @@ VIDEO_CX88_DVB 3.8
 DVB_DM1105 3.8
 DVB_SMIPCIE 3.8
 
+SOC_CAMERA_PLATFORM 3.9
+
 # missing linux/gpio/consumer.h
 # consumer.h cannot be backported currently, as functions rely
 # on in-kernel functionality (GPIO_DEVRES), we can now backport
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
