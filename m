Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414221A2FD6
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532142; cv=none; b=YJsf+otUDxlPKPO3db1gGXcozQ0+TjCVyYgd4i38+dpxXwvPPaRHBM3O68zsnfgSLDKkWnMSYcMseHEamN5HeQO5m2IKiVdbOQ1PptvyXEIeUYtdBp1DAxPYXy6945Sk6xDmAfGEcQzLCWu9zbDQRqFnzOquezNz9SLf/PSgscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532142; c=relaxed/simple;
	bh=d8/7PKalCEBb/PR4uJei/q64hL1dvbYotaFSkwauNWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLouXzrxx1gSPQt7a463dAti1cwGLf2bOpe3zl4xxqKPwRCoQflDvNxiH3X2yxa/ys53Hhe3LL7o23RogHWfukEtdmmHeuzr8+nEhTq3KZLaMciYKmB7qdv2HcWHfG6YzSwCbnnEJ6schZ8aEC3KAqDjYF1VSqVEZ5+m1ITGF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=y/uOL+8S; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="y/uOL+8S"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9Fdj6PDrz9sZg;
	Fri, 28 Jun 2024 01:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GK69fYTrH+nVfj9mJdrxev+oxhg+tG74X3hLKqx6Wc=;
	b=y/uOL+8SVuWOygns1KtlWG/FcEkeRp0/J76BVbM6wTxS23VQGUTPK2B7sjtBOD6nsLnjnR
	jKFy0ad6rO2kTHLqrlpDVCa4y7pwHpMGDQanDeDbPa3lZhAz/dd0BZ+PAl6reLIfJts49L
	gRyg/rbzRkD6t+wKKr8gXDKrya5quUxveC5xyabBdpl6pQnaRXkj/oEQ6+zkdyrhOECuV1
	wnJkK8BUrIKVzwNMQI79z0DfSa9J3dN2+mHoSDnhRwum0v/oyWLPTcZYWmNp0Q/jLBhXgF
	wagEmngzocSYdcKg5UAMpVNr6bsZuywMRe6hmDQmLGbg8MpCSI4lT2wHpSLD8A==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 69/75] patches: Remove additional DMI match in brcmfmac
Date: Fri, 28 Jun 2024 01:47:55 +0200
Message-ID: <20240627234808.1253337-70-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like some other matches on DMI_PRODUCT_SKU, also remove this newly added
on.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0089-unknown-dmi/brcmfmac.patch | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/patches/0089-unknown-dmi/brcmfmac.patch b/patches/0089-unknown-dmi/brcmfmac.patch
index dbd0337f..b6c95bec 100644
--- a/patches/0089-unknown-dmi/brcmfmac.patch
+++ b/patches/0089-unknown-dmi/brcmfmac.patch
@@ -20,7 +20,17 @@
  			/* also match on somewhat unique bios-version */
  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
  		},
-@@ -107,7 +111,9 @@ static const struct dmi_system_id dmi_pl
+@@ -96,7 +100,9 @@ static const struct dmi_system_id dmi_pl
+ 		.matches = {
+ 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+ 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
++#if LINUX_VERSION_IS_GEQ(4,18,0)
+ 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "MRD"),
++#endif
+ 			/* Above strings are too generic, also match on BIOS date */
+ 			DMI_MATCH(DMI_BIOS_DATE, "05/10/2016"),
+ 		},
+@@ -107,7 +113,9 @@ static const struct dmi_system_id dmi_pl
  		.matches = {
  			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
-- 
2.45.2

