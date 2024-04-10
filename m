Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D51184132
	for <backports@vger.kernel.org>; Wed, 10 Apr 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788057; cv=none; b=YzXgVsThKJQgYpxpr9qFthxBbUbS19Q1hJUc3L1hIwi3LyQDpBe8hiue12Xog5pzLYqHf7U4cZpuasys3riWcUcHLy0Y6ahscruMdP+moDEGq68W8j5/MbnYuTPoNYHKRCYNNcUpc2nwIpApP/ShY0XLeRrlxP/AYOt2S9n2fks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788057; c=relaxed/simple;
	bh=EOKJ2rMvk+rBKLfmgiiJYGWzyBm8saH6GhRWcPR+Ke0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnXH4CA9jAHf7jO4HAVI8sg5LqOFCmMbiW3ieYODVK/KBt+t83ecRcCF8HVP0L4HCsP6mcIlGGmmiymrbaWXQgTg/P7M54APdTNSyeyAtpch1lbWIEVB985207Xes03u4IJxftf/I48kjxsMZxW+TzGOVqmh8G0LzdOEjat0AOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=iY5OMBn4; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="iY5OMBn4"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VFHMS35tvz9sWC;
	Thu, 11 Apr 2024 00:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712787620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdgG7OAuvXxo/VnTgM0jWp3MBdT0V9eLp1lm662dTtI=;
	b=iY5OMBn4ohqYuUAmJf1MXkJ7jij8Tp1bZVwOQiKec//WyzrKy70n0bX14y4PqY+CDWEzwi
	Wdzv0OU9k44FYC7JbpW9XsSH6ocYsF2i79UUfO17bAGIDphHxEPgXJmYmswcFF1agZAtKQ
	rGqn3SaQp30Qs5HF1KruGDvvrIMRQvK17eAw7MEC00gMIvN9MzUS6NYfUE8AYdA2A8+k7o
	jwpOGsyO18VrZ0RoE8tmFtD0Sf4abwXQSD5gYZ+agD/ADUdufo9fp5vXA56SFuM3sM2+36
	/E1qqseYjl4eYqhQJSPZ09uiQVIw8UzKIXjIWlmkkmQ+KVyoRXOTqsv6UMTNpA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] backports: Remove no-pointer-sign option
Date: Thu, 11 Apr 2024 00:20:00 +0200
Message-ID: <20240410222010.1171249-2-hauke@hauke-m.de>
In-Reply-To: <20240410222010.1171249-1-hauke@hauke-m.de>
References: <20240410222010.1171249-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VFHMS35tvz9sWC

This option is only added with kernel 4.3, Support was removed some time
ago.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Makefile.kernel | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 11ce4177..a936eb3b 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -31,9 +31,6 @@ NOSTDINC_FLAGS += \
 endif
 
 subdir-ccflags-y := $(call cc-option, -fno-pie) $(call cc-option, -no-pie)
-ifeq ($(CPTCFG_KERNEL_4_3),y)
-subdir-ccflags-y += -Wno-pointer-sign
-endif
 
 obj-y += compat/
 
-- 
2.44.0

