Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D02AC65BAE
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA62082F
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLBLw5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:57 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:41152 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbeLBLw5 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:57 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B86EAA1103;
        Sun,  2 Dec 2018 12:52:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id VC7e5zr6aqsQ; Sun,  2 Dec 2018 12:52:52 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/12] backports: Add device_get_mac_address()
Date:   Sun,  2 Dec 2018 12:52:19 +0100
Message-Id: <20181202115226.3594-6-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was added in commit 4c96b7dc0d39 ("Add a matching set of device_
functions for determining mac/phy") and is used by ath10k now. On kernel
< 3.18 call of_property_read_u8_array() only because the device_
function was only added in kernel 3.18.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/property.h | 15 ++++++++
 backport/compat/backport-4.3.c             | 57 ++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 backport/backport-include/linux/property.h

diff --git a/backport/backport-include/linux/property.h b/backport/backport-include/linux/property.h
new file mode 100644
index 00000000..a0d7bed1
--- /dev/null
+++ b/backport/backport-include/linux/property.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_LINUX_PROPERTY_H_
+#define __BACKPORT_LINUX_PROPERTY_H_
+#include <linux/version.h>
+#if LINUX_VERSION_IS_GEQ(3,18,17)
+#include_next <linux/property.h>
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,3,0)
+
+#define device_get_mac_address LINUX_BACKPORT(device_get_mac_address)
+void *device_get_mac_address(struct device *dev, char *addr, int alen);
+
+#endif /* < 4.3 */
+
+#endif /* __BACKPORT_LINUX_PROPERTY_H_ */
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
index 88be5720..04698ad3 100644
--- a/backport/compat/backport-4.3.c
+++ b/backport/compat/backport-4.3.c
@@ -15,6 +15,9 @@
 #include <linux/printk.h>
 #include <linux/thermal.h>
 #include <linux/slab.h>
+#include <linux/property.h>
+#include <linux/etherdevice.h>
+#include <linux/of.h>
 
 #ifdef CONFIG_THERMAL
 #if LINUX_VERSION_IS_GEQ(3,8,0)
@@ -245,3 +248,57 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	return -E2BIG;
 }
 EXPORT_SYMBOL_GPL(strscpy);
+
+static void *device_get_mac_addr(struct device *dev,
+				 const char *name, char *addr,
+				 int alen)
+{
+#if LINUX_VERSION_IS_GEQ(3,18,0)
+	int ret = device_property_read_u8_array(dev, name, addr, alen);
+#else
+	int ret = of_property_read_u8_array(dev->of_node, name, addr, alen);
+#endif
+
+	if (ret == 0 && alen == ETH_ALEN && is_valid_ether_addr(addr))
+		return addr;
+	return NULL;
+}
+
+/**
+ * device_get_mac_address - Get the MAC for a given device
+ * @dev:	Pointer to the device
+ * @addr:	Address of buffer to store the MAC in
+ * @alen:	Length of the buffer pointed to by addr, should be ETH_ALEN
+ *
+ * Search the firmware node for the best MAC address to use.  'mac-address' is
+ * checked first, because that is supposed to contain to "most recent" MAC
+ * address. If that isn't set, then 'local-mac-address' is checked next,
+ * because that is the default address.  If that isn't set, then the obsolete
+ * 'address' is checked, just in case we're using an old device tree.
+ *
+ * Note that the 'address' property is supposed to contain a virtual address of
+ * the register set, but some DTS files have redefined that property to be the
+ * MAC address.
+ *
+ * All-zero MAC addresses are rejected, because those could be properties that
+ * exist in the firmware tables, but were not updated by the firmware.  For
+ * example, the DTS could define 'mac-address' and 'local-mac-address', with
+ * zero MAC addresses.  Some older U-Boots only initialized 'local-mac-address'.
+ * In this case, the real MAC is in 'local-mac-address', and 'mac-address'
+ * exists but is all zeros.
+*/
+void *device_get_mac_address(struct device *dev, char *addr, int alen)
+{
+	char *res;
+
+	res = device_get_mac_addr(dev, "mac-address", addr, alen);
+	if (res)
+		return res;
+
+	res = device_get_mac_addr(dev, "local-mac-address", addr, alen);
+	if (res)
+		return res;
+
+	return device_get_mac_addr(dev, "address", addr, alen);
+}
+EXPORT_SYMBOL_GPL(device_get_mac_address);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
