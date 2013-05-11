Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:40823 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab3EKA1s (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:48 -0400
Received: by mail-ia0-f169.google.com with SMTP id k38so3393015iah.28
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:48 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 08/12] backports: enable REGULATOR_WM8994 only on >= 3.8
Date: Fri, 10 May 2013 17:26:59 -0700
Message-Id: <1368232023-23817-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022750_168491_1F546CFF)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Compilation is failing and we need to move forward,
I can't look at this right now.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index c85577c..07fd3bf 100644
--- a/dependencies
+++ b/dependencies
@@ -101,7 +101,7 @@ REGULATOR_TPS65023 3.6
 REGULATOR_TPS6507X 3.6
 REGULATOR_TPS6524X 3.6
 REGULATOR_WM8400 3.5
-REGULATOR_WM8994 3.5
+REGULATOR_WM8994 3.8
 
 # Media
 MEDIA_SUPPORT 3.2
-- 
1.7.10.4

