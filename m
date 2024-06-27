Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6711A3BA8
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532137; cv=none; b=iMM65/9Uxk/iV71g9iJf4fSxrYvKnrGIhGw/5iA27v7BQol5ld+gZTeM5iup3DNOgPGyb+URn4oSmKZMbQXnpeN2D8JMXcfdzTEwfamvAcRb9ijgjHsBY2yrJxUc219GvRuX3VtTd7abzZgwQmyoQdnmyC8Qw46jlpWnqeGwxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532137; c=relaxed/simple;
	bh=Gn+iP7H0/Gh4MRCW9Bih4tT/9q7SZlV2Itwa55LH2bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI676x0jePpy/BB6us/pAgbUCeTjrQTsPk3clAH2bGR730YxnGCgqK8SUBLsezurOFrVs0bXH+l8/k8cIHqDKYNpI+rSxs61qaQ/YJ6KOWCUlLjwixxaX104B47a8f5mZzXciDQVywa+h1J39Jos1lmjo3P81w2DV+VIz/Hs3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=sQiqnzq4; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="sQiqnzq4"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdc605mz9t2K;
	Fri, 28 Jun 2024 01:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UwKco+ksTh26R9HGAjkBdzn+kTP3XNis404Dne9D3o=;
	b=sQiqnzq4hNKkXS7rOtOZPptX1++VMy47vhp9buD96IVxrK6rLe3AZ3uEG31sWc7NhYD2yl
	jms8rPQisyM3PrR+FdodG06jAaH0i/yVNb2JJc2Fxx8ENHbNijS6E9yUHtFR5ZWL/2FzXL
	encgzDy+hZqizOZQ3diDd8RpPHNYeSRUmkoBTlwucD7DLqPc+3NO6opaoL+E5ck22WxL1c
	g6y+KqCEDTCFsxSe0M0Dn/IsxY7d4Ff7cS5I3az6x1GimwTTgNvnkWWKA1MOPi1rtt1FXX
	v0be6g0vE/BpdZDsIjSOSFMg03Oq6EkYewFzC2il4qDMmOxPBIgWMXFgJtFUxg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 48/75] dependencies: Make MHI_BUS_EP depend on 5.19
Date: Fri, 28 Jun 2024 01:47:34 +0200
Message-ID: <20240627234808.1253337-49-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdc605mz9t2K

The EP framework was added in 5.19 and the interface changed in kernel
6.1 again.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 1377b1b6..3797139b 100644
--- a/dependencies
+++ b/dependencies
@@ -27,6 +27,9 @@ RTL8723BS 5.4
 # ida_alloc(), xarray
 MHI_BUS 4.19
 
+# linux/mhi_ep.h missing and interfaces changed
+MHI_BUS_EP 6.1
+
 # sock_gettstamp()
 QRTR 5.2
 
-- 
2.45.2

