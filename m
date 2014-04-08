Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44244 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDdH (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:33:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so398468pab.22
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:33:07 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Antti Palosaari <crope@iki.fi>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/12] backports: disable DVB_RTL2832 and DVB_USB_RTL28XXU
Date: Mon,  7 Apr 2014 20:32:19 -0700
Message-Id: <1396927943-25589-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053309_638559_9804A31F)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit bcf43393 as of linux-next next-20140320 added this Makefile
header extension:

ccflags-y += -I$(srctree)/drivers/staging/media/rtl2832u_sdr

This ends up calling a staging exported symbol rtl2832_sdr_attach().
Let's not pollute driver code with staging code or dependencies.

Folks, can this be cleaned up? This sets a precedent for doing more
of this, and this can get hairy. Its also not fair for folks who
don't want to carry over any staging code. This forces them to, and
its not just a header file, its a full exported symbol. What about
synchronization with differen trees? Was this addressed with Greg?

commit bcf43393579e3d4069e75a9200a87703185bcf11
Author: Antti Palosaari <crope@iki.fi>
Date:   Tue Sep 10 00:13:57 2013 -0300

    [media] rtl28xxu: attach SDR extension module

    With that extension module it supports SDR.

    Signed-off-by: Antti Palosaari <crope@iki.fi>
    Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

Cc: Antti Palosaari <crope@iki.fi>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index 6193ed1..b85268d 100644
--- a/dependencies
+++ b/dependencies
@@ -185,8 +185,13 @@ VIDEO_RENESAS_VSP1 3.6
 # This was added as of 3.7. Although we should be able to only enable
 # this for 3.7 DVB_USB_RTL28XXU ends up selecting DVB_RTL2832 and
 # that seems to currently require pegging both.
-DVB_RTL2832 3.7
-DVB_USB_RTL28XXU 3.7
+#
+# DVB_USB_RTL28XXU has a nasty ccflag usage thoug that includes staging
+# headers introduced via commit bcf43393:
+# ccflags-y += -I$(srctree)/drivers/staging/media/rtl2832u_sdr
+# Let's not support this nastiness.
+DVB_RTL2832 DISABLE
+DVB_USB_RTL28XXU DISABLE
 
 # struct gpio_chip only got the required members in 2.6.28
 BCMA_DRIVER_GPIO 2.6.28
-- 
1.8.5.3

