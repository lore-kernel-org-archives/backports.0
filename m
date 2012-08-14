Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab2HNTBU (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 14 Aug 2012 15:01:20 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ1KLQ025622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:20 -0400
Received: from quad.redhat.com (vpn-10-121.rdu.redhat.com [10.11.10.121])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0h1a003968
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:20 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 2/5] compat: fix defines for RHEL by adding RHEL to string
Date: Tue, 14 Aug 2012 14:59:46 -0400
Message-Id: <1344970789-13047-3-git-send-email-andy@greyhouse.net>
In-Reply-To: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
References: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The .config file contains 'CONFIG_COMPAT_6_1,' when it should contain,
'CONFIG_COMPAT_RHEL_6_1.'  This fixes that by adding the 'RHEL' in the
proper spot.

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>

---
 scripts/gen-compat-config.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gen-compat-config.sh b/scripts/gen-compat-config.sh
index a3ebf08..54f053d 100755
--- a/scripts/gen-compat-config.sh
+++ b/scripts/gen-compat-config.sh
@@ -50,8 +50,8 @@ RHEL_MAJOR=$(grep ^RHEL_MAJOR ${KLIB_BUILD}/Makefile | sed -n 's/.*= *\(.*\)/\1/
 if [[ ! -z ${RHEL_MAJOR} ]]; then
 	RHEL_MINOR=$(grep ^RHEL_MINOR ${KLIB_BUILD}/Makefile | sed -n 's/.*= *\(.*\)/\1/p')
 	for i in $(seq 0 ${RHEL_MINOR}); do
-		eval CONFIG_COMPAT_${RHEL_MAJOR}_${i}=y
-		echo "export CONFIG_COMPAT_${RHEL_MAJOR}_${i}=y"
+		eval CONFIG_COMPAT_RHEL_${RHEL_MAJOR}_${i}=y
+		echo "export CONFIG_COMPAT_RHEL_${RHEL_MAJOR}_${i}=y"
 	done
 fi
 
-- 
1.7.1

