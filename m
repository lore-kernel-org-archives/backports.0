Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:47568 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbaD3B3T (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 29 Apr 2014 21:29:19 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so168403qcv.3
        for <backports@vger.kernel.org>; Tue, 29 Apr 2014 18:29:18 -0700 (PDT)
From: Avery Pennarun <apenwarr@gmail.com>
To: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH] Makefile: add savedefconfig target.
Date: Tue, 29 Apr 2014 21:29:06 -0400
Message-Id: <1398821346-17344-1-git-send-email-apenwarr@gmail.com> (sfid-20140430_032926_415137_C2BA5FEE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This writes a file called 'defconfig' which contains only the deltas from
the default configuration.  It's suitable for use as an input defconfig file
for later builds.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 backport/Makefile.real | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index b010dd7..f60d5ca 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -32,6 +32,11 @@ usedefconfig:
 	@$(MAKE) -C kconf conf
 	@./kconf/conf --defconfig=defconfig Kconfig
 
+.PHONY: savedefconfig
+savedefconfig:
+	@$(MAKE) -C kconf conf
+	@./kconf/conf --savedefconfig=defconfig Kconfig
+
 defconfig-%::
 	@$(MAKE) -C kconf conf
 	@./kconf/conf --defconfig=defconfigs/$(@:defconfig-%=%) Kconfig
-- 
1.9.1.423.g4596e3a

