Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56143 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757207AbcGJVO6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/19] copy-list: add media/tvp5150.h header file
Date: Sun, 10 Jul 2016 23:14:28 +0200
Message-Id: <1468185285-28265-3-git-send-email-hauke@hauke-m.de> (sfid-20160710_231500_580489_8D866C82)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This header file is now used by some driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/copy-list b/copy-list
index f4740f6..48b26ca 100644
--- a/copy-list
+++ b/copy-list
@@ -150,6 +150,8 @@ drivers/staging/media/cxd2099/cxd2099.h
 include/uapi/linux/ivtv.h
 include/uapi/linux/meye.h
 
+include/dt-bindings/media/tvp5150.h
+
 drivers/media/
 include/linux/platform_data/media/gpio-ir-recv.h
 include/linux/of_graph.h
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
