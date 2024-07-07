Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D346A332
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393028; cv=none; b=ZfZGNbWWxMAikF3kxq/LmFAfvvA+pvLfa3MNsFZNPKaV2+S/24wvbGQm8lkrFt5CNHrDTe7Unqp0fWIzBaHz810rzuXm7E1Xwiv6dULSnHt9LUgQOdcngaCh5rWSCEjFp5uPtZpdSt85H5ZmtMOa4kvCHQamdwubaV/j64fEeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393028; c=relaxed/simple;
	bh=fnNa8z9sYzp1awsjUHkfz0EOI/dh59bfCatBcAtP9d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y04/eO/EWANthdCqsdaLlSC5sVlKpHs4nshp4+mp7N4Q9HinsGe0pXgj37F3/TbVM0uuQUZZRXmFznl1UmKFYf8MZdyK4yKVPAoYQb5IT9HmE6eqau4CDVLNdf86y52dDXA+d2myb10YoFEPf+qlQAB8rHo2pye3OFQM8pK/3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=UMaeM5iX; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="UMaeM5iX"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WHN193fZtz9slm;
	Mon,  8 Jul 2024 00:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720393021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky8ZxX+VKnTb+ljfscLTvOjDvJZZyXzq6ImzHAzFRCA=;
	b=UMaeM5iXPm7B23cUT9I17OdXWQQ/fqfLcg4be5eYWL9W+MxDuCP/CQ7ijT4Ml65i5TCDkh
	rCoC1gBglK4eIzz4evlyxUDbuuf9ZkxK8+Gn0AOHXWzJa7761U6v5pUyuLCVl6hjznzeFc
	aFEenpUV4r11V8xQ24Jxv5mZXaCV9NgGmIgtbYewBf+MqyNAp28pRMrYMkIXtsqtQgOesr
	56HJpg/Buep+TEmrL5GVXMRWNDWs0jfVaTe6bf2O1X3SyF4P+sTnsZT1GUiQPcFMg/u4q8
	iyVJAh1aHoXKTKjQSBDtJ+ksxHj7XshByOMcZF/1PhkzYlFpgj5+lpyZWs9nPw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] headers: Add linux/align.h file
Date: Mon,  8 Jul 2024 00:56:43 +0200
Message-ID: <20240707225646.1924882-5-hauke@hauke-m.de>
In-Reply-To: <20240707225646.1924882-1-hauke@hauke-m.de>
References: <20240707225646.1924882-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WHN193fZtz9slm

The linux/align.h file was extracted from the linux/bitmap.h file.
The new WFX driver is using this header file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/align.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 backport/backport-include/linux/align.h

diff --git a/backport/backport-include/linux/align.h b/backport/backport-include/linux/align.h
new file mode 100644
index 00000000..5cf9f351
--- /dev/null
+++ b/backport/backport-include/linux/align.h
@@ -0,0 +1,7 @@
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(5,13,0)
+#include_next <linux/align.h>
+#else
+#include <linux/bitmap.h>
+#endif
-- 
2.45.2

