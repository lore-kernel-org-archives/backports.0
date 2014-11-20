Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33130 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873AbaKTVQo (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 20 Nov 2014 16:16:44 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so3826980pde.38
        for <backports@vger.kernel.org>; Thu, 20 Nov 2014 13:16:42 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: julia.lawall@lip6.fr, oblinger@gmail.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 3/5] backports: bump I2C_SI4713 to v3.13
Date: Thu, 20 Nov 2014 13:16:21 -0800
Message-Id: <1416518183-7347-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20141120_221646_234705_063BAC94)
In-Reply-To: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
References: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver depends on gpio consumer.h, that depends on some
built-in kernel functionality and while we can now backport
built-in stuff we'd need to make that depend on BACKPORT_INTEGRATE
and then figure out how to backport that functionality on integration.

This doesn't seem like a good candidate to test that with though.
Let's wait for something more desirable.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 dependencies | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/dependencies b/dependencies
index 1ca9061..8e11497 100644
--- a/dependencies
+++ b/dependencies
@@ -28,8 +28,19 @@ VIDEO_RENESAS_VSP1 3.4
 VIDEO_MEM2MEM_DEINTERLACE 3.3
 MEDIA_TUNER_E4000 3.4
 DVB_USB_RTL28XXU 3.4
+
 # missing linux/gpio/consumer.h
+# consumer.h cannot be backported currently, as functions rely
+# on in-kernel functionality (GPIO_DEVRES), we can now backport
+# in-kernel functionality but we'd need to make that depend on
+# integration only and figure out a way to easily split that.
+# This does not seem like a good test desirable test case to
+# start that work with.
 VIDEO_ADV7604 3.13
+I2C_SI4713 3.13
+USB_SI4713 3.13
+PLATFORM_SI4713 3.13
+
 # missing function clk_prepare_enable(), clk_disable_unprepare() and devm_regulator_bulk_get()
 VIDEO_MT9V032 3.3
 VIDEO_S5K6AA 3.3
-- 
2.1.1

