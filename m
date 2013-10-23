Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35342 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660Ab3JWS1x (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:27:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: add platform driver for media drivers
Date: Wed, 23 Oct 2013 20:27:30 +0200
Message-Id: <1382552852-15916-4-git-send-email-hauke@hauke-m.de> (sfid-20131023_202755_096797_2800CB9B)
In-Reply-To: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/copy-list b/copy-list
index 6035e36..5b9ad1e 100644
--- a/copy-list
+++ b/copy-list
@@ -170,6 +170,8 @@ include/uapi/linux/v4l2-subdev.h
 include/uapi/linux/videodev2.h
 
 drivers/media/
+include/linux/platform_data/vsp1.h
+include/linux/platform_data/camera-rcar.h
 
 include/net/nl802154.h
 include/net/mac802154.h
-- 
1.7.10.4

