Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91576F30C
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393031; cv=none; b=FAtePwMCs5OYq9juesq5xbfQ+wH4nxcy4hsF4JywZgmJtrFZWm7a7Uyf08rqdvo+VyVAdN6jVVOr3hyz9DR3zyLf/00o3VQRma3QfO3xSVbILt5wYVvVyIR+xTXv6v7hLkUKQYJEmlW9p+L/kBSKnH7nghhPN8XtVy03dgGQ3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393031; c=relaxed/simple;
	bh=vwaR2lyVMOw/NYVz4JwC328iAz67MsO3ehvdAl6CcRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIbJdbBKr/nUxYDZ44wohJ63cckPBFdFlaIjNDKZ5CBPn5YvK+2qYZRXqFGS0kMiOz4T1SE1YxuvCbR24rgE1SLFQnsSwc7gpQmXhgwX/ujhKa1k0uQtKDcNMB9fKW15VIycHtMuBrusC5TDmfmXs+tHeklNjDcaHENnEoxTdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Bojjbi7s; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Bojjbi7s"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WHN176V05z9snn;
	Mon,  8 Jul 2024 00:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720393019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LhPFfXn+Tb0lKi9X5dkF7UIebgEa5Kc82OznFmV0nvU=;
	b=Bojjbi7sxhFR0Q/Nbud1xE6PixL3DE3HE6/sxxXCXeRidM3NxylYQjrK/6DsMl+fCn8KxM
	RGqLDi4X4nCECb4gTuveokBVMvdFmJgNaYpXV2Je87cznD2XL7nunZwxRjwQ4vpB4TFZQv
	bktWQeBeHLlNQ79278fxE3BAbqocMVjWl0L8PpwZTrrGuaoRzpD/V/c3ZN3he8eFnQY87X
	4qNvSCYiTPI32gVa2WLHTpMgy6cC5Lhn9bUbGnk5x6NZgj6FEBGo3gNc8gcYwWnNQCsEno
	A8Heo5Cge0qyI7OW+x3kpz3Gq8oPVY0P2RJP8yi2juP6o0yUHmbXGvMFULFFQg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] defconfig: Add new Mediatek and Realtek drivers
Date: Mon,  8 Jul 2024 00:56:39 +0200
Message-ID: <20240707225646.1924882-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new drivers added in 6.1 from Realtek and Mediatek to the wifi
default configuration.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/wifi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 774b0823..2f86cd03 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -70,6 +70,8 @@ CPTCFG_MT76x2E=m
 CPTCFG_MT76x2U=m
 CPTCFG_MT7915E=m
 CPTCFG_MT7921E=m
+CPTCFG_MT7921S=m
+CPTCFG_MT7921U=m
 CPTCFG_MWIFIEX=m
 CPTCFG_MWIFIEX_PCIE=m
 CPTCFG_MWIFIEX_SDIO=m
@@ -124,6 +126,9 @@ CPTCFG_RTW88_8821CE=m
 CPTCFG_RTW88_8822BE=m
 CPTCFG_RTW88_8822CE=m
 CPTCFG_RTW88=m
+CPTCFG_RTW89=m
+CPTCFG_RTW89_8852AE=m
+CPTCFG_RTW89_8852CE=m
 CPTCFG_SSB=m
 CPTCFG_SSB_PCMCIAHOST=y
 CPTCFG_SSB_SDIOHOST=y
-- 
2.45.2

