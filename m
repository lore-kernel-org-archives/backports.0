Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93EA6F30F
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393032; cv=none; b=h3ETJsXXjhdW0G5qjrn1fWN77vL3rvXD7Be/sAVO/npaS+P6sBo+Sc6ykP8Zv7VKr4+TLTXl/dw9n57wcuI88rc8GlDBGRNYo+yn8iJsk0Flc2BKaql+H866rhnxk0RYVvik1c983u9wtPdFnWIxT99rOhkTlVxYyaWNxoxBF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393032; c=relaxed/simple;
	bh=E6UyvTNQEgZo5dBz3gTroEJbXWAOLjG++Zm5Ir+apuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgFLuDDiPYiTLpiH8qCszrpcAq/M9t6Uk9S6BUPddZqO4fmrZPmuEK1OeLfCViRE16b5Lt4y4uTtlxYog7mprjj28pDDN2ztimqZ19PJf+jxHWSXV+CiuWxgoN1dh4exQy/iCBYqxxojGBRPIdPkyzN7DWreNe0a91a4qwkWSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=UfurEwPL; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="UfurEwPL"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WHN195RySz9sk8;
	Mon,  8 Jul 2024 00:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720393021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrkY3yk3g1vtNZn7U8nb7YxYNrR4EtaC9Qk/kWzqlaU=;
	b=UfurEwPLQ2q3UKAa8+uq8THeFrottbKyzLWIpj6ugzU1W8jdWgybq6m5pIhqCthdzmSXxp
	YakbCALZ9znzYN0imyZQfL4caNZnYo3cAsR4n79W36YysOLl4ORbusWLILC/bmme13cYXX
	A+FCWskB/fbHTx5ECNgF/erBZd/XWCjXgKQMNLqL1Kl7PZT2T7BlUoydTOaIZYiej+G6+k
	nn0H2oE5c/W2QVBR/y7GR8wqJkdfcbuc7iy7jE3bsJHiH6NIUzDwIH5q8PbRxxDbcj2MpK
	XU0Kk5VnzGyiqlIHMOwxVO0soOICfcuZV9o/NrcqPX/xW/UYGVwg2INEMEW2pQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] backports: Add pureLiFi plfxlc driver
Date: Mon,  8 Jul 2024 00:56:45 +0200
Message-ID: <20240707225646.1924882-7-hauke@hauke-m.de>
In-Reply-To: <20240707225646.1924882-1-hauke@hauke-m.de>
References: <20240707225646.1924882-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the new plfxlc driver to backports.
This driver was added to Linux wireless in 5.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 2 ++
 copy-list                | 1 +
 2 files changed, 3 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 5cea894a..ebe64869 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -85,6 +85,7 @@ CPTCFG_PCI_HERMES=m
 CPTCFG_PCMCIA_ATMEL=m
 CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
+CPTCFG_PLFXLC=m
 CPTCFG_PLX_HERMES=m
 CPTCFG_QRTR=m
 CPTCFG_QRTR_MHI=m
@@ -148,6 +149,7 @@ CPTCFG_WLAN_VENDOR_INTEL=y
 CPTCFG_WLAN_VENDOR_INTERSIL=y
 CPTCFG_WLAN_VENDOR_MARVELL=y
 CPTCFG_WLAN_VENDOR_MEDIATEK=y
+CPTCFG_WLAN_VENDOR_PURELIFI=y
 CPTCFG_WLAN_VENDOR_QUANTENNA=y
 CPTCFG_WLAN_VENDOR_RALINK=y
 CPTCFG_WLAN_VENDOR_REALTEK=y
diff --git a/copy-list b/copy-list
index d4034486..18902555 100644
--- a/copy-list
+++ b/copy-list
@@ -88,6 +88,7 @@ drivers/net/wireless/intersil/Kconfig
 drivers/net/wireless/intersil/Makefile
 drivers/net/wireless/intersil/orinoco/
 drivers/net/wireless/intersil/p54/
+drivers/net/wireless/purelifi/
 drivers/net/wireless/quantenna/
 drivers/net/wireless/realtek/
 drivers/net/wireless/silabs/
-- 
2.45.2

