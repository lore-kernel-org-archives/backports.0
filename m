Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7E1A2549
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532711; cv=none; b=EpedIHLbKhTQTI1dq1b2TL2ZJf4GMvf8ML7BPgz7kPjGZcmQQ0TkrHM0Gav55C2HFjLLEL19qU90fll4GlZgrQjP20Wecun52+15jgveysrLA3VcMT7vON7AY+l+IiH8N3ozFsJWxrVBSF87ja1gqmaDVVBMGgN5RvTt8uDrHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532711; c=relaxed/simple;
	bh=CYXyGfXPDMoTAxrXt7jsTjPj1i2kLOZZJCxJrQWIwDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHA0UY8M7wvZ1U61rp7dZuODVKzg9SMlGMyPmDJrrf2LJN9xejTwRUmjpGJl2EQi6v/smlEGZogF32aWp5Qs1zqtAs/F9vrNiE3id6lwG91NIN9GefNYouilfE5q4Gk7w/XwIoLVMvFOA3CTiLGc6r/Wr6PFKyK8fMfXL9weA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=k3pjZhRO; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="k3pjZhRO"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdN0lXrz9sT1;
	Fri, 28 Jun 2024 01:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0ks7fRfGFvDoW0FWyaQMB2i/vA9vVc/I2zHlGigxJk=;
	b=k3pjZhROA5O/y1wadY2z2s21Fo2ZGHoVOFd9opPvx8v0x3BJ0UT0eWtF0etL1cpmQxYaX1
	4ji6aD/BxDE05okAQhztG6toGbxbwx9xrjV3CP0z1vF72OFgWQxxVcOVU/CfzaNJpobXUz
	luts1LSPtY8/HhdKebIUA5vOhLgpYOVtj7vUBCX9vNSuOPN1vr/epjKiJKSdTNcYrUyL5g
	Wo4lUuN0vRaJXdAyYpef+2S9ygS0Cai8Vl8fXt1INur8DlpZGlwUvET/HgQl6K6tWUuJx2
	+7tz25In36mgdFGtf6wmCyC4uDW8rPcJNoyr0CipQQvos460TjGZiQ0UpFn67g==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/75] backports: Remove mpls.h
Date: Fri, 28 Jun 2024 01:46:51 +0200
Message-ID: <20240627234808.1253337-6-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These header files is not needed any more. Kernel 4.14 provides all
needed definitions in these header files.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list       | 5 -----
 copy-list.hwsim | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/copy-list b/copy-list
index 95a9b875..e998cbe3 100644
--- a/copy-list
+++ b/copy-list
@@ -72,11 +72,6 @@ net/Kconfig
 net/qrtr/
 net/wireless/
 net/mac80211/
-# MPLS labels, checked on skb->protocol on the
-# respective 802 family, only ethernet seems to use
-# this right now, see 960d97f95
-include/linux/mpls.h
-include/uapi/linux/mpls.h
 
 drivers/bus/mhi/
 include/linux/mhi.h
diff --git a/copy-list.hwsim b/copy-list.hwsim
index cb013917..47c07b08 100644
--- a/copy-list.hwsim
+++ b/copy-list.hwsim
@@ -67,11 +67,6 @@ net/Makefile
 net/Kconfig
 net/wireless/
 net/mac80211/
-# MPLS labels, checked on skb->protocol on the
-# respective 802 family, only ethernet seems to use
-# this right now, see 960d97f95
-include/linux/mpls.h
-include/uapi/linux/mpls.h
 
 drivers/net/wireless/mac80211_hwsim.c
 drivers/net/wireless/mac80211_hwsim.h
-- 
2.45.2

