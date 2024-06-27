Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B091A2FCF
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532132; cv=none; b=iYH/vZN0GTa0U3nJh0PMrUG3rATMicAZ43htVhShiPAC1TkuZEOKP4GQ2yNxeyclIjEscXEG+jfM0uFZ1CJV4I0huPcvr0Am8b7dKxnoOC9wDymogck4j6T1/bVfOCkxMkKkMwC2KIIT4lMBry4SG3ZSmiAf4qG46el6eMp0xts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532132; c=relaxed/simple;
	bh=KKanIrUaafliJ4i8XkhOH6LB/TY/7VKDCzLUPukVa/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P35/vnyPg8s6v0+hD2ctS6Wbbw1XfoBrLQjsTjp398N+QVJl55fmwi8pRKE+0LEHZVuGl9JysHtC7grjrvh0Y1kHElUFOLKREyp9EDR/rwBw4YgujErjZTYabFMzEA1bpD3ryUg5TC695tK7sYTryzlsuFr4P8Q5t9A6qAZRPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=sweO5u1W; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="sweO5u1W"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9FdP137cz9sW2;
	Fri, 28 Jun 2024 01:48:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIP4fH0VgYf3ioq9gL4K2hR8vhT/1iW6imRaNkJ5SsE=;
	b=sweO5u1WUYnBKq8T6YXAHvxfXdMv6de8k6J9hO+dIeYQ+4AGEWNhE+n6yBcfxeWfE8Pm42
	qT4gfvpeHyLphVzRkm0/Wz6IyJZzcpBjJTTiMe20XpR6CfImxMLnhwO2hjcGUlYPyOChrh
	uSRImZgVOIAAcaecze4b/LVAzEazfUqHmgrs3nVWKbkSBL4RSk72t0WdGiGzXApNdPdwK5
	DDsmrQduUlE/+lRySaUhyte5n3OzT4xYGRuv5Zg/GGE475tmr8FOq8DLkkujBb936sccSt
	oeU5msZDd/5QLcxFc7AcfYrMhWyI4vPBEIARAzDc9/OuAN6P5Lz3dbxntprtag==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/75] Makefile: Generate new CPTCFG_KERNEL_
Date: Fri, 28 Jun 2024 01:46:54 +0200
Message-ID: <20240627234808.1253337-9-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will generate the CPTCFG_KERNEL_ for kernel 6.X too. Support for
kernel 2.6 and 3 was removed

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index 77c2670d..548d813e 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -85,13 +85,12 @@ mrproper:
 			done								\
 		) > Kconfig.kernel							;\
 		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) M=$(BACKPORT_DIR)	\
-			kernelversion |	sed 's/^\(\([3-5]\|2\.6\)\.[0-9]\+\).*/\1/;t;d');\
+			kernelversion |	sed 's/^\(\([3-6]\|2\.6\)\.[0-9]\+\).*/\1/;t;d');\
 		test "$$kver" != "" || echo "Kernel version parse failed!"		;\
 		test "$$kver" != ""							;\
-		kvers="$$(seq 14 39 | sed 's/^/2.6./')"					;\
-		kvers="$$kvers $$(seq 0 19 | sed 's/^/3./')"				;\
 		kvers="$$kvers $$(seq 0 20 | sed 's/^/4./')"				;\
-		kvers="$$kvers $$(seq 0 99 | sed 's/^/5./')"				;\
+		kvers="$$kvers $$(seq 0 19 | sed 's/^/5./')"				;\
+		kvers="$$kvers $$(seq 0 20 | sed 's/^/6./')"				;\
 		print=0									;\
 		for v in $$kvers ; do							\
 			if [ "$$print" = "1" ] ; then					\
-- 
2.45.2

