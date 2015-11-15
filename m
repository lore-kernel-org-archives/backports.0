Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35548 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbbKOP5L (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/15] copy: add new file include/trace/events/vb2.h
Date: Sun, 15 Nov 2015 16:56:45 +0100
Message-Id: <1447603019-11862-2-git-send-email-hauke@hauke-m.de> (sfid-20151115_165712_293166_7222CA84)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index a35ae95..7a6410f 100644
--- a/copy-list
+++ b/copy-list
@@ -164,6 +164,7 @@ include/uapi/linux/v4l2-subdev.h
 include/uapi/linux/videodev2.h
 include/uapi/linux/vsp1.h
 include/trace/events/v4l2.h
+include/trace/events/vb2.h
 drivers/staging/media/cxd2099/cxd2099.h
 include/uapi/linux/ivtv.h
 include/uapi/linux/meye.h
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
