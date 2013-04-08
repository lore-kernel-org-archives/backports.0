Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29172 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936643Ab3DHK0e (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Apr 2013 06:26:34 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 5/8] backports: add NFC core and drivers
Date: Mon,  8 Apr 2013 12:26:10 +0200
Message-Id: <1365416773-12836-6-git-send-email-thierry.escande@linux.intel.com> (sfid-20130408_122644_107327_7FFCBAE7)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This grabs NFC core and drivers files from your linux tree.

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 copy-list |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/copy-list b/copy-list
index 8c1fb61..e8b1241 100644
--- a/copy-list
+++ b/copy-list
@@ -121,3 +121,17 @@ include/uapi/drm/
 drivers/platform/x86/intel_ips.h
 
 drivers/gpu/drm/
+
+# NFC core
+net/nfc/
+net/nfc/hci/
+net/nfc/llcp/
+net/nfc/nci/
+include/net/nfc/
+include/uapi/linux/nfc.h
+
+# NFC drivers
+drivers/nfc/
+drivers/nfc/microread/
+drivers/nfc/pn544/
+include/linux/platform_data/pn544.h
-- 
1.7.10.4

