Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB4C43219
	for <backports@archiver.kernel.org>; Wed, 24 Nov 2021 06:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhKXGDn (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:03:43 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:56658 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhKXGDm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 01:03:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9ECCD744D6D;
        Wed, 24 Nov 2021 05:55:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id KiPF9L0XKEgo; Wed, 24 Nov 2021 05:55:13 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id CD5CA744D6F;
        Wed, 24 Nov 2021 05:55:07 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 5/7] lib/bpversion: calculate Kconfig.versions for next major version
Date:   Tue, 23 Nov 2021 21:55:03 -0800
Message-Id: <20211124055505.1267128-6-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124055505.1267128-1-thomas@adapt-ip.com>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 lib/bpversion.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bpversion.py b/lib/bpversion.py
index aefdcf0ce3c9..1659823baaf4 100644
--- a/lib/bpversion.py
+++ b/lib/bpversion.py
@@ -42,7 +42,12 @@ def kernelversion(tree):
 
 def genkconfig_versions(rel_specs):
     data = ''
-    for i in range(int(rel_specs['PATCHLEVEL']) + 1, 99):
-        data += "config BACKPORT_KERNEL_%s_%s\n" % (rel_specs['VERSION'], i)
-        data += "    def_bool y\n"
+    print(str(rel_specs))
+    version = int(rel_specs['VERSION'])
+    start_patchlevel = int(rel_specs['PATCHLEVEL']) + 1
+    for i in range(version, version + 2):
+        for j in range(start_patchlevel, 99):
+            data += "config BACKPORT_KERNEL_%s_%s\n" % (i, j)
+            data += "    def_bool y\n"
+        start_patchlevel = 0
     return data
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
