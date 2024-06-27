Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB01A38FA
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532139; cv=none; b=oagJH+johsZFG2YnKEscU2IyFysU+EitGiQ02Caulzyc5o4FEG048Cf+r7xRPulD45O09p0resYIX2aK2N/F1Elho4DmVYjLrJjswOnHQ2L6Ok6o8/op8ELQ3Wv1RI0Q9/TuM3iOX8v9cfVWYTz6i64PLKQpaKTjpUNEm8nesmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532139; c=relaxed/simple;
	bh=QjPiIj2zliP8hV/nJOEsZ6qKtjWA4UxnN0FKJ3nU7Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFSZEaYd/r/+zZdZfdqJAB7M8QABfEZbykNuFgY2G8mhGlOTd6GkZ1Uhndusr6SMPEnjGPilvQ2BwlkvYxtk1Re737tGiR/S6WmyytJHVslAGTB2b5K7w2BeJ5FT0p3NdJjknDizWU4YgkDzAAWi+rbgWQjJzDhVZhrzJF8pu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=aeNnDEOm; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="aeNnDEOm"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdf1Q4Xz9ssb;
	Fri, 28 Jun 2024 01:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQO2FzDa9aX5mdZ7oMLwRYwvvYvOdC9C5CHnFv0c06Y=;
	b=aeNnDEOm6Kv9VWotFBs0IiUlWfgVyjQqGMY75xDaIjrZMHWMPLYj8/lFDkvsd+c0uhLFzS
	vyaucMuqm987Yk/Xaq/8Hxk9ewKmtbSSXsg33R+v1rnh3i3hG/7qfiGgM8oeLIuxkEsVwu
	o2H+l6ov2rlNh5RY02rfbcFNXOz6JyQlWTEjxGuxdUZ241psIBqtIdp93B2+I/pMqdBn0A
	WLHo9TzWFCUq8EMppyNULBAr2OKwMcbOhlP9F7qIbAYwuR93OXmbeLQgdaofuezfpr/7qb
	Td86Bt+2atyeWDxZJRNx94HQL7kianYWd4hvoyMZQ36h3sqpbMRur00GJZ+Tcg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 54/75] patch: bcma: Fill of_node instead of fwnode on older kernel
Date: Fri, 28 Jun 2024 01:47:40 +0200
Message-ID: <20240627234808.1253337-55-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older kernel versions do not have the fwnode attribute in the struct
gpio_chip, fill the of_node attribuet instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0112-gpio-fwnode.patch | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/0112-gpio-fwnode.patch

diff --git a/patches/0112-gpio-fwnode.patch b/patches/0112-gpio-fwnode.patch
new file mode 100644
index 00000000..5518884d
--- /dev/null
+++ b/patches/0112-gpio-fwnode.patch
@@ -0,0 +1,14 @@
+--- a/drivers/bcma/driver_gpio.c
++++ b/drivers/bcma/driver_gpio.c
+@@ -184,7 +184,11 @@ int bcma_gpio_init(struct bcma_drv_cc *c
+ 	chip->direction_input	= bcma_gpio_direction_input;
+ 	chip->direction_output	= bcma_gpio_direction_output;
+ 	chip->parent		= bus->dev;
++#if LINUX_VERSION_IS_GEQ(5,17,0)
+ 	chip->fwnode		= dev_fwnode(&cc->core->dev);
++#elif IS_BUILTIN(CONFIG_OF)
++	chip->of_node		= cc->core->dev.of_node;
++#endif
+ 
+ 	switch (bus->chipinfo.id) {
+ 	case BCMA_CHIP_ID_BCM4707:
-- 
2.45.2

