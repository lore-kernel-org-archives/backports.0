Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48408 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab3DMON7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 10:13:59 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so1887761pad.6
        for <backports@vger.kernel.org>; Sat, 13 Apr 2013 07:13:59 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/7] compat: add missing header includes for DMA backports
Date: Sat, 13 Apr 2013 07:13:39 -0700
Message-Id: <1365862424-6530-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161400_802821_AF4B6AD0)
In-Reply-To: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.6.c        |    1 +
 backport/include/linux/compat-3.6.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
index 5355cd2..1e4480b 100644
--- a/backport/compat/compat-3.6.c
+++ b/backport/compat/compat-3.6.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#include <linux/dma-attrs.h>
 /*
  * Create scatter-list for the already allocated DMA buffer.
  */
diff --git a/backport/include/linux/compat-3.6.h b/backport/include/linux/compat-3.6.h
index ccc43a2..f2c1a90 100644
--- a/backport/include/linux/compat-3.6.h
+++ b/backport/include/linux/compat-3.6.h
@@ -9,6 +9,7 @@
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include <linux/i2c.h>
+#include <linux/dma-attrs.h>
 /* Unlocked flavor */
 #define __i2c_transfer LINUX_BACKPORT(__i2c_transfer)
 extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-- 
1.7.10.4

