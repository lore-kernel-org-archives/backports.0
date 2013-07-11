Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44188 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab3GKWM3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/19] backports: catch make in backport template directory
Date: Fri, 12 Jul 2013 00:11:29 +0200
Message-Id: <1373580702-24752-8-git-send-email-hauke@hauke-m.de> (sfid-20130712_001236_482728_3B6E3CF3)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Upstream commit a029928078ce7708c4cd54a6b9f1fc0212fc3395

Catch running make in the backport template directory by
checking for the .local-symbols file. If it isn't there
then we're in the input/template directory rather than in
an output tree, give the user a hint about it instead of
keeling over.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Makefile |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/Makefile b/backport/Makefile
index 287b27d..421a4f6 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -37,6 +37,18 @@ mrproper:
 	@rm -f backport-include/backport/autoconf.h
 
 .DEFAULT:
+	@set -e ; test -f .local-symbols || (						\
+	echo "/--------------"								;\
+	echo "| You shouldn't run make in the backports tree, but only in"		;\
+	echo "| the generated output. This here is only the skeleton code"		;\
+	echo "| copied into the output directory. To use the backport system"		;\
+	echo "| from scratch, go into the top-level directory and run"			;\
+	echo "|	./gentree.py /path/to/linux-next/ /tmp/output"				;\
+	echo "| and then make menuconfig/... in the output directory. See"		;\
+	echo "|	./gentree.py --help"							;\
+	echo "| for more options."							;\
+	echo "\\--"									;\
+	false)
 	@set -e ; test -f $(KERNEL_CONFIG) || (						\
 	echo "/--------------"								;\
 	echo "| Your kernel headers are incomplete/not installed."			;\
-- 
1.7.10.4

