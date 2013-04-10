Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:41643 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890Ab3DJLfj (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:35:39 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so175700dan.33
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:35:38 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 01/18] backports: enable DRM_NOUVEAU for 3.2
Date: Wed, 10 Apr 2013 04:35:11 -0700
Message-Id: <1365593728-5720-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133543_521810_C2227A1E)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies |    1 -
 1 file changed, 1 deletion(-)

diff --git a/dependencies b/dependencies
index e9aaa2e..44e23da 100644
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

