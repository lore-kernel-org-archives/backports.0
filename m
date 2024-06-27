Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2B1A3BB9
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532140; cv=none; b=eS80azcF37Z1odmr56T/KocCbjUgUQP0APQ1My6l7XNNwOrEDmt9ZZm1uL9YKCu32hh/H4s8tU4eFlI7liN+wd4RNT6UsQbnXjVcMVPvHE14f+Rf+kG22BSsOLNo3Qh57Ex4dgs7tAPc0ssti8+Kzat5jbNnAHIWtJbAnYLf4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532140; c=relaxed/simple;
	bh=1wY6m+b8xZrMnte2UUx8xrxt1XAuMLq+DHw6nA3maAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFiPe0NcIUCRVqvo/j33xbeAgOgs74TH9GP/nEn4eYTq78rnyqCVbz57TmSISpMIT3n0CsspWVJs0xMqqh89+8GURPK1g6P802bomM+agYKkhl/9TMGVMmJPvC5tRbt4lZ0Py7A77LeZJswQVdMcfvNWy/Y07W6m3SMbLgtjWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=i4ixkmWv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="i4ixkmWv"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdg1bwtz9sps;
	Fri, 28 Jun 2024 01:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp6sD75VkyGRM8IqHNOrvTM19foC2/LgmMQZ6pacPM8=;
	b=i4ixkmWvEDiOpE/LImgNTMC/GYOcvDZxOX4R+1wyON8uYPfljbHieNEIrDSAhInp64H41b
	POB2P5tyEAlsipQIcbek4cU8XVHNMvKOxRY6YR4XwbXvnUa+uN5lS1BnW0Wbp2txO5vkZJ
	1OiUCbO9ZF8pSDSN/DJPUPBFPKSTJ1DepqSd+AmcaUfAruvVK1jR4+KjTHUjRbCh2Nhdxz
	Gx5nvdibFe+1F35bxLp1oqE3fKhp8EyqMkBxwJ1gxAl3OM5Exegg9IPB1xs4WseVYVp2yg
	O4rmLBnlNLYbCAby0UGD/LbAnFutvAK/Ppy+dF0zyS7XwmeHOwy6Mf9vLX/JhQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 58/75] header: Add empty request_partial_firmware_into_buf()
Date: Fri, 28 Jun 2024 01:47:44 +0200
Message-ID: <20240627234808.1253337-59-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds an empty implememntation.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/firmware.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index c12ce98c..9bfe6e9d 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -22,4 +22,16 @@ static inline int firmware_request_cache(struct device *device, const char *name
 #define FW_ACTION_UEVENT FW_ACTION_HOTPLUG
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,10,0)
+#define request_partial_firmware_into_buf LINUX_BACKPORT(request_partial_firmware_into_buf)
+static inline int request_partial_firmware_into_buf
+					(const struct firmware **firmware_p,
+					 const char *name,
+					 struct device *device,
+					 void *buf, size_t size, size_t offset)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_FIRMWARE_H */
-- 
2.45.2

