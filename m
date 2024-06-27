Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98961A2FB5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532140; cv=none; b=WkN07jABjyt9M6iVsdodfl8nwA8EYruQ1PnqMSvzCwXfVVGFM5P7RMs7z8oAlf1xmyCzyGssCZ+3MmYdxXmEwlQ1wo4ttYj3S9tYLLIhY/WAUriAKjYQv7Mhl1kUSrjso+/xs+5j2QoyS8qegvn9g9TzTqSSaFtwk0PQ9UCpMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532140; c=relaxed/simple;
	bh=AUdsx3I6AAAZhrRjNiZ7Wjg52YU9+MnM1e4kw7RLZkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZokM99RfzB3Pw6KT+5L8PRciDNfgiLiZP9j/L0NWoefMBFBs4BMfWA5D/0123cM+Ohzu4v7Z6sGH8pMkuVIiE9Tj+gJBoBJdFuVLqRkQ7tgDs8sWoFaVLDiTBodLolkzJ93fm0Ew9zzd6vNnv2dDLZ04p84Ge7J2Jv2Oya7QxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=JCff0uoG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="JCff0uoG"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9Fdg3FnNz9smq;
	Fri, 28 Jun 2024 01:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDn32d1zpPCrzSuM+cnaZwuaXuN993ot94bfYPP5IoI=;
	b=JCff0uoGHRUQZjTxMrMznA0Yt8uEve4GbhkZx61chJ+0GdFJyIDWFxIlgvSbO/iFp0g5Em
	kX2MAC6+2JMKaPXGYXlvaJXioeME5kLjmcBfQeWhBxBwGBA9AAdb3Ythpz5TER4beWqihu
	7GTKl00h8ftA9XtnrdjInqhN0EEeban8fI73P9qPxR/6dEkBxOkDVptI9rBF8TaMD8hUsR
	LwoloRHdORpZ2xtoSBwuRYTswZDIwFmTlyh6Ns/AYBgSEy3ylCkmZBET8tWQfsMGuFic4o
	GX9BR0qleuM6I4sjusQDou7FNjrbqo290jFTWr+O2lAMN0eDl/2kt1PFCiSXVA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 59/75] header: Add DEVICE_ATTR_ADMIN_RO
Date: Fri, 28 Jun 2024 01:47:45 +0200
Message-ID: <20240627234808.1253337-60-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DEVICE_ATTR_ADMIN_RO is used by ipw2x00 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 46f2190b..06595285 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -7,4 +7,9 @@
 	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
 #endif
 
+#ifndef DEVICE_ATTR_ADMIN_RO
+#define DEVICE_ATTR_ADMIN_RO(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
+#endif
+
 #endif /* __BACKPORT_DEVICE_H_ */
-- 
2.45.2

