Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45491 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDdD (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:33:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so398925pab.32
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:33:02 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 07/12] backports: bump kernel requirements for drivers that use s2mps14.h
Date: Mon,  7 Apr 2014 20:32:18 -0700
Message-Id: <1396927943-25589-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053305_794944_6C19DAEE)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These depend on include/linux/mfd/samsung/s2mps14.h which
other mfd drivers / platform code can depend on, skip
unless we backport all the dependencies which we don't
right now.

The affected drivers are:

  * REGULATOR_S2MPS11
  * REGULATOR_S2MPA01
  * REGULATOR_TPS65217

The mfd files which we don't backport that uses this are:

  * drivers/mfd/sec-core.c
  * drivers/mfd/sec-irq.c

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index f5f7229..6193ed1 100644
--- a/dependencies
+++ b/dependencies
@@ -96,7 +96,14 @@ REGULATOR_PCAP 3.6
 REGULATOR_PCF50633 3.8
 REGULATOR_PFUZE100 3.6
 REGULATOR_RC5T583 3.6
-REGULATOR_S2MPS11 3.13
+
+# These depend on include/linux/mfd/samsung/s2mps14.h which
+# other mfd drivers / platform code can depend on, skip
+# unless we backport all the dependencies which we don't
+# right now.
+REGULATOR_S2MPS11 3.15
+REGULATOR_S2MPA01 3.15
+
 REGULATOR_S5M8767 3.15
 REGULATOR_TPS51632 3.8
 REGULATOR_TPS6105X 3.6
@@ -105,7 +112,9 @@ REGULATOR_TPS62360 3.6
 REGULATOR_TPS65023 3.9
 REGULATOR_TPS6507X 3.6
 REGULATOR_TPS65090 3.9
-REGULATOR_TPS65217 3.12
+# depnds on include/linux/mfd/samsung/s2mps14.h which
+# other mfd drivers / platform code can depend on, skip
+REGULATOR_TPS65217 3.15
 REGULATOR_TPS6524X 3.6
 REGULATOR_TPS6586X 3.14
 REGULATOR_TPS65910 3.14
-- 
1.8.5.3

