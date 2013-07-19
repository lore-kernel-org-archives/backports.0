Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47779 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3GSMAu (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 08:00:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4328895pbb.5
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 05:00:49 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 8/9] backports: enable REGULATOR_MAX77693 on >= 3.6
Date: Fri, 19 Jul 2013 05:00:08 -0700
Message-Id: <1374235209-19782-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130719_140051_764058_6C5CB8B0)
In-Reply-To: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
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

