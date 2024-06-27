Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1A13F42F
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532132; cv=none; b=WOIsq3dz3Rnn41oHF5Tx0wkBRs1oiU8XcF07LS5Iv8dc2WxzFNHKz+H1TnYKMKlz1hVT4VMYY+2PqHZ4YWTZA8Gg1DvFbSNV+WlPqkzkdPVCDfVddIifjGk3nOJHB0df8Bdyrs7pVWdCc09vv54CpQ9PrgqNhFQBUhdsyZxaE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532132; c=relaxed/simple;
	bh=5CtmqWXjb4mFp7EnJ2Zi0vNajzF9igNFfNE+H/kZvqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC0U0p8a5YhNgXihRfUZGs5OVj5ARmpAAa0lzrYr60HoJNOCCHYglYlcWfBev85lwBUuWRx6clY410sus+SwPB2XOTjwjpkWMCkTkS2j04yO+4TefhICug8+MApdbzCa0pUAfseJb0W+sZJVki8gAERcN8pNppF6ke40Vn9CplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=zsJQX43a; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="zsJQX43a"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdN2pvHz9sR1;
	Fri, 28 Jun 2024 01:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3rMDxQK5NfWcI6onlLYx9eBNx68oUPL08OWhuYFyYI=;
	b=zsJQX43a7MfKPyTv0pU1peutfTLYLRTECETdi3hOdb3l4syOq+uIyG8uKN76KlEP+fFjXp
	ddO45tarbLRt4d5HGPwiy/SwusOgcYfOWKfefKBon+zXGtuw6vYLhoGYDz6bjxecJ3TxEq
	vQK59bu+cetcOZHqJXJm2AsIXqkoKcUzblxNwZjX1e7+sVdiFE5DyOGBmq96AD74Z3r3k6
	avxCAg39mNRgcicMLK2K24TQN7gPk3TZE9GCvIFimgiqYH4BMzILsBFL32t2gsuoNnZe/F
	zl4g0c+aoHHHSZhDGB2yaoTPw8PQ3YbnFc7MeLHBkdBonXgHqJqiXWK7YJTDcg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/75] backports: Remove driver headers
Date: Fri, 28 Jun 2024 01:46:52 +0200
Message-ID: <20240627234808.1253337-7-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdN2pvHz9sR1

These header files is not needed any more. Kernel 4.14 provides all
needed definitions in these header files.

There are no changes between the versions in 4.19 and the 6.1.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list       | 6 ------
 copy-list.hwsim | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/copy-list b/copy-list
index e998cbe3..9ddd4fee 100644
--- a/copy-list
+++ b/copy-list
@@ -37,10 +37,7 @@ include/uapi/linux/qrtr.h
 include/trace/events/qrtr.h
 include/uapi/linux/pci_regs.h
 include/linux/mmc/sdio_ids.h
-include/linux/ath9k_platform.h
-include/linux/wl12xx.h
 include/linux/rndis.h
-include/linux/bcm47xx_wdt.h
 include/linux/usb/usbnet.h
 include/linux/usb/cdc.h
 include/uapi/linux/usb/cdc.h
@@ -48,9 +45,6 @@ include/uapi/linux/usb/cdc-wdm.h
 include/linux/usb/cdc_ncm.h
 include/linux/usb/cdc-wdm.h
 include/linux/usb/rndis_host.h
-include/linux/spi/libertas_spi.h
-include/linux/platform_data/brcmfmac.h
-include/linux/platform_data/net-cw1200.h
 include/uapi/linux/nl80211.h
 include/net/rsi_91x.h
 include/uapi/linux/virtio_ids.h
diff --git a/copy-list.hwsim b/copy-list.hwsim
index 47c07b08..5b66c917 100644
--- a/copy-list.hwsim
+++ b/copy-list.hwsim
@@ -34,10 +34,7 @@ include/linux/ieee80211.h
 include/linux/pci_ids.h
 include/uapi/linux/pci_regs.h
 include/linux/mmc/sdio_ids.h
-include/linux/ath9k_platform.h
-include/linux/wl12xx.h
 include/linux/rndis.h
-include/linux/bcm47xx_wdt.h
 include/linux/usb/usbnet.h
 include/linux/usb/cdc.h
 include/uapi/linux/usb/cdc.h
@@ -45,9 +42,6 @@ include/uapi/linux/usb/cdc-wdm.h
 include/linux/usb/cdc_ncm.h
 include/linux/usb/cdc-wdm.h
 include/linux/usb/rndis_host.h
-include/linux/spi/libertas_spi.h
-include/linux/platform_data/brcmfmac.h
-include/linux/platform_data/net-cw1200.h
 include/uapi/linux/nl80211.h
 include/net/rsi_91x.h
 
-- 
2.45.2

