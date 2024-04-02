Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26A56751
	for <backports@vger.kernel.org>; Tue,  2 Apr 2024 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100079; cv=none; b=fewPgUcU0B5ZNWiAMabHtYSYcXYPT/Bz7j2NShv2k1pPr174kjRMZA1OjvZeNZMugL9UWzMBf3dTV8mJFi852nTWi33AjJcPKPLRgae3K833mmIzjxUczXWpdf+Lc50KqZOtGogw9KC8Do/gWZ9h3jPoTbprRw1G5pNZruYQ/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100079; c=relaxed/simple;
	bh=PYUTuRrZpl+658V29jfEZKnioR7qzI9jdum37y7lEDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0qG60dVBNrB8guE2RS0D+f/cvQE2hh4+IIrbyeWNdTaNaeiW8ZRQqwynQws6jOgeut4XCrLu9Ao9D9hb7fw4b9rZ8fvpXcTD2RcscH5VG86xlWanCb+N7YesIfhe1dR+/feD1uiWkErJjC8sKAv9fSLAhwCtCqiDg83iDO5Tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ki/9OlPY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ki/9OlPY"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V8P5H1mLTz9sZF;
	Wed,  3 Apr 2024 01:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712100067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tgqU7VuuJMULeUjbCN/Rb12jLhfuBqMHGLFOkjYYoUU=;
	b=ki/9OlPYSyxPgBmDNHOAlMuSGdjH2rm7BSRrao9Gj6t1eVHeEhGvHp6dS4kNRZZC7q0gWY
	S8QuSgWDTbpe2bzGN0khghtlxC6kZ8Wkexv5qR2QRoQIEO7sU2lXWnJ73zjzk1K8K7kwrG
	GlUh9eHxNFa0M7Qi8MuUj4M448whm4eX3H2IJplOIOwpNII3tJ1hgtpbvvpKRETL+0LG8b
	uw8myetPWHHyBqD3oHro/EFzXtnjoIJi2ffDg9fyJRWXVzIImn05g1ENBNLesdTx+w6Ulg
	sY4v0ozDr8FHXUeYhEmrjc/gjYvg0mojacQbgGgvWUbknSWJvbZCe0jvNrLZHw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] patches: Add workaround for coccinelle regex
Date: Wed,  3 Apr 2024 01:20:56 +0200
Message-ID: <20240402232056.2766461-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old regex condition for the identifer is not working when running in
Ubuntu 24.04. It was working fine in Ubuntu 22.04. Both are using
coccinelle 1.1.1.

See this Bug report: https://github.com/coccinelle/coccinelle/issues/364

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0087-led-activate.cocci | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/patches/0087-led-activate.cocci b/patches/0087-led-activate.cocci
index 674db046..f0186a90 100644
--- a/patches/0087-led-activate.cocci
+++ b/patches/0087-led-activate.cocci
@@ -1,6 +1,7 @@
 @act@
 identifier activate_fn, p;
-identifier m =~ "rx_led|tx_led|assoc_led|radio_led|tpt_led";
+/* the check for "rx_led|tx_led|assoc_led|radio_led|tpt_led" does not work with coccinelle in Ubuntu 24.04 */
+identifier m =~ ".*_led";
 fresh identifier activate_fn_wrap = "bp_" ## activate_fn;
 @@
 <+...
-- 
2.44.0

