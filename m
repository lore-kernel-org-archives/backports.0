Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6607 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab2HNTAz (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 14 Aug 2012 15:00:55 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0ssA016320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:00:54 -0400
Received: from quad.redhat.com (vpn-10-121.rdu.redhat.com [10.11.10.121])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0h1Z003968
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:00:54 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 1/5] compat: RHEL build script fixup from upstream
Date: Tue, 14 Aug 2012 14:59:45 -0400
Message-Id: <1344970789-13047-2-git-send-email-andy@greyhouse.net>
In-Reply-To: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
References: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There are parentheses where there should be curly braces.  This is a
patch that Phillip Perry posted to the list, but it was never
integrated.

Signed-off-by: Philip J Perry <phil@elrepo.org>
Signed-off-by: Andy Gospodarek <andy@greyhouse.net>

---
 scripts/gen-compat-config.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/gen-compat-config.sh b/scripts/gen-compat-config.sh
index b70ef03..a3ebf08 100755
--- a/scripts/gen-compat-config.sh
+++ b/scripts/gen-compat-config.sh
@@ -48,7 +48,7 @@ done
 # The RHEL checks seem to annotate the existance of RHEL minor versions.
 RHEL_MAJOR=$(grep ^RHEL_MAJOR ${KLIB_BUILD}/Makefile | sed -n 's/.*= *\(.*\)/\1/p')
 if [[ ! -z ${RHEL_MAJOR} ]]; then
-	RHEL_MINOR=$(grep ^RHEL_MINOR $(KLIB_BUILD)/Makefile | sed -n 's/.*= *\(.*\)/\1/p')
+	RHEL_MINOR=$(grep ^RHEL_MINOR ${KLIB_BUILD}/Makefile | sed -n 's/.*= *\(.*\)/\1/p')
 	for i in $(seq 0 ${RHEL_MINOR}); do
 		eval CONFIG_COMPAT_${RHEL_MAJOR}_${i}=y
 		echo "export CONFIG_COMPAT_${RHEL_MAJOR}_${i}=y"
-- 
1.7.1

