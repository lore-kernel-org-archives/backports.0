Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB012F59D
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570568; cv=none; b=QINh1VbR2kAk4A7IcjHvcSsfWuCn2DddihdX2fiSFeyNpfL5YIVCpDsm+0CxkiUv2zFhqAD02/0F0uCmmM8FRf1/pNnexrKz+Ug7MYOrxemXLFClCUVylexD9KYXb1r2g9rg7euthK9uHURDccZhY/9WiORjeG/RoMR3Xw9u7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570568; c=relaxed/simple;
	bh=6Rmp78lf2Y/N7MJjADIzVtqaRj6V5ie9DRLf+8IZQbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9Lvh0FKqduaq0blWCej15vsOBCzpimOxE574s4uMHYvKuPTmIsNEYzJl8ng8l4KbXUaSAZYVCpEWPPFmseeosWC9stLujtsvi7q/p/hndb4VnsU8kQyeydjpbuZvBVYU4wFBT5etn8Z8V8ibtitwS00RzSCWlsqutQwl8yq5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xvb095Yc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xvb095Yc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W/2Wjuf2k62l1jx2SgtLtsurmLHPfvDCPgd8JWsUHb4=;
	t=1716570566; x=1717780166; b=xvb095YcaZtiE4MPLqTZk6LHI1e9p6sDgHcuOe9FMniVCRe
	vyX7xHiI8AT2lQMHiqi5UhS5lzZo1Qd5GTazI1uMnJ1ViuCh0QVn5h/IZkjznUSwstOJF5YE2WSCV
	hVvU9a8dyZiuegK6juRyFlR1TU0JoHY0ZQhBQzK0h1eM13/IX8lvMaswtQZrq/gLvdhc8YyLTKsmO
	4Mgy2U8PPWqOsnvK/G9wRYjrGf7giA16X6heVZxSa6WeNJm7kSLUSiFkSDHaPUODhc2yO267Gwt1E
	/WxzChFl/p2L3d4LFNmFeeFC8Z/j5gvLpVSIO1exKBIIqjKoxJYWZi08slWCmiGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPz-00000008Xuw-3p0r;
	Fri, 24 May 2024 19:09:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/74] backports: define __is_constexpr() for older kernels
Date: Fri, 24 May 2024 19:07:28 +0200
Message-ID: <20240524190906.1835c4614254.Ib82d1b3349ab6fc55b5f17dba1ada60601dcd742@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/kernel.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 backport/backport-include/linux/kernel.h

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
new file mode 100644
index 000000000000..b59971fbc1f0
--- /dev/null
+++ b/backport/backport-include/linux/kernel.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_KERNEL_H
+#define __BACKPORT_KERNEL_H
+#include_next <linux/kernel.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(4,17,0)
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+#endif /* < 4.17.0 */
+
+#endif /* __BACKPORT_KERNEL_H */
-- 
2.45.1

