Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57986 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab3E1UdU (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 16:33:20 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: catch make in backport template directory
Date: Tue, 28 May 2013 22:33:14 +0200
Message-Id: <1369773194-17379-1-git-send-email-johannes@sipsolutions.net> (sfid-20130528_223322_300139_F4F2CD89)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Catch running make in the backport template directory by
checking for the .local-symbols file. If it isn't there
then we're in the input/template directory rather than in
an output tree, give the user a hint about it instead of
keeling over.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/Makefile b/backport/Makefile
index 287b27d..f0c7586 100644
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
+	echo "| from scratch, go into the top-level directoroy and run"			;\
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
1.8.0

