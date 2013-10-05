Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49577 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213Ab3JENYp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:24:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] backports: copy include/drm/drm_flip_work.h
Date: Sat,  5 Oct 2013 15:23:50 +0200
Message-Id: <1380979435-5430-4-git-send-email-hauke@hauke-m.de> (sfid-20131005_152447_061672_A2EE1736)
In-Reply-To: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
References: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file was newly added to drm.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 2fadde8..8f5116a 100644
--- a/copy-list
+++ b/copy-list
@@ -125,6 +125,7 @@ include/drm/drm_crtc_helper.h
 include/drm/drm_dp_helper.h
 include/drm/drm_edid.h
 include/drm/drm_encoder_slave.h
+include/drm/drm_flip_work.h
 include/drm/drm_fb_cma_helper.h
 include/drm/drm_fb_helper.h
 include/drm/drm_fixed.h
-- 
1.7.10.4

