Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24012EBF0
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570566; cv=none; b=ZwuVCTEoUJQV7wv9f9HhNTckMvehpF04oYxSG6sLyceWsfKiic+qiqmphi/vvkGiY/2ihWGL1Fs98ZFWmDcfVsf/y/G2PbZgZ3osPp9bFhW4t25A0WJyz3PYD5r/2e8n21iWM5KqJop0d/J/ifHuuAFF0/cD1A4ocRstYDr6bSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570566; c=relaxed/simple;
	bh=qWgrdE8Lx75G/xLu7C4Wg+oU+VD2R4c7pfKvf2s5J8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vgk/yxva9FM9pqvp2HeWA7F4OBXki+UPq4X5RBh054Op9TX0RCQ/IEKBErGaECdcmFIFm0Zy1acxYFL90btxzK9LIxEmWShvUbD0HF2R6sewXd3JlbQ8OQof4Wj2uYlUcKV2JZ4FsJHHqhGvC7DSWczhtI8LzPXaG8HYlL9uVD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sYM6OnDO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sYM6OnDO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+KDukWUqtncEdvGZUid/QfWyHruKnJzTuW7I9kZJBwo=;
	t=1716570565; x=1717780165; b=sYM6OnDOBSzMVwAPu9NzMySLWFy4QMkxssClY/tbIsjwWqH
	gzXKQlnaOYwQyvxEhfDMLNrVpMazpx/urIZr76+pnckmk18yVchtWwRqFMcrYd/rjCNHv6Bl8kq76
	WAY8HuRSIyZDdL1MYd0ys/CH+z4gnqH8NURB8kCmNjXTgGMU+QI+L3V9SaqHV/TTo1cwLy2B2NBU3
	sYKprwI+fUSkNQB0iWd9bKxGbZhVaUwgjEGgJJnh02nklfYJ/mT3Q6qEB3YlASBzf5KXlOVbuJH7m
	yPcVK1lsh3o0m8AXRgkYa8/C10OcpFsRKNlHE3EPtDNEliVVW2tPt4rorUiBI9Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPy-00000008Xuw-3wZc;
	Fri, 24 May 2024 19:09:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/74] backports: add module namespace support
Date: Fri, 24 May 2024 19:07:27 +0200
Message-ID: <20240524190906.380cc851ca20.Id7fdad79d5130d44fe2e2bf5ea64ab10ec9f0022@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Add EXPORT_SYMBOL_NS_GPL() and MODULE_IMPORT_NS(),
for kernels that don't yet know about it. Just do
nothing about namespaces in that case, of course.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/export.h | 12 ++++++++++++
 backport/backport-include/linux/module.h |  4 ++++
 2 files changed, 16 insertions(+)
 create mode 100644 backport/backport-include/linux/export.h

diff --git a/backport/backport-include/linux/export.h b/backport/backport-include/linux/export.h
new file mode 100644
index 000000000000..c24c9f99c78b
--- /dev/null
+++ b/backport/backport-include/linux/export.h
@@ -0,0 +1,12 @@
+#ifndef _COMPAT_LINUX_EXPORT_H
+#define _COMPAT_LINUX_EXPORT_H 1
+
+#include <linux/version.h>
+
+#include_next <linux/export.h>
+
+#ifndef EXPORT_SYMBOL_NS_GPL
+#define EXPORT_SYMBOL_NS_GPL(sym, ns) EXPORT_SYMBOL_GPL(sym)
+#endif
+
+#endif /* _COMPAT_LINUX_EXPORT_H */
diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index efe970f174ed..b93a56d97611 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -67,4 +67,8 @@ extern void backport_dependency_symbol(void);
 	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,4,0)
+#define MODULE_IMPORT_NS(ns)
+#endif
+
 #endif /* __BACKPORT_LINUX_MODULE_H */
-- 
2.45.1

