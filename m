Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41646 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806AbbKWXLM (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/14] copy: add new header files for media devices
Date: Tue, 24 Nov 2015 00:10:55 +0100
Message-Id: <1448320264-15070-6-git-send-email-hauke@hauke-m.de> (sfid-20151124_001115_821904_22E9839A)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The media includes were reorganized, we have to include more files now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/copy-list b/copy-list
index c3c487c..0c77d99 100644
--- a/copy-list
+++ b/copy-list
@@ -169,7 +169,10 @@ include/uapi/linux/ivtv.h
 include/uapi/linux/meye.h
 
 drivers/media/
+include/linux/platform_data/media/gpio-ir-recv.h
 include/linux/of_graph.h
+include/uapi/linux/lirc.h
+include/uapi/linux/usb/video.h
 
 include/net/6lowpan.h
 include/net/cfg802154.h
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
