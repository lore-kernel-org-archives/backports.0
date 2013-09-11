Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40683 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182Ab3IKMML (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:11 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/11] backports: add include/drm/drm_agpsupport.h
Date: Wed, 11 Sep 2013 14:11:45 +0200
Message-Id: <1378901515-14206-2-git-send-email-hauke@hauke-m.de> (sfid-20130911_141214_040184_92E85C69)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the missing file include/drm/drm_agpsupport.h

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 1f9f78a..2fadde8 100644
--- a/copy-list
+++ b/copy-list
@@ -116,6 +116,7 @@ drivers/net/usb/sierra_net.c
 drivers/net/usb/qmi_wwan.c
 
 # DRM
+include/drm/drm_agpsupport.h
 include/drm/drm_buffer.h
 include/drm/drm_cache.h
 include/drm/drm_core.h
-- 
1.7.10.4

