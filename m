Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41644 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbbKWXLM (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/14] copy: remove camera-rcar.h
Date: Tue, 24 Nov 2015 00:10:54 +0100
Message-Id: <1448320264-15070-5-git-send-email-hauke@hauke-m.de> (sfid-20151124_001115_244306_0AB0DEE5)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file was removed in upstream kernel commit 22bc8625 "[media]
rcar_vin: Remove obsolete platform data support"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 -
 1 file changed, 1 deletion(-)

diff --git a/copy-list b/copy-list
index 0b26aa3..c3c487c 100644
--- a/copy-list
+++ b/copy-list
@@ -169,7 +169,6 @@ include/uapi/linux/ivtv.h
 include/uapi/linux/meye.h
 
 drivers/media/
-include/linux/platform_data/camera-rcar.h
 include/linux/of_graph.h
 
 include/net/6lowpan.h
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
