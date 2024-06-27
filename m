Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBC1A3BD0
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532143; cv=none; b=i+FafM/tULWmjHMsv3Dqw6BT67+yxoW+C51uuO09OynIRN2pRetDYJUP+XDT9l1sWkxCq3MXM75g4pCPJ49QV8QIwedbSDRQfDKsffLZLTSlimnh6dMGvmmmsTXmsZS4xFxKQwdHrWWy0LXgKpj7QzBP0oSaz8DqMMXVM5X+tL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532143; c=relaxed/simple;
	bh=bK/4ta36wZRTXfFCVqjJtdEO1bWP2gob9tEUts8O0Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNT5EKfZ7HwFznmcf1xVgLYEDOpbkATlEbyJcQiSMbx60Y+brvC3jXsLD5FK6FIKpO7l7yrtUsor5WW+0g5Ippl7PFAqHtuNUV0w7kpGDphhDhMVgYmQCIt0KCbJLxxQeU2UTArbwwp+PWYjU9/GEgTxKc2nhizg9nm8LWgpyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=CVfIIy52; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="CVfIIy52"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdk2WvGz9srJ;
	Fri, 28 Jun 2024 01:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uBo40OD30ZNE6lPmI3WqU2qL398Y4pXeviEVGFA0M4=;
	b=CVfIIy529cwNYNL/i/xPIzbj5kzGQStoGrt0PXdq00FKDpcye9aGHHNn51EbUuwpMFwOt2
	zS5ivfloCvvA7j/ksLQnGvdYillIkztby9CvRXzzWCgAJ7pr8D6y21dKDTsEzi0QfYPrWW
	kDZALZrLB/0AK46Fe4OJNnEuago0atZAPRv6sR9PT/44jOha7wWONSDjPQ/oLigyW9n3ri
	NarjEZeB+E97qMwBNsLd3NpxI3wL2vays+WfQwDMs7rpaT+gpTfuTea3xUc8AzqUCbrmR4
	50uct4MxZZ3/wEMjn2B45vKuj6HApykhbugWd6AFJKMkT5lvIWA5KZDmsT+tTQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 71/75] backports: Add usb_check_int_endpoints()
Date: Fri, 28 Jun 2024 01:47:57 +0200
Message-ID: <20240627234808.1253337-72-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was added together with usb_check_bulk_endpoints(). The carl9170
driver uses this function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/usb.h |  2 ++
 backport/compat/backport-6.4.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 0f6c3b88..ce85f1e1 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -11,6 +11,8 @@
 #define usb_check_bulk_endpoints LINUX_BACKPORT(usb_check_bulk_endpoints)
 bool usb_check_bulk_endpoints(
 		const struct usb_interface *intf, const u8 *ep_addrs);
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
 #endif /* < 5.15 */
 
 #if LINUX_VERSION_IS_LESS(5,19,0)
diff --git a/backport/compat/backport-6.4.c b/backport/compat/backport-6.4.c
index 73177e24..1291fa02 100644
--- a/backport/compat/backport-6.4.c
+++ b/backport/compat/backport-6.4.c
@@ -58,4 +58,30 @@ bool usb_check_bulk_endpoints(
 	return true;
 }
 EXPORT_SYMBOL_GPL(usb_check_bulk_endpoints);
+
+/**
+ * usb_check_int_endpoints - Check whether an interface's current altsetting
+ * contains a set of interrupt endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are interrupt,
+ * %false otherwise.
+ */
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_int(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_int_endpoints);
 #endif
-- 
2.45.2

