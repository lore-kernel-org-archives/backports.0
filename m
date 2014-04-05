Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52081 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMlm (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:42 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so4644382pab.22
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:41 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 07/27] backports: bump drivers dependency that require I2C bus classes
Date: Sat,  5 Apr 2014 05:40:41 -0700
Message-Id: <1396701662-15165-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144144_483423_2EFAAAC2)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Drivers that depend on I2C bus segments behind multiplexers to
have a class require quite a bit of collateral changes that I
don't have time to address. For those interested in trying to backport
this see commit eee543e8. This bumps the drivers that depend on this
that we carry to require at least v3.7 when this collateral evolution
was introduced. One driver is affected, rtl2832 -- defined under
CONFIG_DVB_RTL2832.

mcgrof@ergon ~/linux (git::master)$ git describe --contains eee543e82481
v3.7-rc1~92^2~14

commit eee543e8248150e8fb833943c71f40c7b1724600
Author: Jean Delvare <khali@linux-fr.org>
Date:   Fri Oct 5 22:23:51 2012 +0200

    i2c-mux: Add support for device auto-detection

    Let I2C bus segments behind multiplexers have a class. This allows for
    device auto-detection on these segments. As long as parent segments
    don't share the same class, it should be fine.

    I implemented support in drivers i2c-mux-gpio and i2c-mux-pca954x. I
    left i2c-mux-pca9541 and i2c-mux-pinctrl alone for the moment as I
    don't know if this feature makes sense for the use cases of these
    drivers.

    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Cc: Peter Korsgaard <peter.korsgaard@barco.com>
    Cc: David Daney <david.daney@cavium.com>
    Cc: Michael Lawnick <ml.lawnick@gmx.de>
    Cc: Rodolfo Giometti <giometti@linux.it>

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dependencies b/dependencies
index 91bf503..ec8348b 100644
--- a/dependencies
+++ b/dependencies
@@ -170,6 +170,15 @@ USB_GSPCA DISABLE
 VIDEO_MXB DISABLE
 VIDEO_RENESAS_VSP1 3.6
 
+# Drivers that depend on I2C bus segments behind multiplexers to
+# have a clas, see eee543e8. This requires quite a bit of collateral,
+# folks involved in this and who want it can backport if it they wish.
+# This was added as of 3.7. Although we should be able to only enable
+# this for 3.7 DVB_USB_RTL28XXU ends up selecting DVB_RTL2832 and
+# that seems to currently require pegging both.
+DVB_RTL2832 3.7
+DVB_USB_RTL28XXU 3.7
+
 # struct gpio_chip only got the required members in 2.6.28
 BCMA_DRIVER_GPIO 2.6.28
 SSB_DRIVER_GPIO 2.6.28
-- 
1.8.5.3

