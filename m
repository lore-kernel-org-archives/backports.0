Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCA190678
	for <backports@vger.kernel.org>; Wed, 10 Apr 2024 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788114; cv=none; b=L95kt9uObSIRwRs8iBu/7tl9/+wrYIOp7EC1WoqqsxJOD6PP0LCrszEBL9CJ2e4+bjvEQV1O6ydDKc7dZcRvH4GEiVymZJjTEB3YfIbZmu0TJ9rnFQHReGSS5S0FwDI9Ew8KXejpOYO9ekcTDHvQeMSKTFJH5WjkXWORvQ17fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788114; c=relaxed/simple;
	bh=70KgiImPQCX7klkas+Y43L1TEyPDVdzSIQChRV+CmxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG2Vnouy7q5eLPuL2LYHv9K5Ugd+mkXh6Iffqo6MzfYKtHYnLW1cJqYwvvtb+fk3cX3Ms9Sl1jPo1MyGGMtpktDJEOzdLqoByQ/p+cthAl71V957voS8ImJdQ/xUYxPLuqp5acisa+q9Z4IdiCL71p+yXiT3y3HXpqh5sNJNeXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=LmFBownw; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="LmFBownw"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VFHMT6cbdz9t8H;
	Thu, 11 Apr 2024 00:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712787621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKRrEAXLYJAoGj/IpSblESDzDXkiK92fdDY3EIgZAhM=;
	b=LmFBownwZYAMo6/0J1HM/6LHVLNIJCo2l6m+dojYdWQ3S8Gp5Ij+QX7mp143BAVf6q0wHY
	R+HoRXMeCUl12pD9odRkHeMKQl7V3xqXN3lZTJVQW8YzfFkZAn34bySfpIHfhgMfUGXBGC
	SxxS58RulXg81h1USpRfHn//I4IH9Wg0q9AfvmHttIh1SkX6nmTKxjCU1Wg+/vggNp4Ool
	ikDJyjPUPc/CCcDJpOUC+rBz4ZJ1iH1eqJOcFHyha7AWlktAAWxC2/NDTbQwT+K0wQXJy5
	GA1VuQ2MmFV73XTur+FUdG2fDElawbp7knrF5q87OVox5BF6TIeKpE+LahTREA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] backports: Remove driver headers
Date: Thu, 11 Apr 2024 00:20:05 +0200
Message-ID: <20240410222010.1171249-7-hauke@hauke-m.de>
In-Reply-To: <20240410222010.1171249-1-hauke@hauke-m.de>
References: <20240410222010.1171249-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.44.0

