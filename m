Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D371A3BC1
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532140; cv=none; b=Rb0VK2YkvHvQGj4lq5GQnBTbkoTpbE7HfwxTxvnRNcoJ0MJoyRDcrJZXiWdXbeSLrK0W1LJ8a3Lp6zodYT6i+dBXxQfB95edvt4u5GOdY3iKpuT8G/+QYIUwL9cgldI24JavmXRFY83/s8tM7x5er0vZrgNjDvZCmsRgwNtOP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532140; c=relaxed/simple;
	bh=RFHV63RygNAYeB52eC7PkvUGpPwYi+x+dt1HHxY0fFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQUT4uF5DcXrvlz9i6hLEuLJEOWUqXFK75bU1Upd3a4xkBtKSZjRAgzqjwqhkJrs8JhFZqd9aFwJQh+IMYSSuio8BhrnNQVT49odNo/GHXs08k/8MkOr6OGrrG8xvun2odSL2pgV6DZ60FaJQuaN6nVjwzT55HlV/g7WUeW//mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=xB2DxZEj; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="xB2DxZEj"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9Fdh11zMz9scH;
	Fri, 28 Jun 2024 01:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9pS7IZO/T0ldaCFKyef4Lo5/0u1U7quMGyyPFhs/Ck=;
	b=xB2DxZEjdehD5eUpCotxcxl/J4YhNkre5BVGUFgA6psBtaUqIv0xLs9zKA38qUdnzCf9+L
	wtB560MogU5y4IPKOdlS/oMl3veQ8wKu0x7yUlQsoxJ304k9Sa0ceXGA8jv54bnhZQjz1Z
	ygud/2k0j7ay2tl5m+uZJCTBMmQs2nZRHorlRhnZmsb+llNlpdc+AlQ1Uj68zxaoZs4eNG
	N1fsnjqucJKGiXjf0Nf8bm3kQzNaFlwYzbBNUGkdCipoFl/tUKob3z6AssIddFmr07qCE9
	hf2L2YmqSvUgeqH5akQYGTiIQrVlP8HL976/Q67qSHfcLYP8waI0rd7EBfMOmw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 62/75] header: Add linux/minmax.h
Date: Fri, 28 Jun 2024 01:47:48 +0200
Message-ID: <20240627234808.1253337-63-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/minmax.h was extracted from linux/kernel.h, handle this on older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/minmax.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 backport/backport-include/linux/minmax.h

diff --git a/backport/backport-include/linux/minmax.h b/backport/backport-include/linux/minmax.h
new file mode 100644
index 00000000..7830c9ce
--- /dev/null
+++ b/backport/backport-include/linux/minmax.h
@@ -0,0 +1,7 @@
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(5,10,0)
+#include_next <linux/minmax.h>
+#else
+#include <linux/kernel.h>
+#endif
-- 
2.45.2

