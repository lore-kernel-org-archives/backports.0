Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11901 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab2HNTB0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 14 Aug 2012 15:01:26 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ1Q1l014725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:26 -0400
Received: from quad.redhat.com (vpn-10-121.rdu.redhat.com [10.11.10.121])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0h1c003968
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:26 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 4/5] compat: disable compat firmware module on RHEL6.0 and later
Date: Tue, 14 Aug 2012 14:59:48 -0400
Message-Id: <1344970789-13047-5-git-send-email-andy@greyhouse.net>
In-Reply-To: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
References: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>

---
 scripts/gen-compat-config.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/scripts/gen-compat-config.sh b/scripts/gen-compat-config.sh
index c6368f3..810c51b 100755
--- a/scripts/gen-compat-config.sh
+++ b/scripts/gen-compat-config.sh
@@ -56,7 +56,9 @@ if [[ ! -z ${RHEL_MAJOR} ]]; then
 fi
 
 if [[ ${CONFIG_COMPAT_KERNEL_2_6_33} = "y" ]]; then
-	echo "export CONFIG_COMPAT_FIRMWARE_CLASS=m"
+	if [[ ! ${CONFIG_COMPAT_RHEL_6_0} = "y" ]]; then
+		echo "export CONFIG_COMPAT_FIRMWARE_CLASS=m"
+	fi
 fi
 
 if [[ ${CONFIG_COMPAT_KERNEL_2_6_36} = "y" ]]; then
-- 
1.7.1

