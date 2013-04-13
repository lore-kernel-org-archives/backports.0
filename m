Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44269 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXzr (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:47 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 41/42] backports: add vgaarb.h
Date: Sun, 14 Apr 2013 01:54:01 +0200
Message-Id: <1365897243-31214-42-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015643_728448_B670DDF3)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This is needed as old versions of it didn't properly
declare struct pci_dev.

Additionally, not all versions included video/vga.h
which causes issues as that pulls in some required
definitions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/vgaarb.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 backport/backport-include/linux/vgaarb.h

diff --git a/backport/backport-include/linux/vgaarb.h b/backport/backport-include/linux/vgaarb.h
new file mode 100644
index 0000000..92f5a72
--- /dev/null
+++ b/backport/backport-include/linux/vgaarb.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_VGAARB_H
+#define __BACKPORT_LINUX_VGAARB_H
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+struct pci_dev;
+#endif
+#include <video/vga.h>
+#include_next <linux/vgaarb.h>
+
+#endif /* __BACKPORT_LINUX_VGAARB_H */
-- 
1.8.0

