Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7412EBFC
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570577; cv=none; b=WjAHNsekTDJbTp88eWXF16smKQNWIm9Bzv3GuTjwBnz6q6EEg0zaz64n9M/gKLtAQigVJzMEsfq9UNq3O2CH8M0d7yAFrtYM8jS0TpQrRXLHPkzsVNSncyRyUxT6NU1AmkuOgve4QDGC1zLcgaqGn5oJQDlAfRhoNbqyJh1l0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570577; c=relaxed/simple;
	bh=2mpEvFOlKhYGMdexMDe5NNthZ4Z3RWRAQgCdSfymWWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpqJ2jndBqo+Ry+O72xb++f2dHwOnhiv/nbNwGhimivK1NHA0o8ZrGSZF6M63JahVEba6UtbAda6ZRQNEEjgbFFBNJvoRsTKEyCBb0FuzgKXncbiw4Qf9qlPLSgxbHYNo6+Mkk8w0/qz+QYw02FprLrp+1fnMaQpKLtA8W6usBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TMIHR6yv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TMIHR6yv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8Jn1VttkLBPnNhO1G/2xxqR9r+1V/r73MX7IoaxUxuw=;
	t=1716570576; x=1717780176; b=TMIHR6yvsImkTgh/Bn8M4xrHhPSWGBmyJv/v1+9oRXE+g5q
	ABa3K1QY60q5DdkBysP+yQHSzp2GJiEg3lc0V8eBdB5zu3DHoik1GYUFKW7jKg3ntJ8yPqiG0KJ31
	0NdLQM6WKQ0fgABSKy7JMltqny3wdE/YA+kGWoU0LLf+8cZ6s85cmd7jt6XoAxn7OcrdozvK85Uxo
	g5xAQGZo7uItPm62EtBzKxoTxSruV4wiOV35ztnzF5FkQF1N4cijkVpw2wkfdbOev41mjMFCb4kLY
	CCTjTiOu5vWwM8xw8cjZgdOt6fy1WFCE+JMXS0OPF2KvUZP5f2d0NVDYkDgTALvA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ9-00000008Xuw-1nFU;
	Fri, 24 May 2024 19:09:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 26/74] headers: add DEFINE_SIMPLE_DEV_PM_OPS
Date: Fri, 24 May 2024 19:07:38 +0200
Message-ID: <20240524190907.aa2f57d0feb3.I26bf7a2fd34b6c2fc26bf2163f219e0f71aa77c9@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/pm.h | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index 926b0bf15c8e..24d760fab33c 100644
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
2.45.1

