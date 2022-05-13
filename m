Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC63C4167B
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382324AbiEMQGR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382326AbiEMQGQ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:16 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DAFFD20
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9FCBF6E3A88;
        Fri, 13 May 2022 16:06:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id ZNuBwvXqBUEn; Fri, 13 May 2022 16:06:13 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id D14E36E3A7E;
        Fri, 13 May 2022 16:05:28 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 09/15] lib/bpversion: calculate Kconfig.versions for next major version
Date:   Fri, 13 May 2022 09:05:17 -0700
Message-Id: <20220513160523.2944694-10-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
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
