Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62171 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab3G3J06 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:58 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so5806397pbc.1
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:57 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 12/14] backports: copy over s2mps11.h
Date: Tue, 30 Jul 2013 02:25:57 -0700
Message-Id: <1375176359-1331-13-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112705_196211_D06F74A9)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This is required by s2mps11 as of at least next-20130709.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index ab8bb8b..aaf5ae9 100644
--- a/copy-list
+++ b/copy-list
@@ -143,6 +143,7 @@ include/linux/mfd/max77693.h
 include/linux/mfd/max77693-private.h
 include/linux/mfd/max8998.h
 include/linux/mfd/max8998-private.h
+include/linux/mfd/samsung/s2mps11.h
 include/linux/regulator/of_regulator.h
 include/linux/regulator/tps51632-regulator.h
 include/linux/regulator/tps62360.h
-- 
1.7.10.4

