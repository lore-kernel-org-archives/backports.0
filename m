Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:61529 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab3G1BRQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 21:17:16 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so4181169pdi.2
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 18:17:16 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 5/9] backports: copy over mfd/max8998.h mfd/max8998-private.h
Date: Sat, 27 Jul 2013 18:16:26 -0700
Message-Id: <1374974190-31561-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130728_031718_211002_A52964B7)
In-Reply-To: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This is required by CONFIG_REGULATOR_MAX8998
which builds drivers/regulator/max8998.c as of
next-20130703.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/copy-list b/copy-list
index 9957811..ab8bb8b 100644
--- a/copy-list
+++ b/copy-list
@@ -141,6 +141,8 @@ include/linux/regulator/max8952.h
 include/linux/regulator/max8973-regulator.h
 include/linux/mfd/max77693.h
 include/linux/mfd/max77693-private.h
+include/linux/mfd/max8998.h
+include/linux/mfd/max8998-private.h
 include/linux/regulator/of_regulator.h
 include/linux/regulator/tps51632-regulator.h
 include/linux/regulator/tps62360.h
-- 
1.7.10.4

