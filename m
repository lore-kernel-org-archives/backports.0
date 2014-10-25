Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40654 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbaJYSpy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] dependencies: deactivate tracing in ath10k and ath with < 3.4
Date: Sat, 25 Oct 2014 11:19:23 +0200
Message-Id: <1414228770-20047-5-git-send-email-hauke@hauke-m.de> (sfid-20141025_204558_915655_8DC12F96)
In-Reply-To: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
References: <1414228770-20047-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On kernel < 3.4 compiling ath10k with tracing results in huge compile
errors. Just deactivate it till someone fixes the problems. The same
compile error occurs in ath module with kernel 3.0.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dependencies b/dependencies
index 86f1931..327c115 100644
--- a/dependencies
+++ b/dependencies
@@ -80,3 +80,7 @@ IEEE802154_AT86RF230 3.4
 IEEE802154_CC2520 3.5
 
 IR_IMG 3.5
+
+# tracing results in compile errors
+ATH10K_TRACING 3.4
+ATH_TRACEPOINTS 3.1
-- 
1.9.1

