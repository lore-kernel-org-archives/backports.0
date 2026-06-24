Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C892EEE92
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286813; cv=none; b=SRM/NzGRoiFqeQx3MbzbLI7NLJ5u7av1yWk5J8ZmWHGxG4nQwITP86cqrkZZkKTzYj9ug1GskgDP0BW4MQwbo+OzNPrN6DkGdmbk7tGCe3BPrl7v7lPrbxQ/rLJoVtbrA6+LegJZ5EFLQe/vIt7zTsVSHA2+MJz1b/ATJX8e5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286813; c=relaxed/simple;
	bh=rirXqjZm8MFw93qT2rQLn2ZxVMomJdd5D6iyJUgOAwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty/BYeDeZ7PObk9hYwmrwso7pW0p5ESNkkJKXcCIdbLvgFEeMIN9p/UCSWm4myc4FB9hVK+/JWzo//CFiEXuLZa2B2Eyq0DcLLT7LYfWU+jWEZV01lCeg1CuP9DrJwFLz3qFD71fiu1vBYOi2mztekwpLS7jNh+Ls6p0h465Qx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OTv9SHiy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OTv9SHiy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQsY1a/IYMuAK5V4bLG5KO7LRSrQkqluL7dAaM6yOEc=;
	b=OTv9SHiyGMbStHniZk8aOpcq2aFKdeNRpsT+RYLfTc15hZhrMCudskbIDwSDzqzqjszb4p
	LLsjQ3FI9xUjQsO8nsYzrR90VpL+PK+CaVlcopvD03WhlmttYz1vu+P9TECszHcp3+zapb
	xZGOoltOHmHpWpJXwyopv0i3T+UJbb4=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 02/20] headers: include linux/module.h from backport.h
Date: Wed, 24 Jun 2026 15:38:26 +0800
Message-ID: <20260624073844.2097504-3-cong.yi@linux.dev>
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

In v6.2, include/linux/device/driver.h includes linux/module.h, so
files using module_param() get it transitively.  In v5.4 there is no
separate device/driver.h and the include chain does not reach
module.h, causing implicit-declaration errors for module_param() and
related macros.

Include <linux/module.h> from backport.h, which is force-included
via -include on every compilation unit, ensuring module_param and
friends are always available.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/backport/backport.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index d1d3b102..be8668eb 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -8,6 +8,7 @@
 
 #ifndef __ASSEMBLY__
 #define LINUX_BACKPORT(__sym) backport_ ##__sym
+#include <linux/module.h>
 #ifndef CONFIG_BACKPORT_INTEGRATE
 #include <backport/checks.h>
 #endif
-- 
2.43.0

