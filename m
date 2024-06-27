Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159831A38C5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532133; cv=none; b=DNbPdM8VImBNWTEebTDUpJTvLpqRisA3HymxdPELu3kxL+ZUtoJyW/vs3PaU2QhQu7sB/Zz+HGREwSBhtDvHSonUpMEvo7LZTSFlaN4hJzsnkPojTU4v6QQVx7+aKbUGFxGcL3pmBZB+OuAW4awtRjtPn00S/v4Ey7aQII/SDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532133; c=relaxed/simple;
	bh=PUnJRbicn4M8MOSO2b+15WnUKf6hehwg9XBx3659vbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBuJcreaRMRH1A8FdYgtdJmmdoBS0gxMIvXwBJ1qKwXcpurvPxpw1Ah46I6C/6lVVZb9CphXrzIX6/amKEwg4uAHdkZ/QL7KHi26ThwE5XXtXdZJaOeDjRnxT18ZTNSMA/FbqCV420IYWJWtDZl2MfeGhJmRPl48tAoQYDp/MxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=zK0G7hTo; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="zK0G7hTo"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdX4PZdz9svK;
	Fri, 28 Jun 2024 01:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrevgbKAcAVbPVqUMWeRFJB5eXUsMen5WVucdzgUzFw=;
	b=zK0G7hToj0Aia2FccSYGV/vTu60/JxCoGo28Y4upV50bflKxspQ8b5jW+kdYKA4IG6SKrM
	BBsFmCcG4yZ1n5hPuF7JZh4hYB5aARpt6zidkvGi7FZuUy5eoBl2M98Hdomh7UFIhhYLdR
	LVpY+vsp2lP7R4ovYf/k6bBTggQBAdP9wEb3ZaZSTJhByHlqyhCfgedg67LWnFjcBDXK/5
	QNKB6WRFHNJ0mY9GtR4euuDNTdfW6XddxRzKV3oaAKhFdAwUmi1pnTVoXfxdUIIiA9cdyT
	1AgOBiNcA2L9UQiiNrrFGDu4lDqU6vXIeOL12y1kxAkWlLKwUOL2vXENTLNgjw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 33/75] headers: backport usb_maxpacket api change
Date: Fri, 28 Jun 2024 01:47:19 +0200
Message-ID: <20240627234808.1253337-34-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

The third argument was removed

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/usb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index bedc405b..ba39657b 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -9,4 +9,12 @@ bool usb_check_bulk_endpoints(
 		const struct usb_interface *intf, const u8 *ep_addrs);
 #endif /* < 5.15 */
 
+#if LINUX_VERSION_IS_LESS(5,19,0)
+static inline u16 backport_usb_maxpacket(struct usb_device *udev, int pipe)
+{
+	return usb_maxpacket(udev, pipe, usb_pipeout(pipe));
+}
+#define usb_maxpacket LINUX_BACKPORT(usb_maxpacket)
+#endif /* <5.19 */
+
 #endif /* __BACKPORT_LINUX_USB_H */
-- 
2.45.2

