Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D8481CD
	for <backports@vger.kernel.org>; Mon, 22 Jan 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959208; cv=none; b=BSBHJs5akiOlEJvhlw7xOnyIuj86KL0vEc74eF9CpobeA8DENfTTANtU0cTKqGg8J1zdWD1cEWkwWH3b5LJJnEv81CmugG6OV0OtZesDClh6vKfVxAJsFyzBjVxsyB69hDh20fLZIqMgqi2rs7pGlDwHeBCR7T4brWpts6KlHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959208; c=relaxed/simple;
	bh=/ckFMB866g4Ze93g63fiwhYU0a3uJmC52H1VZEepJS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEXvZKzavELHuIhhQ7mNHm0d5fvjMTSnI+3lbAhH9o4ZwAL9kXrgh/r1+ViePeKFf618ndaDREnQGUXdFwaVNpG4QG/dSW2Sm1XhqtBKHC/5MrSFP+D/tQMN9LlbKm8eGRawJXKVbn4bqBD56Q6JQXg8Yxotrzg7fKBHLVGrd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=PQN+gAr1; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="PQN+gAr1"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TJk3d14y1z9sW9;
	Mon, 22 Jan 2024 22:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1705959197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDzAGpzfXqdJP3hCMiLjV3Qkz1BRV2L4m689lfAS0ig=;
	b=PQN+gAr12+9eAL+lJD1+Yo6FtcAv80t7BusAUa9IKZOyPgGh+yT7YVN/eSNqI1uY6Kllet
	aIHomuk7siKdy5nz6pPqRKv9saeqqH8JggnUvr2iDMZTUSN6nizzIXkwX14nB9flB9y9Ds
	In9JR8o15dBPahRaP8NSLICkTueDS3mBEhKb9XqlwjbgikfGqXhY1phd1nnVgmKJaoEdzz
	H6lmUxDnxSCI12eOe+OOBFYuKASx820Q2GZeaZexXCXZ5V0BXlqLEZ3HGJDzbRJfyPATUX
	Uv4ttg20/PKLnyvtjU2GyzIxRaj23pND8Uy4jghWcR2mBh7ZFB1gVErs/lG5kg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: Add usb_check_bulk_endpoints()
Date: Mon, 22 Jan 2024 22:33:07 +0100
Message-ID: <20240122213308.149303-2-hauke@hauke-m.de>
In-Reply-To: <20240122213308.149303-1-hauke@hauke-m.de>
References: <20240122213308.149303-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TJk3d14y1z9sW9

Add the usb_check_bulk_endpoints() function.

This function was added to kernel 6.4 and backported to kernel 5.15.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb.h |  6 ++++
 backport/compat/backport-5.15.c       | 51 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index acb5b2ee..4830aebd 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -13,4 +13,10 @@ usb_find_common_endpoints(struct usb_host_interface *alt,
 		struct usb_endpoint_descriptor **int_out);
 #endif /* < 4.12 */
 
+#if LINUX_VERSION_IS_LESS(5,15,0)
+#define usb_check_bulk_endpoints LINUX_BACKPORT(usb_check_bulk_endpoints)
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+#endif /* < 5.15 */
+
 #endif /* __BACKPORT_LINUX_USB_H */
diff --git a/backport/compat/backport-5.15.c b/backport/compat/backport-5.15.c
index fafe9c77..11aa74f6 100644
--- a/backport/compat/backport-5.15.c
+++ b/backport/compat/backport-5.15.c
@@ -4,6 +4,7 @@
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/netdevice.h>
+#include <linux/usb.h>
 
 #include <uapi/linux/if.h>
 
@@ -53,3 +54,53 @@ int put_user_ifreq(struct ifreq *ifr, void __user *arg)
 EXPORT_SYMBOL(put_user_ifreq);
 
 #endif /* >= 4.6.0 */
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
-- 
2.43.0

