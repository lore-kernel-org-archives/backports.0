Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36712AAFD
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532131; cv=none; b=a413uOzqYPpb+xIQ+YMcsioEpbvASACi86s4l8IpYzfpZKvaP8MXyDis44YhGmmb9QMFBJP4bcdfnHyycRkrqkSUiIIHu4IJ9FJyuyzpXbOYXSDW0oJF+Y9WKm+K9pGm7YZGX3KOSDVrasHhC9exSp8BhFJ84HgsR46VX2NdVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532131; c=relaxed/simple;
	bh=rUzaPpSlilMRpThYlOYQYxQGNOU7Gw6d1exYNMoROgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCWpbHnQOof70lyQMb2353v4N6g9AlnbveCZNCLtvywcFD0PEFwqfPAjst2VHz5g8+4APOg6A+EC26V0XGKR3D9xBDXX/U2Fli+Rkifz31Sd+S4i4802YYyqPky/sUJB6VWZbCYDBARaqIjd7JDj3rgmCNNluTbdogOTwUjJ7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=bqUNIBAR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="bqUNIBAR"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdM69Znz9stN;
	Fri, 28 Jun 2024 01:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvmYhMPe+VumyOf6K1dqCAxeh8EnPcDs+Dr+tDY1N1U=;
	b=bqUNIBARuXhSIKsYT65EDrrAKe9uNMQjKizOR58/7CMVYpPVlOJQLvYLmle3oz7BG/2Cml
	49PELdVC63ldDahmhXOW8NoxP4bD+CblKHMHHiQL6biMqHYsS7ri4Bcdgntg3Q2VkLsyK1
	CleoAWRaKMdhHypwNk/csuj2IvHMaBr+MUkoy/29flFHJtHeD/zRK6d5EvTA+P1BHLz1ie
	SFwn7Hk92YEJoxSkkS63rB/fLBeWzYI80TQnKVLVw/Ff+Bd7FOrEbKBWVhVJ5C3zVInXhD
	HxTcuLh6v4OBmWQoWTbMsisT/iaB/CPaBjqKiwhE2fK5WC1b/hcAjIIMLEPBSA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/75] backports: Remove compat/memneq.c
Date: Fri, 28 Jun 2024 01:46:50 +0200
Message-ID: <20240627234808.1253337-5-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was used in backports for kernel 3.13 which was removed long time
ago.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list       | 3 ---
 copy-list.hwsim | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/copy-list b/copy-list
index 30368c81..95a9b875 100644
--- a/copy-list
+++ b/copy-list
@@ -25,9 +25,6 @@ include/linux/average.h
 include/linux/overflow.h
 include/linux/units.h
 
-# crypto_memneq
-lib/memneq.c -> compat/memneq.c
-
 # 802.11
 drivers/net/wireless/Kconfig
 drivers/net/wireless/Makefile
diff --git a/copy-list.hwsim b/copy-list.hwsim
index b1b00bcc..cb013917 100644
--- a/copy-list.hwsim
+++ b/copy-list.hwsim
@@ -24,9 +24,6 @@ include/linux/bitfield.h
 include/linux/average.h
 include/linux/overflow.h
 
-# crypto_memneq
-lib/memneq.c -> compat/memneq.c
-
 # 802.11
 drivers/net/wireless/Kconfig
 drivers/net/wireless/Makefile
-- 
2.45.2

