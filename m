Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6B6A332
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393034; cv=none; b=E9XnGeWxHeA4srPShmk5B7UUooAqa/d7vU8K4QFTGHBvD9BKi+nTYn3i+0WTwMWU+afAgju5iCQavboqvUx4eHZC76n2epIHODXMl1GhUwS0s3TsAqNVp5Ymv6tIwvj9QPLyQ9OF+9yQvkss0xBwKXHZ6ku98JhkODioZXEVnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393034; c=relaxed/simple;
	bh=4+uhoqIMhxb1G91Yho/hg/BKNGn4kNVIOkK8IframIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqWzp2NhlUzjGbdeK51g7KPOCu/Au3ktFC4CTZwHrylwEafkfZ6Q/3kYpLqTctZ6zffPGuPa8SJMLXGRfT7l921fFmrjlcZWqEkzlTukLL5b/jKXff22ajSvvBS0Y+ykCRb6Gxz9wWHzhF2rleSKjUkyAoeo+TkxjxIzQlMXuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=l0QMN7g/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="l0QMN7g/"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WHN193kV8z9sdW;
	Mon,  8 Jul 2024 00:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720393021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfixvQuJmXI0kwLzxNlpV36Nn8nFd4mfvfXBCmCBdZU=;
	b=l0QMN7g//+Mvp3hjJIER4dFfQ+ccBBSzhPQZrDWuXVe9KH3lRaPF0z4tURMV24w7AdfcQf
	5uZPEGJ4EmZR63+ZY2pZi4ww/lRgFomzVFY+0f5HJFvk3wH0FaT2C6Mt5PDR+FZAlR8gCh
	aOCVJiEX4ka6f9qg4/DAu+GEirP8yL+X4CaJKq3xuZg+FXkVOhL29sAOZ+4r6dU/wfawKk
	u6RcDUarMuKESvcHMAqogFIdEdExExGHQY3stpMW1U5cIzQuXUPH3brgdzUizeUxVc4NDv
	UxP4SD/By4QcFDOGULqYNE/OoRoXUzG7/mbf5VUx3rglJD+wIzDhNlNuurL2WA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] backports: Add Silabs WFX driver
Date: Mon,  8 Jul 2024 00:56:44 +0200
Message-ID: <20240707225646.1924882-6-hauke@hauke-m.de>
In-Reply-To: <20240707225646.1924882-1-hauke@hauke-m.de>
References: <20240707225646.1924882-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the new WFX driver to backports.
This driver was moved out of staging to Linux wireless in 5.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 2 ++
 copy-list                | 1 +
 dependencies             | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 76578641..5cea894a 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -131,6 +131,7 @@ CPTCFG_TMD_HERMES=m
 CPTCFG_USB_NET_RNDIS_WLAN=m
 CPTCFG_USB_ZD1201=m
 CPTCFG_WCN36XX=m
+CPTCFG_WFX=m
 CPTCFG_WIL6210=m
 CPTCFG_WILC1000_SDIO=m
 CPTCFG_WILC1000_SPI=m
@@ -151,6 +152,7 @@ CPTCFG_WLAN_VENDOR_QUANTENNA=y
 CPTCFG_WLAN_VENDOR_RALINK=y
 CPTCFG_WLAN_VENDOR_REALTEK=y
 CPTCFG_WLAN_VENDOR_RSI=y
+CPTCFG_WLAN_VENDOR_SILABS=y
 CPTCFG_WLAN_VENDOR_ST=y
 CPTCFG_WLAN_VENDOR_TI=y
 CPTCFG_WLAN_VENDOR_ZYDAS=y
diff --git a/copy-list b/copy-list
index 7d3811a2..d4034486 100644
--- a/copy-list
+++ b/copy-list
@@ -90,6 +90,7 @@ drivers/net/wireless/intersil/orinoco/
 drivers/net/wireless/intersil/p54/
 drivers/net/wireless/quantenna/
 drivers/net/wireless/realtek/
+drivers/net/wireless/silabs/
 drivers/net/wireless/ti/
 drivers/net/wireless/mediatek/
 drivers/net/wireless/admtek/
diff --git a/dependencies b/dependencies
index 17204918..f938b27d 100644
--- a/dependencies
+++ b/dependencies
@@ -57,3 +57,6 @@ ATH11K 5.2
 
 # usb_control_msg_send
 R8188EU 5.10
+
+# gpiod_set_consumer_name
+WFX 4.19
-- 
2.45.2

