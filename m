Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:56028 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161252Ab3DGCWa (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:22:30 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so2675771pad.16
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:22:30 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 6/9] compat: backport GPIOF_OPEN_DRAIN definition
Date: Sat,  6 Apr 2013 19:21:59 -0700
Message-Id: <1365301322-19327-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042232_359752_DF207B9B)
In-Reply-To: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This functionality will just be ignored, later we'll
just port the full gpiolib.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains  aca5ce14
v3.4-rc1~65^2~20

commit aca5ce14eb773a75e5d935968b2e390dc5bd29c3
Author: Laxman Dewangan <ldewangan@nvidia.com>
Date:   Fri Feb 17 20:26:21 2012 +0530

    gpio: gpiolib: Support for open drain/collector gpios

    Adding support for the open drain gpio on which client
    can specify the open drain property through GPIO flag
    GPIOF_OPEN_DRAIN at the time of gpio request.
    The open drain pins are normally pulled high and it
    cannot be driven to output with value of 1 and so
    when client request for setting the pin to HIGH, the
    gpio will be set to input direction to make pin in tristate
    and hence PULL-UP on pins will make the state to HIGH.
    The open drain pin can be driven to LOW by setting output
    with value of 0.

    Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
    Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/include/linux/compat-3.4.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/include/linux/compat-3.4.h b/backport/include/linux/compat-3.4.h
index 0636499..eb557d9 100644
--- a/backport/include/linux/compat-3.4.h
+++ b/backport/include/linux/compat-3.4.h
@@ -12,6 +12,7 @@
 #endif
 
 #define EPROBE_DEFER   517     /* Driver requests probe retry */
+#define GPIOF_OPEN_DRAIN       (1 << 2)
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include <linux/regmap.h>
-- 
1.7.10.4

