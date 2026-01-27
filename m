Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED53398A
	for <backports@vger.kernel.org>; Tue, 27 Jan 2026 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480621; cv=none; b=hIoqijtUNCFWaC55sFRhg+dKYCBSJ4L2RsL1ZwQfpYmUh0S+Csy/HbtcSnQIO7Z/+ZEleQLXY0iSe/3LpU6tOuT00hGhjLOG8VPqXbhE2HRp+kgZ8Etus1OnpfaCEr74dXAqjY/owrraPPNSRwiA7Csbade1STvQvQwi3cY9Z3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480621; c=relaxed/simple;
	bh=7LmPPgofIb1IE8U43JSiqCwQWVM5REniQT8EO0NHNCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fW8AcHxf4Ayt/xyBQ3OjROKi6PPIvPIPMhv6Kc7h3Eudpj9Vqb82YmBR6kVUFj3/jtZcYS9Sf9J8BsKHlyX/laC/q4mh+yRr6v5vm/MrxheZChO+3grqPeQmIuXKHxLSzYPZ29/3Q9kcJ98TZNpk2l5OstGfA08qhifGvlBkaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h5mqeedj; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h5mqeedj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769480618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pklMLFycNkq0XVtFjCiXKaAxe4amek66ovJT8s7WeE=;
	b=h5mqeedjfoj/8EXKynUeqYJQbmW7GAKAdGC0tG90lrtuXRfDzq+9m1wnOc4h/GPEvP/gqS
	kBbj+2G/3/KwRBqIWVdCdgUlK/wQ+7rI6rYekt5UxjusC3A5bDqOr9gIDp34TqowaXJYti
	s7CYnDxdFNKvGMnBMf1nEebuL78hQhQ=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: yicong@kylinos.cn
Subject: [PATCH 2/2] patches: fix puncturing bitmap policy
Date: Tue, 27 Jan 2026 10:22:39 +0800
Message-Id: <20260127022239.754220-2-cong.yi@linux.dev>
In-Reply-To: <20260127022239.754220-1-cong.yi@linux.dev>
References: <20260127022239.754220-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

commit b27f07c50a73e34eefb6b1030b235192b7ded850 upstream.

Use u32 instead of u8.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 patches/0099-netlink-range/mac80211.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index 90d2bf53..2a83be99 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -92,7 +92,7 @@
  		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 -
 +#else
-+	[NL80211_ATTR_PUNCT_BITMAP] = NLA_POLICY_RANGE(NLA_U8, 0, 0xffff),
++	[NL80211_ATTR_PUNCT_BITMAP] = NLA_POLICY_RANGE(NLA_U32, 0, 0xffff),
 +#endif
  	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
  	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
-- 
2.25.1

