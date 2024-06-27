Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3871A2549
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532142; cv=none; b=LAlJhFKWD15O7YhXvDzdU7usNuDoxMFQxpfvVSZhzwuaT17RZT4/VrEcZk94W1XVAJVLza17f0sYzXav5UAALIdYkj435nxF0LtDAsuDqfaKxmMza13CcSQ8ren0QT+LPnegew/ZbIT95urLqEwmDp9mcsc7X/y0hpU81Hkz9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532142; c=relaxed/simple;
	bh=nIpEjgLMo8JXbH5MsO0hPvNqq9vb9OnjBVEyzspZzP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUWsusZXAXsTQR5HuSLpL0AVIfIOsXEw6QhZJ0vIPCXCoCRWYDnEi+ewhkOekaK1TnuR0h7LOi+EFC1xODVcblUahNj8tRDRkjNIbOQpBrv+xPvugavaDMPg/MGuHhs60CoUCJ0fMooCxMyvfb/Flohv0dqgCXxZC6eOZCMPL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=RGO13GPh; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="RGO13GPh"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdj2wLGz9sq2;
	Fri, 28 Jun 2024 01:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ziBsfL6kFK0qah322Kq8jbb4phbFZfegNNG0yAz+ec=;
	b=RGO13GPhsqyWjJmiJ32OktcbtcVnJ+hCMOeTPWxQfXCD7uyaUY/aSQ7Y3AjGo91TCi9BOM
	Lw6fYvfpLOjZtsLvnC/4rRn34avskGXaKLNjcY/+h/mfyW9xUTM0gMCBMnsljJCCkiApUo
	iW0+z/BwzfDCpeuQ25D5qm5zp66+WWeitDqWk1yN8LzndDXf0ijpSe9FmK5yRp+a8C1Nru
	pmwIzJXl7xjV+pyXeWg5X9ZpyqPTISkX4ynrlrKat+dnea0QaPpHnNRH0arP0+WOa1oSam
	2iI8+Ya1qBIeiJOPNX6yDXISzdQl1poyrt1WrwQr5Vm/6n+Li4WEKo8oq/Sdiw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 67/75] dependencies: Deactivate mt76 driver on kernel < 4.19
Date: Fri, 28 Jun 2024 01:47:53 +0200
Message-ID: <20240627234808.1253337-68-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses the new skb lists, backporting them is more complicated.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dependencies b/dependencies
index ebe25099..e0b5bad3 100644
--- a/dependencies
+++ b/dependencies
@@ -21,6 +21,20 @@ AIRO_CS 4.20
 # mt7915 testmode uses skb_copy_header()
 NL80211_TESTMODE 4.18
 
+# skb list
+MT76x0E 4.19
+MT76x0U 4.19
+MT7663S 4.19
+MT7663U 4.19
+MT7615E 4.19
+MT7603E 4.19
+MT76x2E 4.19
+MT76x2U 4.19
+MT7915E 4.19
+MT7921E 4.19
+MT7921S 4.19
+MT7921U 4.19
+
 # Needs aes_expandkey() and aes_encrypt()
 RTL8723BS 5.4
 
-- 
2.45.2

