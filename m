Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10788 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162638Ab3DEVUv (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 17:20:51 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 5/8] backports: add NFC core and drivers
Date: Fri,  5 Apr 2013 23:20:39 +0200
Message-Id: <1365196842-12992-5-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232055_726516_4AE4C9DE)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This grabs NFC core and drivers files from your linux tree.

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 copy-list |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/copy-list b/copy-list
index 820e17a..20cc02a 100644
--- a/copy-list
+++ b/copy-list
@@ -134,3 +134,17 @@ drivers/gpu/drm/radeon/
 drivers/gpu/drm/ttm/
 drivers/gpu/drm/via/
 drivers/gpu/drm/vmwgfx/
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

