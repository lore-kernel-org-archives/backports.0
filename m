Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61002 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDdM (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:33:12 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so404208pad.2
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:33:11 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Erick Macias <emacias@ti.com>, Felipe Balbi <balbi@ti.com>,
	"Mark A. Greer" <mgreer@animalcreek.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 09/12] backports: bump NFC_TRF7970A requirements to 3.5
Date: Mon,  7 Apr 2014 20:32:20 -0700
Message-Id: <1396927943-25589-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053314_199053_7BE0ED25)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

NFC_TRF7970A requires devm_gpio_request_one() but since
gpio infrastructure has been strongly shuffled around
we require drivers to use the in-kernel gpio
infrastructure so just bump NFC_TRF7970A to 3.5.

CC: Erick Macias <emacias@ti.com>
CC: Felipe Balbi <balbi@ti.com>
Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dependencies b/dependencies
index b85268d..352a1af 100644
--- a/dependencies
+++ b/dependencies
@@ -241,6 +241,11 @@ BT_HIDP 2.6.33
 # only introduced in kernel 3.1
 NFC 3.1
 
+# requires devm_gpio_request_one() added but since
+# gpio infrastructure has been strongly shuffled around
+# we require drivers to use the in-kernel gptio infrastructure
+NFC_TRF7970A 3.5
+
 INTEL_IPS 3.2
 
 NFC_MEI_PHY 3.10
-- 
1.8.5.3

