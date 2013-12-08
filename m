Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38195 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab3LHPI1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:27 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] backports: add missing include for linux/of.h
Date: Sun,  8 Dec 2013 16:08:08 +0100
Message-Id: <1386515294-26231-3-git-send-email-hauke@hauke-m.de> (sfid-20131208_160829_182069_474D95E8)
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes a compile error with some config options.
Closes bug: https://bugzilla.kernel.org/show_bug.cgi?id=66601

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Richard Röjfors <richard.rojfors@gmail.com>
---
 backport/compat/compat-3.7.c |    1 +
 backport/compat/compat-3.8.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index b21b8ac..2d739f9 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
+#include <linux/of.h>
 
 bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 		      unsigned long delay)
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index a018ea9..c6824bf 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -17,6 +17,7 @@
 #include "hid-ids.h"
 #include <linux/netdevice.h>
 #include <linux/random.h>
+#include <linux/of.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
 void netdev_set_default_ethtool_ops(struct net_device *dev,
-- 
1.7.10.4

