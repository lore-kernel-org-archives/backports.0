Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA881A38DB
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=LoPtjrJi0YHMAEK9SHBIS8cR9+l2pMvTfGHo8fa61iDQGOZ3FbNGIZQ1m12a2WSupUzhQPDQ5UoudZ0nUvSW+2scXLIkQh8/xcPKAFUccLygOLRaMe204f0Ieo28RwRTq41sNR5bx+Iico7mw15zdZcwxk/VB0AS+s3RbOyP3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=udWniBoVkV39m+U2fpUcNuWRc0fvPqISYYymWZtdvxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe2Hh4+iVf+Nt9ytlaiKrdI8OJnHATm+8iLyVp8xZCAni+YbczwvO1bZlrfIZTDJzhQHpXATL51GyuQl22Y4qxk2wAZ4b5Ktn59PeyyUf10SZUBkUi9OX4M403e2GFT5Tiis2WHuiyCMoF+4bschhpBSB2Tp3pSlCT/k4zLtVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=UXPRrkX1; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="UXPRrkX1"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdZ16vfz9sy9;
	Fri, 28 Jun 2024 01:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k378w0NJ8v5U5s2cuV2jU81erPavnSzhs/KWdMpx7Dc=;
	b=UXPRrkX1pVBWxLrpr7RwHA0WkWBt3omLvQNfiLVQHW9AXuqvsxq+nqTHVoH38DOgp/MpX/
	ymHCMc1yhXxGHwJu1UuuX2uJEg3C+cr54dpajTosP6jkh/uhfOyNtgt7EvKYXE1+FeD4OE
	5ha4T+nkS/eiaJR1wjdxHIg7wWW85tgozYrtPTUXlBiM0c+aTz8fr+eph5OyQZ+SMZ4rJK
	lIIsb1VlY+2oeOG5gBZ1Qu9OFANqnj6B9eyMRn78b//4OJvb5WHF4MnNcmg28DuaezImgx
	BynvTv4Iou8CxL26me1qaKiHgIyvHYSnZaomhaOsxbMWH7Doh9Nwpro38dONJQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 37/75] headers: add DEFINE_SIMPLE_DEV_PM_OPS
Date: Fri, 28 Jun 2024 01:47:23 +0200
Message-ID: <20240627234808.1253337-38-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdZ16vfz9sy9

From: Felix Fietkau <nbd@nbd.name>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/pm.h | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index 926b0bf1..24d760fa 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -14,4 +14,34 @@
 #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
 #endif
 
+#ifndef DEFINE_SIMPLE_DEV_PM_OPS
+
+#define pm_sleep_ptr(_ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (_ptr) : NULL)
+
+#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend = pm_sleep_ptr(suspend_fn), \
+	.resume = pm_sleep_ptr(resume_fn), \
+	.freeze = pm_sleep_ptr(suspend_fn), \
+	.thaw = pm_sleep_ptr(resume_fn), \
+	.poweroff = pm_sleep_ptr(suspend_fn), \
+	.restore = pm_sleep_ptr(resume_fn),
+
+#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend = suspend_fn, \
+	.runtime_resume = resume_fn, \
+	.runtime_idle = idle_fn,
+
+#define _DEFINE_DEV_PM_OPS(name, \
+			   suspend_fn, resume_fn, \
+			   runtime_suspend_fn, runtime_resume_fn, idle_fn) \
+const struct dev_pm_ops name = { \
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
+}
+
+#define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
+
+#endif
+
 #endif /* __BACKPORT_PM_H */
-- 
2.45.2

