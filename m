Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB118410B
	for <backports@vger.kernel.org>; Wed, 10 Apr 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787632; cv=none; b=XIUzbpDRCyO+oSlOUqUwxU0CIrxBTxk4ZhslJjDfy/NKXzDjRBLV4mgRtvDEzBNbBZ/nxzLssWoPWlVQq2ry6fBRUU9CXqwBenX3KB+mFPR4BczUoaOp/W1gR6ZYQH7/asYV+W+SuSLyoMIawKlwps3I6lBjqA1re6DJP6Ns7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787632; c=relaxed/simple;
	bh=88kWHorcAaR/iTlNj49zVjwSey0r9hp1hGaymAWP5jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sydPXgy572MzahxvwNNr/DwgLhfWaBcd5sOAnBY3d8kxZlhkK2efyk1OAFBK/gOrN8026tdJ7E1PkIkYM3uf0djXakPHJU8OT+2xu2oavYvSKp8WygszR2FDw8QyktwLSmYd+5baO/cF/ph9tnL+Dv+HawBlP/0M1nc5f7CrdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=rxRREjk5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="rxRREjk5"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VFHMT6bP4z9sWy;
	Thu, 11 Apr 2024 00:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712787621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypneQOzePy8KAtiS4SS2/NNYqS95C97A0RbjZZxRDSk=;
	b=rxRREjk52wqJNVHu23XuKFwMKKW301TJJ+bUWANFLF6hAQ4ZGYNMnfHMgrvWo1ULyWzTDM
	WrOEWnUoX2rY2AaIOG67kvr/1oULtx2GF5ESgPz119yOXOcqtU0Ey0hdIvhM56THrAMJAz
	XOZ5VEWzPqlqhDPJ/kxdIt3hlDsQ7IlN1k1VlY3fAuc4VidTB+iS1m/QHX4TCutwi7x2yB
	cEY53G2gDvc+JShDBVwl6/eilMo4qLRSHIkmv1IS5AJpU1Wz+ejdwn7PNyG2tEnUP++ZPr
	sINegKBwjIJDJ3AVUb0JKZ3q51o7GqG/6Cl/NJ2JQmVuThNLWe9A9FarP3hyEg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] backports: Remove mpls.h
Date: Thu, 11 Apr 2024 00:20:04 +0200
Message-ID: <20240410222010.1171249-6-hauke@hauke-m.de>
In-Reply-To: <20240410222010.1171249-1-hauke@hauke-m.de>
References: <20240410222010.1171249-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VFHMT6bP4z9sWy

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
2.44.0

