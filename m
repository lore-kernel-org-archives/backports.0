Return-Path: <SRS0=KWFe=ZZ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607EC432C3
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6EE206E4
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 16:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCQPt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:15:49 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55454 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCQPt (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 3 Dec 2019 11:15:49 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icAq3-00Fbya-1d; Tue, 03 Dec 2019 17:15:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: significantly speed up build
Date:   Tue,  3 Dec 2019 17:15:40 +0100
Message-Id: <20191203161540.174109-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When building with /bin/sh -> bash, things are SUPER slow (at least
for me), because bash takes a LOOONG time to look at the environment
variables (and we typically have around 6k), adding over a second to
each bash invocation for me.

The reason we export them is that we need them in all of the sub-
makes, and those only read auto.conf, which we can't change.

Work around this by overriding 'make' itself, and using --eval to
read *our* .config file into each make that gets called. This way,
the variables are present in all make invocations in the same way
as they would be through the environment, but don't get passed to
shell invocations.

If --eval is not supported, keep doing what we did before.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile.build | 7 +++++++
 backport/scripts/make   | 4 ++++
 2 files changed, 11 insertions(+)
 create mode 100755 backport/scripts/make

diff --git a/backport/Makefile.build b/backport/Makefile.build
index a848b37ed64b..9c272b2ddf62 100644
--- a/backport/Makefile.build
+++ b/backport/Makefile.build
@@ -1,4 +1,11 @@
+# detect if make supports --eval
+_EVAL := $(shell make --eval "test:" -f /dev/null test >/dev/null 2>&1 && echo YES || echo NO)
+ifeq ($(_EVAL),YES)
+MAKE=$(BACKPORT_DIR)/scripts/make
+else
 -include .config
+endif
+
 export
 
 .PHONY: modules
diff --git a/backport/scripts/make b/backport/scripts/make
new file mode 100755
index 000000000000..cff7d0031478
--- /dev/null
+++ b/backport/scripts/make
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+exec make --eval '-include $(BACKPORT_DIR)/.config' "$@"
-- 
2.23.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
