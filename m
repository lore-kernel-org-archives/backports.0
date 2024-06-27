Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58631A3BCB
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532142; cv=none; b=f99kET+lcmGAdpbRwAAvJToRvqVEdYVMm7Dd7nwye1R647OKsqMKZ3HLPrFw5+4I9W7Fl3je+yCw1FSoR70z46mrmbkEfPqTTjn07yZpycnYRanYws46Hk/yQJSIMyED6xFDcd8tZAaxbzcX/BXX4Dq8o7PyWX2UsSd5tta8OsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532142; c=relaxed/simple;
	bh=IOql7Dl9idErnwndJ5BttwsOvQiz24fO2BGTkMDw1No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpdLCh7CNvrpuP/yX774jOnQ4oUJCUeHRx6v4TO2Wqm4vhYhDOVpa730JXJEF3ThUvuVrUdva5fTX//ARvAJitcCWF37kbiqrgnVGwdzifLMDwZfsiB6dVU4VAoczm6+g0bs8v5QRlooxKz2yKcMkO7JQ24I/IIHwSY01OeJT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=fdNNx1uM; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="fdNNx1uM"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdj4SBsz9sqv;
	Fri, 28 Jun 2024 01:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DNVHLSggozt1t88kdsGz9VzLrRinmDXU3Nlet6Nctw=;
	b=fdNNx1uMzB8dWXbVs5KsmWG8ndNNvoDmlGnKrR4MJON9GIghhDZtxBG1M5AjWLTROTTqQa
	JuB8a+fJddu2Mg6KjZwXG9INHVdKdwNLVT9119UKZ5mjQZrRa1wTstNCLcz5dQcz8B9W92
	ly3yOTS2Bh+eoRnKjdcRfKpMzq/UkA3XokHeQ9Xwgs5pOM2Pcvh9kOl2hFTkG3oILP3vpq
	6AwvUVewNt0EuJ6E6N2qB8ABUApjt86BQg6GzURL7sf+H04KPwWqGm5JUmF+ruAKZxd5g/
	Zty1USZimFfHc4D2UL6BMFjcr511QItRmq7W9owmFcxZvOkandAawSQHtHo6ow==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 68/75] dependencies: MAC80211_HWSIM depends on 4.19
Date: Fri, 28 Jun 2024 01:47:54 +0200
Message-ID: <20240627234808.1253337-69-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdj4SBsz9sqv

The driver needs ida_alloc()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index e0b5bad3..17204918 100644
--- a/dependencies
+++ b/dependencies
@@ -38,6 +38,9 @@ MT7921U 4.19
 # Needs aes_expandkey() and aes_encrypt()
 RTL8723BS 5.4
 
+# ida_alloc()
+MAC80211_HWSIM 4.19
+
 # ida_alloc(), xarray
 MHI_BUS 4.19
 
-- 
2.45.2

