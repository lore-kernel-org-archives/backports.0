Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:40906 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeIWXoB (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/10] dependencies: Make WIL6210 depend on kernel >= 4.8
Date: Sun, 23 Sep 2018 19:45:30 +0200
Message-Id: <20180923174535.16198-6-hauke@hauke-m.de> (sfid-20180923_194551_041786_E1F84913)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The WIL6210 driver now uses pci_alloc_irq_vectors() which is only
available in kernel >= 4.8, only build this driver against such kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 555f31fb..42ed0e2f 100644
--- a/dependencies
+++ b/dependencies
@@ -63,3 +63,6 @@ MT76x2E 4.1
 # select_queue_fallback_t is missing
 RTL8723BS 3.14
 R8188EU  3.14
+
+# pci_alloc_irq_vectors is missing
+WIL6210 4.8
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
