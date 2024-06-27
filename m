Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D811A38C3
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532142; cv=none; b=uv1EsnZyz4aoRROpDEKs3WpQPV2sWy9wNK6YmiWAKzCDuWYDDyH6NVsaxfd7mdBwBmzcsF9E/ohB4q3q2bHoJbjOzWGvAnXTMX32d/BjDsumd1DQ44C/nSUh1ILjj6cyKOp2ZdgvtEqQxgsV5e1qV0gI47EdXPOd89jgxzkyXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532142; c=relaxed/simple;
	bh=E90lHIl91SU6LYMc9AFNvE+o5JwsFbEt3RcUa9qgPu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIzh9SKTMTO5U8Az4E/t3id6P2/0ybP1B1fZAYu+AVAkXjkuRwTumdb+xY4Ll4R9yS2rgZudHmSt68LhsYDIhBzfroJhcWkOFrI9sM6uaTKh3BIQDN5J7gIafwYa0C+scoUvybkF0mR5oshG2CwMURPWxyYfsjaI4qIBrkP+VG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=CqQnn391; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="CqQnn391"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdk0lTBz9slL;
	Fri, 28 Jun 2024 01:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14l4z+5QMLNDO3cDJulNEBBGyxMemAdVz7Ml/1IU3OE=;
	b=CqQnn3916ryc7ClXm/aTBRQa9f/7wWgN6iDy1uCWrHqg9xFE59X1pgj97Vrayp+Fu2sb/I
	wu/qCUZuaAPnEYwS857rcVYqY+Qh6FSqr2go3OZDFYSJSNSKpWBbKyoPzkiNd4srU3iP6K
	cGRnZZ5TZ9ndTGUBDBSb/U3aR18IwOsqUqM36PLVeKAafJcJ9gMQUPszq6osGkaRt2Wrzz
	RIsvbrEuZrZJSkDTAwJij0oN/BBVpztXWi0HEg5HBtzxRyUVYouWmEVgCUm3vYwmlBDkcT
	gtElPcjrmaSrJsfsUPC/eztdo2YRerLdAtWjsP7gkfgZrlClZAsW040kF19NHg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 70/75] backports: Move  usb_check_bulk_endpoints to 6.4
Date: Fri, 28 Jun 2024 01:47:56 +0200
Message-ID: <20240627234808.1253337-71-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_check_bulk_endpoints() was added in kernel 6.4 and then backported
to older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb.h |  6 ++-
 backport/compat/Makefile              |  1 +
 backport/compat/backport-5.15.c       | 52 -----------------------
 backport/compat/backport-6.4.c        | 61 +++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 53 deletions(-)
 create mode 100644 backport/compat/backport-6.4.c

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index ba39657b..0f6c3b88 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -3,7 +3,11 @@
 #include_next <linux/usb.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_IS_LESS(5,15,0)
+#if LINUX_VERSION_IS_LESS(6,3,5) && \
+	!LINUX_VERSION_IN_RANGE(6,1,31, 6,2,0) &&     \
+	!LINUX_VERSION_IN_RANGE(5,15,114, 5,16,0) &&     \
+	!LINUX_VERSION_IN_RANGE(5,10,181, 5,11,0) &&     \
+	!LINUX_VERSION_IN_RANGE(5,4,244, 5,5,0)
 #define usb_check_bulk_endpoints LINUX_BACKPORT(usb_check_bulk_endpoints)
 bool usb_check_bulk_endpoints(
 		const struct usb_interface *intf, const u8 *ep_addrs);
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 0e48ca01..51b95384 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -17,4 +17,5 @@ compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
 compat-$(CPTCFG_KERNEL_5_15) += backport-5.15.o
+compat-$(CPTCFG_KERNEL_6_4) += backport-6.4.o
 
diff --git a/backport/compat/backport-5.15.c b/backport/compat/backport-5.15.c
index bfafaec5..c93f922e 100644
--- a/backport/compat/backport-5.15.c
+++ b/backport/compat/backport-5.15.c
@@ -4,7 +4,6 @@
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/netdevice.h>
-#include <linux/usb.h>
 
 #include <uapi/linux/if.h>
 
@@ -51,54 +50,3 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg)
 	return 0;
 }
 EXPORT_SYMBOL(put_user_ifreq);
-
-
-/**
- * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
- * usb_host_endpoint structure in an interface's current altsetting.
- * @intf: the interface whose current altsetting should be searched
- * @ep_addr: the endpoint address (number and direction) to find
- *
- * Search the altsetting's list of endpoints for one with the specified address.
- *
- * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
- */
-static const struct usb_host_endpoint *usb_find_endpoint(
-		const struct usb_interface *intf, unsigned int ep_addr)
-{
-	int n;
-	const struct usb_host_endpoint *ep;
-
-	n = intf->cur_altsetting->desc.bNumEndpoints;
-	ep = intf->cur_altsetting->endpoint;
-	for (; n > 0; (--n, ++ep)) {
-		if (ep->desc.bEndpointAddress == ep_addr)
-			return ep;
-	}
-	return NULL;
-}
-
-/**
- * usb_check_bulk_endpoints - Check whether an interface's current altsetting
- * contains a set of bulk endpoints with the given addresses.
- * @intf: the interface whose current altsetting should be searched
- * @ep_addrs: 0-terminated array of the endpoint addresses (number and
- * direction) to look for
- *
- * Search for endpoints with the specified addresses and check their types.
- *
- * Return: %true if all the endpoints are found and are bulk, %false otherwise.
- */
-bool usb_check_bulk_endpoints(
-		const struct usb_interface *intf, const u8 *ep_addrs)
-{
-	const struct usb_host_endpoint *ep;
-
-	for (; *ep_addrs; ++ep_addrs) {
-		ep = usb_find_endpoint(intf, *ep_addrs);
-		if (!ep || !usb_endpoint_xfer_bulk(&ep->desc))
-			return false;
-	}
-	return true;
-}
-EXPORT_SYMBOL_GPL(usb_check_bulk_endpoints);
diff --git a/backport/compat/backport-6.4.c b/backport/compat/backport-6.4.c
new file mode 100644
index 00000000..73177e24
--- /dev/null
+++ b/backport/compat/backport-6.4.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/usb.h>
+
+#if LINUX_VERSION_IS_LESS(6,3,5) && \
+	!LINUX_VERSION_IN_RANGE(6,1,31, 6,2,0) &&     \
+	!LINUX_VERSION_IN_RANGE(5,15,114, 5,16,0) &&     \
+	!LINUX_VERSION_IN_RANGE(5,10,181, 5,11,0) &&     \
+	!LINUX_VERSION_IN_RANGE(5,4,244, 5,5,0)
+
+/**
+ * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
+ * usb_host_endpoint structure in an interface's current altsetting.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addr: the endpoint address (number and direction) to find
+ *
+ * Search the altsetting's list of endpoints for one with the specified address.
+ *
+ * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
+ */
+static const struct usb_host_endpoint *usb_find_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	int n;
+	const struct usb_host_endpoint *ep;
+
+	n = intf->cur_altsetting->desc.bNumEndpoints;
+	ep = intf->cur_altsetting->endpoint;
+	for (; n > 0; (--n, ++ep)) {
+		if (ep->desc.bEndpointAddress == ep_addr)
+			return ep;
+	}
+	return NULL;
+}
+
+/**
+ * usb_check_bulk_endpoints - Check whether an interface's current altsetting
+ * contains a set of bulk endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are bulk, %false otherwise.
+ */
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_bulk(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_bulk_endpoints);
+#endif
-- 
2.45.2

