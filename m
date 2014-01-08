Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46688 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAez (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:34:55 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/17] backports: add include/trace/events/v4l2.h file
Date: Wed,  8 Jan 2014 01:34:21 +0100
Message-Id: <1389141274-2002-5-git-send-email-hauke@hauke-m.de> (sfid-20140108_013457_048359_7230C532)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

v4l2 now supports tracing and needs a new header file that was missing.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 9444aff..2a4d56b 100644
--- a/copy-list
+++ b/copy-list
@@ -167,6 +167,7 @@ include/uapi/linux/v4l2-dv-timings.h
 include/uapi/linux/v4l2-mediabus.h
 include/uapi/linux/v4l2-subdev.h
 include/uapi/linux/videodev2.h
+include/trace/events/v4l2.h
 
 drivers/media/
 include/linux/platform_data/vsp1.h
-- 
1.7.10.4

