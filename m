Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:46915 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161185Ab3DGCWJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:22:09 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so2627516pab.24
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:22:08 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/9] backports: enable DRM_NOUVEAU for 3.2
Date: Sat,  6 Apr 2013 19:21:54 -0700
Message-Id: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042213_580528_7ABC419E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies |    1 -
 1 file changed, 1 deletion(-)

diff --git a/dependencies b/dependencies
index 7c79449..d001a38 100644
--- a/dependencies
+++ b/dependencies
@@ -45,7 +45,6 @@ MWIFIEX 2.6.27
 HDMI 3.2
 DRM 3.2
 DRM_TTM 3.2
-DRM_NOUVEAU 3.3
 
 # This requires proc_create(), and that doesn't exist before 2.6.24
 LIBIPW_DEBUG 2.6.25
-- 
1.7.10.4

