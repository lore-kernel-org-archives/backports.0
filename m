Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB46A332
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393031; cv=none; b=ZRP2qPMlAt7XKUCJ33I5suyvk6DPb/Yoh80z34GINXr8Un5YlBSQ6LR+rVs7IgOhTn09JylAhc8qU5xF3QV0S1Co3rX6OaUVJ6LKsGsdZC10myNaykv1VQ4msoAHqJ/r7eIHMG+5fARcykCEG2n5Tk/q3RJ7Cn/Iskmes7jZvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393031; c=relaxed/simple;
	bh=2/GlwcFx84zDeudmkeX7zKkyoSXeGAGkxuyP45pAKZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1i5oe5xUwS1QnMWriPwkzKXVMl4kYft/V9NgnG+pZa9Zk7sHaFdEdk3ANrLaqwJiMsgLh0P1jVTSS3P8rbuSMTERwR61NB7jS8hyvJ/0RUmORGtU+oaKowoq4BNLwgZKYG0Krk8RlaGVsjXBguvVgp+4/Arxhp285KVY/4BCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=csZgu6lA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="csZgu6lA"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WHN183lXZz9sWy;
	Mon,  8 Jul 2024 00:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720393020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCwZMLd0gExrHyLKQd+nWuOweMSsrMUMAypfRquEVPQ=;
	b=csZgu6lAqAIBgt1GCYn+0n44VV45wvxbbjZfpH1rtKHsy0JgUudnPoVYt4gLrUwJDoFDqL
	c9fCvFGz2FYhyiMJMfczrHxZMbcJ98tH+AJZhqtU8GqV1AQy/IWNI+Hoo3oRYCzWGAxJ6x
	6lFvEZRbPAJvLz5thLlxVmwnD/+T/eOBbtNpOpEL5o9L4NIQUXnqouLdJ0Z87DV6WW3ty+
	8QUdylGU435eCrcFCdy2jSqVdU068/gXoGErxoS05UPzLsCwbAOW3FhuSfv1VGRtoFKFXS
	RjvptqGJZEysAxHcITscz+yM4DHvYYgqgU994mVKvqPTBz56DLSplEjEfZlYXw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] backports: Remove ssb and bcma subsystem
Date: Mon,  8 Jul 2024 00:56:41 +0200
Message-ID: <20240707225646.1924882-3-hauke@hauke-m.de>
In-Reply-To: <20240707225646.1924882-1-hauke@hauke-m.de>
References: <20240707225646.1924882-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WHN183lXZz9sWy

There are only very few changes in ssb and bcma subsystem between kernel
4.14 and 6.1. To reduce the maintenance effort just remove them from
backports and use the in kernel versions instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig.sources                      |  3 -
 backport/Makefile.kernel                      |  2 -
 .../linux/platform_data/brcmnand.h            |  9 ---
 backport/defconfigs/b43                       |  7 ---
 backport/defconfigs/b43legacy                 |  5 --
 backport/defconfigs/brcmsmac                  |  2 -
 backport/defconfigs/wifi                      |  6 --
 copy-list                                     |  4 --
 patches/0102-remove-callback.patch            | 63 -------------------
 patches/0112-gpio-fwnode.patch                | 14 -----
 10 files changed, 115 deletions(-)
 delete mode 100644 backport/backport-include/linux/platform_data/brcmnand.h
 delete mode 100644 patches/0102-remove-callback.patch
 delete mode 100644 patches/0112-gpio-fwnode.patch

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 2ea4d8a6..0aa62a35 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -10,9 +10,6 @@ source "$BACKPORT_DIR/drivers/soc/qcom/Kconfig"
 source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
 source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
 
-source "$BACKPORT_DIR/drivers/ssb/Kconfig"
-source "$BACKPORT_DIR/drivers/bcma/Kconfig"
-
 source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
 
 source "$BACKPORT_DIR/drivers/staging/Kconfig"
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 155e1ff2..14375602 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -42,8 +42,6 @@ obj-$(CPTCFG_QRTR) += net/qrtr/
 obj-$(CPTCFG_QCOM_QMI_HELPERS) += drivers/soc/qcom/
 obj-$(CPTCFG_MHI_BUS) += drivers/bus/mhi/
 obj-$(CPTCFG_WLAN) += drivers/net/wireless/
-obj-$(CPTCFG_SSB) += drivers/ssb/
-obj-$(CPTCFG_BCMA) += drivers/bcma/
 obj-$(CPTCFG_USB_NET_RNDIS_WLAN) += drivers/net/usb/
 
 obj-$(CPTCFG_USB_WDM) += drivers/usb/class/
diff --git a/backport/backport-include/linux/platform_data/brcmnand.h b/backport/backport-include/linux/platform_data/brcmnand.h
deleted file mode 100644
index 9b83d80b..00000000
--- a/backport/backport-include/linux/platform_data/brcmnand.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __BACKPORT_BRCMNAND_PLAT_DATA_H
-#define __BACKPORT_BRCMNAND_PLAT_DATA_H
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_GEQ(5,18,0)
-#include_next <linux/platform_data/brcmnand.h>
-#endif /* >= 5.18.0 */
-
-#endif /* __BACKPORT_BRCMNAND_PLAT_DATA_H */
diff --git a/backport/defconfigs/b43 b/backport/defconfigs/b43
index 27bfb9e2..c486ca1e 100644
--- a/backport/defconfigs/b43
+++ b/backport/defconfigs/b43
@@ -11,10 +11,3 @@ CPTCFG_B43_SDIO=y
 CPTCFG_B43_PHY_N=y
 CPTCFG_B43_PHY_LP=y
 CPTCFG_B43_PHY_HT=y
-CPTCFG_BCMA=m
-CPTCFG_BCMA_HOST_PCI=y
-CPTCFG_SSB=m
-CPTCFG_SSB_PCIHOST=y
-CPTCFG_SSB_PCMCIAHOST=y
-CPTCFG_SSB_SDIOHOST=y
-CPTCFG_SSB_DRIVER_PCICORE=y
diff --git a/backport/defconfigs/b43legacy b/backport/defconfigs/b43legacy
index 71787081..552e13b2 100644
--- a/backport/defconfigs/b43legacy
+++ b/backport/defconfigs/b43legacy
@@ -6,8 +6,3 @@ CPTCFG_MAC80211_LEDS=y
 CPTCFG_WLAN=y
 CPTCFG_WLAN_VENDOR_BROADCOM=y
 CPTCFG_B43LEGACY=m
-CPTCFG_SSB=m
-CPTCFG_SSB_PCIHOST=y
-CPTCFG_SSB_PCMCIAHOST=y
-CPTCFG_SSB_SDIOHOST=y
-CPTCFG_SSB_DRIVER_PCICORE=y
diff --git a/backport/defconfigs/brcmsmac b/backport/defconfigs/brcmsmac
index 2c2edd23..20f429b6 100644
--- a/backport/defconfigs/brcmsmac
+++ b/backport/defconfigs/brcmsmac
@@ -5,5 +5,3 @@ CPTCFG_MAC80211_LEDS=y
 CPTCFG_WLAN=y
 CPTCFG_WLAN_VENDOR_BROADCOM=y
 CPTCFG_BRCMSMAC=m
-CPTCFG_BCMA=m
-CPTCFG_BCMA_HOST_PCI=y
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 2f86cd03..76578641 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -19,9 +19,6 @@ CPTCFG_B43=m
 CPTCFG_B43_PHY_HT=y
 CPTCFG_B43_PHY_N=y
 CPTCFG_B43_SDIO=y
-CPTCFG_BCMA_DRIVER_GPIO=y
-CPTCFG_BCMA_HOST_PCI=y
-CPTCFG_BCMA=m
 CPTCFG_BRCMFMAC=m
 CPTCFG_BRCMFMAC_PCIE=y
 CPTCFG_BRCMFMAC_USB=y
@@ -129,9 +126,6 @@ CPTCFG_RTW88=m
 CPTCFG_RTW89=m
 CPTCFG_RTW89_8852AE=m
 CPTCFG_RTW89_8852CE=m
-CPTCFG_SSB=m
-CPTCFG_SSB_PCMCIAHOST=y
-CPTCFG_SSB_SDIOHOST=y
 CPTCFG_STAGING=y
 CPTCFG_TMD_HERMES=m
 CPTCFG_USB_NET_RNDIS_WLAN=m
diff --git a/copy-list b/copy-list
index 9ddd4fee..7d3811a2 100644
--- a/copy-list
+++ b/copy-list
@@ -71,10 +71,6 @@ drivers/bus/mhi/
 include/linux/mhi.h
 
 drivers/net/wireless/ath/
-drivers/ssb/
-include/linux/ssb/
-drivers/bcma/
-include/linux/bcma/
 drivers/soc/qcom/Makefile
 drivers/soc/qcom/Kconfig
 drivers/soc/qcom/qmi_encdec.c
diff --git a/patches/0102-remove-callback.patch b/patches/0102-remove-callback.patch
deleted file mode 100644
index 9f5a54f1..00000000
--- a/patches/0102-remove-callback.patch
+++ /dev/null
@@ -1,63 +0,0 @@
---- a/drivers/bcma/main.c
-+++ b/drivers/bcma/main.c
-@@ -28,6 +28,7 @@ static DEFINE_MUTEX(bcma_buses_mutex);
- static int bcma_bus_match(struct device *dev, struct device_driver *drv);
- static int bcma_device_probe(struct device *dev);
- static void bcma_device_remove(struct device *dev);
-+static int bcma_device_remove_bp(struct device *dev);
- static int bcma_device_uevent(struct device *dev, struct kobj_uevent_env *env);
- 
- static ssize_t manuf_show(struct device *dev, struct device_attribute *attr, char *buf)
-@@ -71,7 +72,11 @@ static struct bus_type bcma_bus_type = {
- 	.name		= "bcma",
- 	.match		= bcma_bus_match,
- 	.probe		= bcma_device_probe,
-+#if LINUX_VERSION_IS_GEQ(5,15,0)
- 	.remove		= bcma_device_remove,
-+#else
-+	.remove		= bcma_device_remove_bp,
-+#endif
- 	.uevent		= bcma_device_uevent,
- 	.dev_groups	= bcma_device_groups,
- };
-@@ -625,6 +630,12 @@ static void bcma_device_remove(struct de
- 	put_device(dev);
- }
- 
-+static int bcma_device_remove_bp(struct device *dev)
-+{
-+	bcma_device_remove(dev);
-+	return 0;
-+}
-+
- static int bcma_device_uevent(struct device *dev, struct kobj_uevent_env *env)
- {
- 	struct bcma_device *core = container_of(dev, struct bcma_device, dev);
---- a/drivers/ssb/main.c
-+++ b/drivers/ssb/main.c
-@@ -293,6 +293,13 @@ static void ssb_device_remove(struct dev
- 	ssb_device_put(ssb_dev);
- }
- 
-+static int ssb_device_remove_bp(struct device *dev)
-+{
-+	ssb_device_remove(dev);
-+
-+	return 0;
-+}
-+
- static int ssb_device_probe(struct device *dev)
- {
- 	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
-@@ -388,7 +395,11 @@ static struct bus_type ssb_bustype = {
- 	.name		= "ssb",
- 	.match		= ssb_bus_match,
- 	.probe		= ssb_device_probe,
-+#if LINUX_VERSION_IS_GEQ(5,15,0)
- 	.remove		= ssb_device_remove,
-+#else
-+	.remove		= ssb_device_remove_bp,
-+#endif
- 	.shutdown	= ssb_device_shutdown,
- 	.suspend	= ssb_device_suspend,
- 	.resume		= ssb_device_resume,
diff --git a/patches/0112-gpio-fwnode.patch b/patches/0112-gpio-fwnode.patch
deleted file mode 100644
index 5518884d..00000000
--- a/patches/0112-gpio-fwnode.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/bcma/driver_gpio.c
-+++ b/drivers/bcma/driver_gpio.c
-@@ -184,7 +184,11 @@ int bcma_gpio_init(struct bcma_drv_cc *c
- 	chip->direction_input	= bcma_gpio_direction_input;
- 	chip->direction_output	= bcma_gpio_direction_output;
- 	chip->parent		= bus->dev;
-+#if LINUX_VERSION_IS_GEQ(5,17,0)
- 	chip->fwnode		= dev_fwnode(&cc->core->dev);
-+#elif IS_BUILTIN(CONFIG_OF)
-+	chip->of_node		= cc->core->dev.of_node;
-+#endif
- 
- 	switch (bus->chipinfo.id) {
- 	case BCMA_CHIP_ID_BCM4707:
-- 
2.45.2

