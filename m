Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4212F59A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570575; cv=none; b=HsIzMTRGw1g+bSM0gY/oxE9bAvd7+zpseZGiZANgOY78K/3BoyVmzXoB6on7vOBUE66dIeS+Pc/DCa+siQoi7cg0ot1rmJguR7qq/UivWU231L4xP1BXtqxk6Qy3kEY9yrZLK4+6tsUQJIVLhX8TnAm6UoIRaR989xtKb7ubvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570575; c=relaxed/simple;
	bh=xHiCtdAO5C4z0MWaqyug9DiafFLPrhu9RMeE/Pwd9bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJ47FoNyHNL4P4OnB1hvdlYdXoh/mN1aCf1PmkpSxd69wqf0Fj/0XPEnS1pP1i4w33eF0dq9qklbAttJKKSuJrr9v1mY/8Qf8N0v4DTg1gc7pSZonGt+bW4iUpd4YuicDRg5wJUB0LSjfTaIO8QcltQY1J/EZVyGJhI/9Sj4b18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VBBx+Mlo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VBBx+Mlo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OHpuku/uG6fOiqGEzCbUT9BD3JIkFlwoE0UUa3ZFlqk=;
	t=1716570574; x=1717780174; b=VBBx+Mloob+bOLEQgUXxb+xPTszoFsYuegbmYUGQZCViMFP
	zULRRy1T6qqicnaQ7Nx5G1dypZl2BgGcz6sEYKKdhg5vWDsp6kwssT3VV4J7lWgm4X7nZdYQEVnmP
	PJm7IgSJO7m6va8468OEmmjYTC+HQL5u9YS6eCkTms4DdDoa9AQGJpC9iJrOd7LOmO7iUpcU5CBdy
	zXzae13dmI3bLpP8RJ8HwZC0uBoSNL3okC3sdx7TqnIO5K8IHC9BSx0U5yPgRCqeHKMpT3J6ctq44
	KqrsixpWjPwXc8ncDXF39FTP6aK51DRGJ6BRml2+QxcUXPKiM6N01pxJCeXbOioA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ7-00000008Xuw-2YL0;
	Fri, 24 May 2024 19:09:31 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 24/74] backport: fix __CFI_ADDRESSABLE use
Date: Fri, 24 May 2024 19:07:36 +0200
Message-ID: <20240524190907.c464b76f129d.I69530605b67444170edc2f42589f31b8fb89b3f0@changeid>
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

In later kernels, __CFI_ADDRESSABLE became just ___ADDRESSABLE,
but we still use __CFI_ADDRESSABLE. Since it's easier this way,
keep using __CFI_ADDRESSABLE but make it ___ADDRESSABLE if that
exists.

This fixes the issue that we get warnings about missing endbr:

  traps: Missing ENDBR: __exit_compat+0x0/0x20 [module name]

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/module.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index b93a56d97611..8269238c2cd4 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -3,8 +3,11 @@
 #include_next <linux/module.h>
 #include <linux/rcupdate.h>
 
+#ifndef ___ADDRESSABLE
+#define ___ADDRESSABLE(fn, __attr)
+#endif
 #ifndef __CFI_ADDRESSABLE
-#define __CFI_ADDRESSABLE(fn, __attr)
+#define __CFI_ADDRESSABLE(fn, __attr) ___ADDRESSABLE(fn, __attr)
 #endif
 
 /*
-- 
2.45.1

