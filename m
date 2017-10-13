Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49176 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757567AbdJMJmd (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:33 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 08/11] backports: make QTNFMAC_PEARL_PCIE depend on 3.13
Date: Fri, 13 Oct 2017 11:42:23 +0200
Message-Id: <20171013094226.10021-8-johannes@sipsolutions.net> (sfid-20171013_114235_733934_B32D1D22)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

It needs pcie_get_mps() which was only exported in that kernel.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 0df2b8fae8c2..220ccf47232e 100644
--- a/dependencies
+++ b/dependencies
@@ -62,6 +62,9 @@ NFC_NXP_NCI_I2C 3.17
 # pci_error_handlers->reset_notify is missing
 MWIFIEX_PCIE 3.16
 
+# needs pcie_get_mps()
+QTNFMAC_PEARL_PCIE 3.13
+
 # needs pm_system_wakeup() which can't reall be
 # backported properly
 MWIFIEX 3.18
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
