Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35785 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890Ab3DJLf7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:35:59 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so218418pdi.21
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:35:58 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 05/18] compat: backport GPIOF_OPEN_DRAIN definition
Date: Wed, 10 Apr 2013 04:35:15 -0700
Message-Id: <1365593728-5720-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133606_426363_0ABF3CE3)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
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
 backport/include/linux/compat-3.4.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/include/linux/compat-3.4.h b/backport/include/linux/compat-3.4.h
index a152d51..528ae09 100644
--- a/backport/include/linux/compat-3.4.h
+++ b/backport/include/linux/compat-3.4.h
@@ -11,6 +11,8 @@
 #include <linux/kconfig.h>
 #endif
 
+#define GPIOF_OPEN_DRAIN       (1 << 2)
+
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #if defined(CONFIG_REGMAP)
 #include <linux/regmap.h>
-- 
1.7.10.4

