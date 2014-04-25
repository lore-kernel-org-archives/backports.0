Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbaDYHPG (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Apr 2014 03:15:06 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 2/3] backports: add linux/of_graph.h to copy-list
Date: Fri, 25 Apr 2014 09:14:29 +0200
Message-Id: <1398410070-30529-3-git-send-email-sassmann@kpanic.de> (sfid-20140425_091508_302586_99BF0FBB)
In-Reply-To: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
References: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Required by CONFIG_VIDEO_ADV7343 and others.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 2794c0c..76c07cb 100644
--- a/copy-list
+++ b/copy-list
@@ -178,6 +178,7 @@ include/trace/events/v4l2.h
 drivers/media/
 include/linux/platform_data/vsp1.h
 include/linux/platform_data/camera-rcar.h
+include/linux/of_graph.h
 
 include/net/6lowpan.h
 include/net/netns/ieee802154_6lowpan.h
-- 
1.9.0

