Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46739 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754296AbaAHAff (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/17] backports: copy include/uapi/linux/vsp1.h
Date: Wed,  8 Jan 2014 01:34:31 +0100
Message-Id: <1389141274-2002-15-git-send-email-hauke@hauke-m.de> (sfid-20140108_013538_314325_58734CA2)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This header file is now needed by a media driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 2b01efb..9ec4f4b 100644
--- a/copy-list
+++ b/copy-list
@@ -167,6 +167,7 @@ include/uapi/linux/v4l2-dv-timings.h
 include/uapi/linux/v4l2-mediabus.h
 include/uapi/linux/v4l2-subdev.h
 include/uapi/linux/videodev2.h
+include/uapi/linux/vsp1.h
 include/trace/events/v4l2.h
 
 drivers/media/
-- 
1.7.10.4

