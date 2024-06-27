Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16171A38D8
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532137; cv=none; b=WQDgLY5VcYXZYrAoQHrMeGDChfVq2494q2fCsTtFV8cTcTaEQ5u3va+j2r8w5t9fQvZBtU5bvhODhKSb+AiHokJwFN3UHd4Opr0D9zfe11df6+SVhg0tFJEY+mYJ96QhxlQbwnXmEdSexVaPLP1hQV76V8TJVZ76CKIjG5yjWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532137; c=relaxed/simple;
	bh=KVz5D0B8aUAhathiDay3sC2K8036sUfxg3RaNiDT3cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgDnXsh4JnIf+FKPZ9v2uGHeht2EcoeQlPG8w+/Alr83Uyn2n4WcvIoO3YcgA6HU3IKXI6l30YKbjzRNcqeUwgoo4flRxe6PmybFdeNucKkFj07HiddKcMmWclekFrZ+oDNymoVKlQRIypJ5w4XeQfdktmPm6zr8gp9vRCqLsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=oqfJo9Z+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="oqfJo9Z+"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdc35Rzz9t2D;
	Fri, 28 Jun 2024 01:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XLfeTJB0Xw4W2awaoG1ditKD5ZPGbs5Gl0jR+ygr6k=;
	b=oqfJo9Z+mxjobc8sHE51/YNkmiXuMTFfYhIy5j5MeRlNLQYS0C6jZAqf++NN6pwdoP1279
	mpxWvHvnhmA5zfS9pK2iWKrNvG/3/oCDPkmePIX61kQpFYotusPywmts+xzu3BtW5pDyY8
	XPTJfeuShfF/ajA/5NLOh62IUumGykg7+mUWUCRBXXWhkw6Itj5jVk1Kr+awdMNLNbJQKQ
	r/yjqDQxCs3LW8hgANDKm4u5uZ8RRCDh9yyFYaJ+KTmXHnOkKMKYsV76hzV1EtnUANJST1
	lCWtUUy02UO0Ugjd5Sqvus7inbM7Z9Ws/KISFZWdvGbkh++Wx6JckyvrRY/JVA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 46/75] patches: Handle changed spi_driver->remove signature
Date: Fri, 28 Jun 2024 01:47:32 +0200
Message-ID: <20240627234808.1253337-47-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdc35Rzz9t2D

The return type was changed from int to void. Create an spatch to handle
this change.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0108-spi-probe.cocci | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 patches/0108-spi-probe.cocci

diff --git a/patches/0108-spi-probe.cocci b/patches/0108-spi-probe.cocci
new file mode 100644
index 00000000..35c32e26
--- /dev/null
+++ b/patches/0108-spi-probe.cocci
@@ -0,0 +1,27 @@
+@r@
+identifier OPS;
+identifier spi_driver_remove;
+fresh identifier spi_driver_remove_wrap = "bp_" ## spi_driver_remove;
+position p;
+@@
+struct spi_driver OPS@p = {
++#if LINUX_VERSION_IS_GEQ(5,18,0)
+	.remove = spi_driver_remove,
++#else
++	.remove = spi_driver_remove_wrap,
++#endif
+};
+
+@@
+identifier r.spi_driver_remove_wrap;
+identifier r.spi_driver_remove;
+@@
+void spi_driver_remove(...) {...}
++#if LINUX_VERSION_IS_LESS(5,18,0)
++static int spi_driver_remove_wrap(struct spi_device *spi)
++{
++	spi_driver_remove(spi);
++
++	return 0;
++}
++#endif
-- 
2.45.2

