Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A713C660
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532130; cv=none; b=G4u1TYcdlV131bGirt9kjLCUUxfARP+7DbCgYO+DCenLqb/1Fs3aHhHDitLwOnAt+C38LvJRchNA6DFjUlhgVf3eJbFxZX9YGJ6DMjKuQkDpeDJ4aXQEdNCamI+qeDmODC0D4y9HI00woR/MR0Ser42cYeC1fuSWajqnpv/l1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532130; c=relaxed/simple;
	bh=u7r9fXqr7DZw6sw8zvQYAk1KglacVIKp5O4naSS5XG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRL9mHesQzEgC6/4MiW8+VgwrYhTeZq1XNG+A3uQtVu8gVcQ4ba8Ev8hV59ZszBD1Rbq9w11UIuS+3qN54ALp+dJUSxnOQDbL6Vr2Tx5gyNOQy9Cv4VUYW9Dph/ylh/D0K26uMzYNL/zbbmxYODCPt+Ahk8KWeMTkurhLQ4D5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ZzcabejU; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ZzcabejU"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdM0qBRz9spb;
	Fri, 28 Jun 2024 01:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/T8/hFTlds3snCV8ndmMgiodTrh/RmeKht3LnKcCLY=;
	b=ZzcabejUlAEMxX0ymutrj+QY8VDb4a5MAdvUdx7RuXpjTGTQMYy/n+aI+SSGwhRM0VREJx
	PZlDAc6sRjxzndc6rJPz19Pry6M7gqbC+4EZp1Q2Ms1ghw5sIKE80YixUAy19f9LkHJFX0
	5ENUZ75S8TjdF+FCl2Z30/Sh0lhbJHmG9aX7gTAIu04++poHpBYv7QfV0/dyO+3dbf+381
	Ei+GKnJ3TdEEGpkmDFL3uXrmn+mhXoTco9YtCThg8M1ew/CZXYzdsrkEU+S7ykJElZchHL
	Aod5zNnTF4tWYXCzw6uxc32Ac77ec/Oao3XLpCwddjrLMuBNW3u2GF2VvT6/xg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/75] backports: Remove BPAUTO_REFCOUNT
Date: Fri, 28 Jun 2024 01:46:48 +0200
Message-ID: <20240627234808.1253337-3-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdM0qBRz9spb

refcount is only needed for kernel < 4.11 which is not supported any
more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index f7266780..637c5610 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -79,13 +79,6 @@ config BPAUTO_USERSEL_BUILD_ALL
 config BPAUTO_WANT_DEV_COREDUMP
 	bool
 
-config BPAUTO_REFCOUNT
-	bool
-	default y
-	depends on KERNEL_4_11
-	#h-file linux/refcount.h
-	#c-file lib/refcount.c
-
 config BPAUTO_SYSTEM_DATA_VERIFICATION
 	bool
 
-- 
2.45.2

