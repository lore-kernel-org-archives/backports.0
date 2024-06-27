Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC91A2FCF
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532712; cv=none; b=CYn3h1jX6fsNEVTT6tr2ljkkxS12NNoH6RU6uCQCMhevd8dF8nTSEiFELbeZP0Gr9tXpEnij1IECAE3IrZ0hqzbRDUANnv9yD7p/dwSsCKTBee4G/C0y4UzS7udo0e22ymNAMEwaUwE27kClCedCzCLB/S7nl4AlaahAkdszyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532712; c=relaxed/simple;
	bh=0ZFCHMSsNt2i8JJJHoZdoMXEBERtiPwjRwljme3kjuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=np3TPtNyUL8D3xVkRCE0Fvn60ndBs1xYI9HsyU9/vhzsLN5Y6yQ2Sw/JQDwDT4wkHbUU17jfVBAD+7ubQo0e0vEQnUIkVm5fjywNxuuL1ILjP+47yLcmLfp5x+A7vwI0Fvxg6UZf2+PprGLTua04xJ20+w1HfEyUjkhzcMySjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=0usyRgqt; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="0usyRgqt"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdL5kk0z9scC;
	Fri, 28 Jun 2024 01:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QERYQzeX303vYvyKq2SfhrzB4Y9SS4EN5oqkF4c/ft8=;
	b=0usyRgqtfwj82xZh06whIqFBb6LS2zBoJCFYVRt74XEU+/m8IYLmk0uK+JJAr+IOkF9jAy
	0gF7M6SVfqLU/BE1b7GHnH9ro0AV7cmgOxTspmR5gp1/v4jZW9OamySjPCWV5q5kcvNcHs
	883MNhFSDlkIGcx8rPhCtH4sEleGqqUVQEfrnTrTzZudC4jJYd7S4UFZWRy69oISNZApDr
	hsPWKZDpAcpDbHCkmwqhhBdWT50QHK6Yb7y7MUik2EtEKl/2AWj0CTAJul+TKDl4++TNvp
	ihKh/J/JQfQS3GfB90L5zg3VFieD3eK48zw4Mt1EQWUzhRxRP4gIsMDeN7KgYQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/75] backports: Remove no-pointer-sign option
Date: Fri, 28 Jun 2024 01:46:47 +0200
Message-ID: <20240627234808.1253337-2-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdL5kk0z9scC

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
2.45.2

