Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31144 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab2HNTBX (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 14 Aug 2012 15:01:23 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ1NPa024334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:23 -0400
Received: from quad.redhat.com (vpn-10-121.rdu.redhat.com [10.11.10.121])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0h1b003968
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:23 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 3/5] compat: disable KFIFO on RHEL6.1 and later
Date: Tue, 14 Aug 2012 14:59:47 -0400
Message-Id: <1344970789-13047-4-git-send-email-andy@greyhouse.net>
In-Reply-To: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
References: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>

---
 scripts/gen-compat-config.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/scripts/gen-compat-config.sh b/scripts/gen-compat-config.sh
index 54f053d..c6368f3 100755
--- a/scripts/gen-compat-config.sh
+++ b/scripts/gen-compat-config.sh
@@ -60,7 +60,9 @@ if [[ ${CONFIG_COMPAT_KERNEL_2_6_33} = "y" ]]; then
 fi
 
 if [[ ${CONFIG_COMPAT_KERNEL_2_6_36} = "y" ]]; then
-	echo "export CONFIG_COMPAT_KFIFO=y"
+	if [[ ! ${CONFIG_COMPAT_RHEL_6_1} = "y" ]]; then
+		echo "export CONFIG_COMPAT_KFIFO=y"
+	fi
 fi
 
 if [[ ${CONFIG_COMPAT_KERNEL_3_5} = "y" ]]; then
-- 
1.7.1

