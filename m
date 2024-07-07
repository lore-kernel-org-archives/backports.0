Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643946F30E
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393032; cv=none; b=QlFXN67gG4mCCfIQ2PUsA9X8qj2o2hM9OQWRU5i2vLreOf032cNf/YgSdWpd4ipP0FLEoTY4Mv95ePl0PZrhlTcWCzXxE/vzfcjUXv6d64QvCy27/HwzYGmz3a4qbqjWfr5nruXLtSesD+nXaW9plWUvHykN0HUkASnxngTPgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393032; c=relaxed/simple;
	bh=n0yVtbry8EuNdF5Vb4ze2EOD7rEUxBFJOZtpeDyyLzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV0AmYrFyNmdkEN+dO1Ai2zLU8ML+0lE5rROif7q2myS+YTGNsl+IcxI8+iYYoxE8Q5CCfIoTMaHh0U4zr6X9bXw7EOHNDxeIpWuDYCl2Su41Wyw39Ri/Hzm+esrXkvBm0FX/buW0wFEkJP7oEw0/74RjQcwCh4bvTlBsu5ciyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=FBCNH5Ow; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="FBCNH5Ow"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WHN1964Ltz9sqZ;
	Mon,  8 Jul 2024 00:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720393021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaFUmtVreVoQML576CwpvTVPPV4xGG9gwg4W+RbWIHY=;
	b=FBCNH5OwtHHkhtSXSeyOGRwiHFJiaWnmhw1k0YO6gYvjjpKsqGMST4DUl3JiMbWFDoEYJP
	hIJl9Z5rsVxk6hIoLfGlxgGKEoioMau9MOjuMtE8aQtGu2WQW4YZDL1MT1IABil3ZqQ7Mm
	m0IfMehTwGCijbDZpURbEU9+k2aTMl3aoVseq4tIlquHUjujrIvfEnz52T6efqzfgcFYWI
	dEbmpQUs8QRJUVEjJVn1VY3xZal0eLc77GZJm1Y8V/q0NSpLqEeYnWDibm3ohL8toC1Tel
	iVw3Opw41lNaXHlC5IUdI1UoZ5xQSHwT1jy93WrFjPAlouRnNZU+aH20If4h7w==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] backports: Add VIRT_WIFI driver
Date: Mon,  8 Jul 2024 00:56:46 +0200
Message-ID: <20240707225646.1924882-8-hauke@hauke-m.de>
In-Reply-To: <20240707225646.1924882-1-hauke@hauke-m.de>
References: <20240707225646.1924882-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the Wifi wrapper for ethernet drivers to backports.
This driver was added to Linux wireless in 5.0.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 18902555..4d09f0fb 100644
--- a/copy-list
+++ b/copy-list
@@ -99,6 +99,7 @@ drivers/net/wireless/mac80211_hwsim.c
 drivers/net/wireless/mac80211_hwsim.h
 drivers/net/wireless/rsi/
 drivers/net/wireless/rndis_wlan.c
+drivers/net/wireless/virt_wifi.c
 # rndis also requires some of the USB networking
 drivers/net/usb/Makefile
 drivers/net/usb/Kconfig
-- 
2.45.2

