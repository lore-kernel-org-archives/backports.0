Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:50629 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMld (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:33 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so4650626pbb.17
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:33 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 05/27] backports: make WL1251_SPI depend on >= 3.5
Date: Sat,  5 Apr 2014 05:40:39 -0700
Message-Id: <1396701662-15165-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144134_665936_1451C02A)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The WL1251_SPI driver now depends on EPROBE_DEFER and others which
we canot backports that pushes it to require 3.4 but since it also
relies on devm_gpio_request_one() we bump it to 3.5. The gpio layer
has received quite a bit of updates and it doesn't make sense to
backport them separately.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 28c4873..13e8a75 100644
--- a/dependencies
+++ b/dependencies
@@ -29,7 +29,9 @@ USB_NET_RNDIS_WLAN 2.6.29
 
 CARL9170 2.6.29
 
-WL1251_SPI 2.6.37
+
+# depends on -EPROBE_DEFER and others now
+WL1251_SPI 3.5
 
 WL1251_SDIO 2.6.37
 WLCORE_SDIO 2.6.38
-- 
1.8.5.3

