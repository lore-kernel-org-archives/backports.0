Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799E12EBF0
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570564; cv=none; b=B+AhsULnU9nwq/W+i1wagQT6LeS8i4gVrgQ9+us/6qyXzBVuOEcZA6esUT400r4Gn/d83EO/H5A/94LSxNcycWyLRIhR9uhToNRuEfsr66Tn1uqEbhmJLAoyCugel4fc96Txal1JcKI0lPCrJ9WJkiCbteIxLIVdgFQs3c68VXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570564; c=relaxed/simple;
	bh=1Qa/oNLyQg3W2BWUrvv5ChMwMgHl/2Fh9YjhdeDk8qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlsESM9bpaalNLw6rT8ZDibliZTifWjseRUF1ptsKYwM3qb7UrvRCAY1MLREnJZMFbTy+aqSCrKsSf2WATFj5orb9/7dMXAfv+3bbV3Ir9gXIQ8zZvFpSUiEiVskQTNm/jimWeM1OKzDhu6cP8Rim75ALyDN2eGeedpWYyTmAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QPHdJ1lz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QPHdJ1lz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+kpCoH1kWYibCrZAeezSH9RTk90qBevpmBhiX4wePCg=;
	t=1716570563; x=1717780163; b=QPHdJ1lzUMggiUg1Hps8EkISgjusXVJrNy16uIN1J5qoWFC
	g+5K2l7ju7H9mKnTpUK4lTUDVFuoVtsOjo7VvAxOmhSJFDycEuQDMkTqbiVzv/fQeoTsbZ35rJ/OJ
	Fy6i/BXYcOvfwzTb5n0naAeuaQQ0QS4MvZy0A/uxUmRVbLsDo+0SQyphSu+ATi1FFJFoJViq0IvB2
	257fCzLRUQvs33iLSpmNeVJRW2Wnb4VLuCebDNfYyVGT/8RFup18Wb2dJhoufQTFiXxgWN6mVBntd
	MOl5rgMX4VIJ6IuSCAI/lRxkoOsPQ8sGdcG4czN4fDxPxl2pNn6/IOn2BtgukHLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPq-00000008Xuw-1Ck7;
	Fri, 24 May 2024 19:09:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/74] backports: add crypto/utils.h header file
Date: Fri, 24 May 2024 19:07:17 +0200
Message-ID: <20240524190906.35087ebc437a.I1032c7966d32d27d2d28aaa95f8393b87bda567f@changeid>
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

This adds crypto/utils.h header introduced in
c616fb0cbae8 ("crypto: lib/utils - Move utilities into new header")

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/crypto/utils.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/crypto/utils.h

diff --git a/backport/backport-include/crypto/utils.h b/backport/backport-include/crypto/utils.h
new file mode 100644
index 000000000000..aa55df78a398
--- /dev/null
+++ b/backport/backport-include/crypto/utils.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Cryptographic utilities
+ *
+ * Copyright (c) 2023 Herbert Xu <herbert@gondor.apana.org.au>
+ */
+#ifndef _BACKPORT_CRYPTO_UTILS_H
+#define _BACKPORT_CRYPTO_UTILS_H
+
+#if LINUX_VERSION_IS_GEQ(6,4,0)
+#include_next <crypto/utils.h>
+#else
+#include <crypto/algapi.h>
+#endif /* < 6.4.0 */
+
+#endif	/* _BACKPORT_CRYPTO_UTILS_H */
-- 
2.45.1

