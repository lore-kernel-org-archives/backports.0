Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD51A38C3
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532140; cv=none; b=a9xeIOWZ7GAweWChGSKq896hGpai4ugOmNgjkYWW2GrIYO5/YBI0uIURRY+fXQ73h1TJJRDptXXp2NQz9/3A8A6sWY8fieM2AjedfASBDVghP+x7nsAcRR5qnRGjUxdUNUArx5pY4DW/VnWqmea/0WneNh0PclNdquGuy4DOPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532140; c=relaxed/simple;
	bh=aFXQRi02yNtIfDfY6OoG1Tdr/5FaVzVvKQL+zw16adk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1cvsqU1Pxorx3OyOKHtqH/f1cAmeO00EtSmT+r0WQvOOQjKDSH5il5/amp23x5dQHeNWmKZKJGh1Dh74ohvtF84S0LM7/NBQLR2XiXYQxe6FRAlV1YUgQz1ApCR3JMasOM6lpFKYtxN6bk41g3StH4eFFDc4/BttDqIi9rPBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=te/T+7fz; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="te/T+7fz"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9Fdg6Q50z9spj;
	Fri, 28 Jun 2024 01:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTqS0x4quGScyHcDxcA87cLyOUZB4nMGttZd8fTZWTo=;
	b=te/T+7fzUzPdNdwgeUO3euynwJcEdZ/53rXBs3uUFEqqlfWOxqBXiJ7nMtrGZF7+YL/8N3
	IBCYhy7DrDPegG+lv/oGJljfVpcuaJNEGZry0xaMyUDeBnu4UDxlrYZItjHH6VmgsQ0rxZ
	8OQvBJ/KgZE/3ZUfJlE2Jf9vgefD1xcVokqxp74J1QkL6h+M4WJSrq+kTpVtPX368ZsJK2
	T4zYPCVFVdqzaN5PmnHNNMNbz2MMd8+UuPv9XIjkLxzjLMtzcEm8iEAljU7sbAei/0k2eN
	oAOOqSqfUcOscISW96Kac6n5EyFNzZ/BZCKcUtYNLxAdeMb1jJAUTCneG8qEuw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 61/75] dependencies: Make CONFIG_R8188EU depend on 5.10
Date: Fri, 28 Jun 2024 01:47:47 +0200
Message-ID: <20240627234808.1253337-62-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_R8188EU uses CONFIG_R8188EU() which was added in kernel 5.10.
Build the driver only on kernel 5.10 and more recent.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 3797139b..ebe25099 100644
--- a/dependencies
+++ b/dependencies
@@ -37,3 +37,6 @@ QCOM_QMI_HELPERS 4.16
 
 # QRTR
 ATH11K 5.2
+
+# usb_control_msg_send
+R8188EU 5.10
-- 
2.45.2

