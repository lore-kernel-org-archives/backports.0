Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44972 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3GSWQF (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 18:16:05 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4900184pbb.19
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 15:16:04 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 09/10] backports: enable REGULATOR_MAX77693 on >= 3.6
Date: Fri, 19 Jul 2013 15:13:28 -0700
Message-Id: <1374272009-26152-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20130720_001607_516693_A372A484)
In-Reply-To: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

There is a symbol missing otherwise that is currently
only provided by the core, ie, non modular.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list    |    1 +
 dependencies |    1 +
 2 files changed, 2 insertions(+)

diff --git a/copy-list b/copy-list
index 9c7be4a..9957811 100644
--- a/copy-list
+++ b/copy-list
@@ -139,6 +139,7 @@ include/linux/regulator/max8649.h
 include/linux/regulator/max8660.h
 include/linux/regulator/max8952.h
 include/linux/regulator/max8973-regulator.h
+include/linux/mfd/max77693.h
 include/linux/mfd/max77693-private.h
 include/linux/regulator/of_regulator.h
 include/linux/regulator/tps51632-regulator.h
diff --git a/dependencies b/dependencies
index e226b7a..6841613 100644
--- a/dependencies
+++ b/dependencies
@@ -64,6 +64,7 @@ REGULATOR 3.4
 # requires some work
 REGULATOR_ARIZONA DISABLE
 REGULATOR_MAX8973 DISABLE
+REGULATOR_MAX77693 3.6
 REGULATOR_MAX77686 DISABLE
 REGULATOR_MAX8997 DISABLE
 REGULATOR_RC5T583 DISABLE
-- 
1.7.10.4

