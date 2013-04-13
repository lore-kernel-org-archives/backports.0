Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44237 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzS (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:18 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 40/42] backports: include hardirq into netdevice.h
Date: Sun, 14 Apr 2013 01:54:00 +0200
Message-Id: <1365897243-31214-41-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015519_991887_3EB9FB34)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

On newer kernels this is included (indirectly) and
unfortunately some drivers rely on it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 74230d9..11e2058 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -7,6 +7,11 @@
 /* older kernels don't include this here, we need it */
 #include <linux/ethtool.h>
 #include <linux/rculist.h>
+/*
+ * new kernels include <net/netprio_cgroup.h> which
+ * has this ... and some drivers rely on it :-(
+ */
+#include <linux/hardirq.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 #define dev_change_net_namespace(a, b, c) (-EOPNOTSUPP)
-- 
1.8.0

