Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138651A2FD6
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532140; cv=none; b=P0HHU1akWpGGvmKRwpb2CkQ4pjf8aYVwJXVBxnq3WQclW3zC5GnTPkl+fYNJbXQP2ytwlkhe1an2UE9VFr/1Q3k+UtoEZ2dxeWIWGgxl/bvsfjoFfCUQVFTXGAfF9D6t5ewriJKsVFI2sf18wPYhkRByao0YADicI/U4qoNGmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532140; c=relaxed/simple;
	bh=T6ufCZvc33fjvQ4d/EyiSH4IL4fSPqv6KEUcr9MV1r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nof5QLY3OyK/RsM8s3ZWoJnjv3sVfN3Q10KgJAXlmKMX6c3LdwNg+xZ/h4aoqpBgdG3np8xiRXba/RY3pkAU8D6u+02RMBa6gJEzLD4DcnA873YsagJWMfl6vQoYbQZtZAbrIyLoP3E5QYsCcKXcn2IqBf1jy41tnN61l/10tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=R5dMvU/5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="R5dMvU/5"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdg4qMtz9srp;
	Fri, 28 Jun 2024 01:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oy8pk31SWPFX6/Iw0jrqtwgS/lsphTz/M1t+RuTR2SM=;
	b=R5dMvU/5iSfVYUlrH2cC6vMCcbzVseas6q8qpK9984og3a6GaBNfUTIdTWq2OjqJksvBiY
	eK74xwq3L65zleLwNR6eu/ncF+jFjXKqBFGH8KufUH0bb/QCIs/yDvGf4Xlwl76Xg/wmmv
	7bFTGrDSI+3rMUgODdwdEC38wP0u8oSj53VWdxiCMyVPLnsdDshfPVozn5P9kwgZFnHB2Z
	tcLXm4lQoeTi4RBekacE34oxG1Ym2G/b5zYR0l3unqw1tySjQYdL+wBNpf38LIADPa1NI+
	pETwwV5Nt9isrG7St/vshBAcZjbAqvcntERZsVzoOGx8RA2fiY3nhGQYegZ5iQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 60/75] backports: Add sysfs_emit_at()
Date: Fri, 28 Jun 2024 01:47:46 +0200
Message-ID: <20240627234808.1253337-61-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs_emit_at() function is used by mhi host driver.
The code was copied from mainline Linux kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/sysfs.h |  9 ++++++++
 backport/compat/backport-5.10.c         | 28 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/backport/backport-include/linux/sysfs.h b/backport/backport-include/linux/sysfs.h
index 7126fb03..5fd25c9c 100644
--- a/backport/backport-include/linux/sysfs.h
+++ b/backport/backport-include/linux/sysfs.h
@@ -10,15 +10,24 @@
 
 #if LINUX_VERSION_IS_LESS(5,10,0)
 #define sysfs_emit LINUX_BACKPORT(sysfs_emit)
+#define sysfs_emit_at LINUX_BACKPORT(sysfs_emit_at)
 #ifdef CONFIG_SYSFS
 __printf(2, 3)
 int sysfs_emit(char *buf, const char *fmt, ...);
+__printf(3, 4)
+int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
 #else /* CONFIG_SYSFS */
 __printf(2, 3)
 static inline int sysfs_emit(char *buf, const char *fmt, ...)
 {
 	return 0;
 }
+
+__printf(3, 4)
+static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
+{
+	retur 0;
+}
 #endif /* CONFIG_SYSFS */
 #endif /* < 5.10 */
 
diff --git a/backport/compat/backport-5.10.c b/backport/compat/backport-5.10.c
index c3a7b7d3..c3b8e336 100644
--- a/backport/compat/backport-5.10.c
+++ b/backport/compat/backport-5.10.c
@@ -79,3 +79,31 @@ int sysfs_emit(char *buf, const char *fmt, ...)
 	return len;
 }
 EXPORT_SYMBOL_GPL(sysfs_emit);
+
+/**
+ *	sysfs_emit_at - scnprintf equivalent, aware of PAGE_SIZE buffer.
+ *	@buf:	start of PAGE_SIZE buffer.
+ *	@at:	offset in @buf to start write in bytes
+ *		@at must be >= 0 && < PAGE_SIZE
+ *	@fmt:	format
+ *	@...:	optional arguments to @fmt
+ *
+ *
+ * Returns number of characters written starting at &@buf[@at].
+ */
+int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
+		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
+		return 0;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf + at, PAGE_SIZE - at, fmt, args);
+	va_end(args);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(sysfs_emit_at);
-- 
2.45.2

