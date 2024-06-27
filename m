Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EB1A38F5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532139; cv=none; b=Trr6G0Nfjm+WFyw/LF9Z00vglpuE2GGt77SfqAyldk3K8QAQhsMc5i3BhYvOLFGIivZxS6eSDIJHITBHVZM2U3/h5nOCbMx9yoMVc6ISmZEJgsR0vly+teY4S6oMyUw/0IQmepqft7O61YRDf4yYtJlkE1X6kAAT7+ewuooU/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532139; c=relaxed/simple;
	bh=pfK7MmdD3i13fGtbQOxdLWVCVnfCJ6/WUYBvsm3q5jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVdg0Qi2jYYfU14xswG7GKAzp3PlK7l0rPZAvldqHwE4MuqGAwd6IY8ALbMpTB59bIY+UiVrUIFyWYl8Xqf8mUH1+fqgmMyOQeae/pXhYqaH4EAAzN6fZ4jmmB7Xd4iX7AGq3vAcyZlzSljJdYaI9f5Ob5YOMKnrT6dxJyKQQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=OGOA4CVb; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="OGOA4CVb"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdd596jz9spb;
	Fri, 28 Jun 2024 01:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XLyS3sXQnIRq2RWypXi50C87IPGl8SIrWlmw3fWa2k=;
	b=OGOA4CVbOlzampdoAKjxaIeqVusILq7h2KCR5a1Kd1DMwnvB31XAz1AgEYTlRpT8CE/bmg
	rmXNk4e/eVygqdu06w5kHpfOL7pDrKkbAqvrWkBLtu3XAH8pMjmiOOPlVH2iZ2QztGPjfA
	EsVgILcEV2lml2f+TgqKn+kjzGjR+F3x8wY7EU19U7ID8AI6WbVrRpZzgNirshm8Fenech
	s8zQGcwSWMYXJZmOXwH/AbXPCZjz5d56lWKF1AfjjSBTfIJEADmaZ8GMvj5yyTuqoNg6uM
	9EpidqfjvHWOUx5kfMWZEPQbibJFD2I1QuDnPtQBIWoG4XhSmZR/FNU7h3EGsg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 52/75] patches: Adapt struct msi_desc reorganization
Date: Fri, 28 Jun 2024 01:47:38 +0200
Message-ID: <20240627234808.1253337-53-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdd596jz9spb

In kernel 5.17 the anonymous struct in struct msi_desc was extracted
into a own structure. Make the backports code use the old structure on
older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0110-msi-pci.patch | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/0110-msi-pci.patch

diff --git a/patches/0110-msi-pci.patch b/patches/0110-msi-pci.patch
new file mode 100644
index 00000000..128922e6
--- /dev/null
+++ b/patches/0110-msi-pci.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/wireless/ath/ath11k/pci.c
++++ b/drivers/net/wireless/ath/ath11k/pci.c
+@@ -451,7 +451,11 @@ static int ath11k_pci_alloc_msi(struct a
+ 	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
+ 			      &ab->pci.msi.addr_lo);
+ 
++#if LINUX_VERSION_IS_GEQ(5,17,0)
+ 	if (msi_desc->pci.msi_attrib.is_64) {
++#else
++	if (msi_desc->msi_attrib.is_64) {
++#endif
+ 		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
+ 				      &ab->pci.msi.addr_hi);
+ 	} else {
-- 
2.45.2

