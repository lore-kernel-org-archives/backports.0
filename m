Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A31A38C3
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532138; cv=none; b=t91Q3SDunhWLl6v1170kBHFjwTzSXsO4hU9U1QobKnyzPokzYl90FEuxqyDzKqiWJHbxktVRiqiKnUTV1TTkyqIhtjb1vdrV63vu7qsyqINEbbaJDMEG6mpd0VnmCKP5k5w1c0ANULt5IuYw4jCUBqvUU1BTviyx7Qrg2Dk3QKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532138; c=relaxed/simple;
	bh=ors18Vlj2C3b/RvzJ9NuoFtkxXb+eFPi5G4Yyqjs/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLqFP2al5ushptI0KlZ8ddn/kxm3lemVOpv2Z1T6fu0vfupiKRXWFC3ykxijFk4bY10rYyBPisWny+lofVFXOn+PnGNCvmjhXIygM0HDBYyy2mZoEEA+8sE6opXjANohqV1UNCk2XgC/B4w71c0JVrf/XjY9Qx9zrWxsFzGQHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=HPD2dahL; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="HPD2dahL"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdd3lNNz9spZ;
	Fri, 28 Jun 2024 01:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd4UWgokUFnmD12KvB4WBc+b2D22WWVjzMYPGak2Goo=;
	b=HPD2dahLWp4SirE0ygozke9795FGxGBYoMdRTnLaDJFLHUh7RciJDkDrsr3pNYSS/Exnvi
	6/hTK5MTyFgFjxNwwS/Cj92NRi8RSZfoG8ywBZjvrMY5Rj73cH9tdnCf4O7zp9yl+Hq+yL
	8oNIFB+EOqbvY20Uth47x/4yCq8azQViiapZjfIXjRKR1sj8bAAKR0YAmngNCeGPA01F5v
	SSRw8XD/hXQWMq3/YGzrUbZ1MAd675nbB8sQ4c0tcIGKYR41Zqpp9Z8yvkjOIQ034rgzX4
	McE5LCe06hxq284QcYMW6Qu74EbgM9gQ83U0v1TuE5RLmF2EHda/J2tpzq37UQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 51/75] patches: Remove genl_family.resv_start_op
Date: Fri, 28 Jun 2024 01:47:37 +0200
Message-ID: <20240627234808.1253337-52-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdd3lNNz9spZ

The resv_start_op option was added to struct genl_family. It allows the
kernel code to do extra validations. Ignore this attribute on older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0109-resv_start_op.cocci | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/0109-resv_start_op.cocci

diff --git a/patches/0109-resv_start_op.cocci b/patches/0109-resv_start_op.cocci
new file mode 100644
index 00000000..dfca6064
--- /dev/null
+++ b/patches/0109-resv_start_op.cocci
@@ -0,0 +1,10 @@
+@r@
+identifier s,expr;
+@@
+
+struct genl_family s = {
++#if LINUX_VERSION_IS_GEQ(6,1,0)
+	.resv_start_op = expr + 1,
++#endif
+  ...
+};
-- 
2.45.2

