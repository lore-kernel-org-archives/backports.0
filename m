Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF01A2FCF
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=dDWvDY2qU47E2xj8h7h0VE8NQxT9m0JVaa1JcVANqX3F6eV/rdTHe4kbXobcm2Jn9wTDwk/U6a4aU2MFmdxoT7eATuJjlHcRIOo98ROJht1Cv73GVs1JtK9/r0GnDku6PWJmZcrmHTs4fzulf6tz69NT+pFE1WeK6LqwcOf3bIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=e+5PTtHSK+/FIZ4kqVdB6afZOfDLBwDL3ZCPYQAMfKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDJZZFbkifndQss6yXFXiM0dkRAwNIn0bcGtmW0h/wOAnbsq8aVRW1q5irmj5v0cKO1UeJcHeVWIaa45rUFK/vnMRERP1Mfa/7HWwEZRxkYA6p6D55OoKkxgf4ACKAICyg85/iUTqqFJmLBnG9OmPc2DyUdqos5L18by2nGP8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=waLqwssL; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="waLqwssL"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdT6kY7z9sq2;
	Fri, 28 Jun 2024 01:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjvo9af74G8gWeyihb7oYW/Fn7t8T46lwdnx+mGfRi8=;
	b=waLqwssLRSNwadsd1VFzubYRssFyC/7aP86W+eq1n86LK9wPkofBhI/FNnzqbJfuARAe9Y
	t8aQ6Lp0qiM9/pP/JrGe+9q8gztBnY5hRxLoYEMpwRf6dxYaRJ3AAt2ICbJf2UTZhrxb9o
	97stEPEQXbQGRUT9/nOeUVeTt/pilSmP25b/n69Wbs9lcKQPtniZpmQYfCLna/3QPs5Ioj
	bjucAf8rUihgSKepvbOxVOaW1/IcKyiaOvjUYFddTu0L09uPKnUVlANt0LnQBDijyEi2iR
	sbtIQl299UGUXAIQyvZbA8+dO0LKaEoOrhV4OtLSsW7Y32jcgLaEEPMzpdFEDQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 22/75] backports: add lockdep_is_held() when needed
Date: Fri, 28 Jun 2024 01:47:08 +0200
Message-ID: <20240627234808.1253337-23-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If lockdep is not enabled and lockdep_is_held() not already defined
as a macro, declare it as an inline just like upstream does now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/lockdep.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 842e24b7..8295b0d4 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -9,6 +9,13 @@ struct lockdep_map { };
 #endif /* CONFIG_LOCKDEP */
 #endif /* LINUX_VERSION_IS_LESS(4,15,0) */
 
+#if LINUX_VERSION_IS_LESS(5,11,0)
+#if !defined(CONFIG_LOCKDEP) && !defined(lockdep_is_held)
+/* upstream since 5.11 in this exact same way - calls compile away */
+int lockdep_is_held(const void *);
+#endif
+#endif
+
 #ifndef lockdep_assert_not_held
 #ifdef CONFIG_LOCKDEP
 #ifndef LOCK_STATE_HELD
-- 
2.45.2

