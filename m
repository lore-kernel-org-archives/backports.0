Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51834 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbbLUAGL (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:06:11 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] patches: convert gpio: change member .dev to .parent
Date: Mon, 21 Dec 2015 01:06:00 +0100
Message-Id: <1450656361-21259-6-git-send-email-hauke@hauke-m.de> (sfid-20151221_010620_666886_59E2A5D4)
In-Reply-To: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
References: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

add semantic patch which uses the dev member of struct gpio_chip on
kenrel version < 4.5 This change was done in upstream kernel commit
58383c78 "gpio: change member .dev to .parent".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../generic/0002-gpio-parent.cocci                 | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 patches/collateral-evolutions/generic/0002-gpio-parent.cocci

diff --git a/patches/collateral-evolutions/generic/0002-gpio-parent.cocci b/patches/collateral-evolutions/generic/0002-gpio-parent.cocci
new file mode 100644
index 0000000..b266fac
--- /dev/null
+++ b/patches/collateral-evolutions/generic/0002-gpio-parent.cocci
@@ -0,0 +1,25 @@
+/* convert gpio: change member .dev to .parent
+ *
+ * add semantic patch which uses the dev member of struct gpio_chip on
+ * kenrel version < 4.5 This change was done in upstream kernel commit
+ * 58383c78 "gpio: change member .dev to .parent".
+ */
+
+@r1@
+struct gpio_chip *chip;
+expression E1;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
+ chip->parent = E1;
++#else
++chip->dev = E1;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0) */
+@r2@
+struct gpio_chip chip;
+expression E2;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
+ chip.parent = E2;
++#else
++chip.dev = E2;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0) */
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
