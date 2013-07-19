Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34387 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760224Ab3GSMAy (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 08:00:54 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so4396090pac.1
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 05:00:54 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 9/9] backports: lib/kconfig.py - fix src line regexp
Date: Fri, 19 Jul 2013 05:00:09 -0700
Message-Id: <1374235209-19782-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20130719_140056_869211_9CEE5D92)
In-Reply-To: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The source line can be prefixed by spaces and tabs. Without
this a slew of kconfig options were not being parsed for
dependency checking and at compile time they'd obviously
fail.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/kconfig.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kconfig.py b/lib/kconfig.py
index 880d7c3..8a30ddc 100644
--- a/lib/kconfig.py
+++ b/lib/kconfig.py
@@ -4,7 +4,7 @@
 
 import os, re
 
-src_line = re.compile(r'^source\s+"?(?P<src>[^\s"]*)"?\s*$')
+src_line = re.compile(r'^[\s]*source\s+"?(?P<src>[^\s"]*)"?\s*$')
 tri_line = re.compile(r'^(?P<spc>\s+)tristate')
 bool_line = re.compile(r'^(?P<spc>\s+)bool')
 cfg_line = re.compile(r'^(config|menuconfig)\s+(?P<sym>[^\s]*)')
-- 
1.7.10.4

