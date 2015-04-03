Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39187 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbbDCRY0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:26 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/11] copy: remove include/linux/platform_data/vsp1.h
Date: Fri,  3 Apr 2015 19:15:32 +0200
Message-Id: <1428081342-5933-2-git-send-email-hauke@hauke-m.de> (sfid-20150403_192429_940694_44A1B254)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file was removed from the kernel in commit 32d17597.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 -
 1 file changed, 1 deletion(-)

diff --git a/copy-list b/copy-list
index 295cac1..b581e26 100644
--- a/copy-list
+++ b/copy-list
@@ -157,7 +157,6 @@ include/uapi/linux/meye.h
 include/linux/hdmi.h
 
 drivers/media/
-include/linux/platform_data/vsp1.h
 include/linux/platform_data/camera-rcar.h
 include/linux/of_graph.h
 
-- 
1.9.1

