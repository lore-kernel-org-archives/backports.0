Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46456 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3GSWPt (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 18:15:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4929347pbb.33
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 15:15:49 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 06/10] backports: copy the max77693-private.h header file
Date: Fri, 19 Jul 2013 15:13:25 -0700
Message-Id: <1374272009-26152-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130720_001551_236485_36492368)
In-Reply-To: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 5d7acd9..9c7be4a 100644
--- a/copy-list
+++ b/copy-list
@@ -139,6 +139,7 @@ include/linux/regulator/max8649.h
 include/linux/regulator/max8660.h
 include/linux/regulator/max8952.h
 include/linux/regulator/max8973-regulator.h
+include/linux/mfd/max77693-private.h
 include/linux/regulator/of_regulator.h
 include/linux/regulator/tps51632-regulator.h
 include/linux/regulator/tps62360.h
-- 
1.7.10.4

