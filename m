Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B02EEE75
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286816; cv=none; b=GvPWTu035TRgZaCDyumOGs1Y1G8EvcCZkVAwcUKlsMTyDSiCg2j8gv32kUaXIy+QqO6A8jGltWnUDqZoMFBTzcbyOPJoTvc1pYI5xVYtvL0T9uQEie4wRvVfx0HolvBCjTl/E/kxqOABBim6g/WJ6eR9C5APi0MiCtIzuIokf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286816; c=relaxed/simple;
	bh=PSvSysRBnQMZ3Kr8I4ElM7JeAJbbaAZVfMx3R4iRCuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5STihv1K889Ld63O01TVj0kBNp7OVIn5lCC3cbrKW7DOG41eGLSee4ywBYgDxM5scNCqRAmk7kX8hPgNGAfB6MCaYzL/lDh/b5xNf6D0/zI7DU27KTamnLTKsevg3FmQhX8i24w/wpufMCL6SbogDiKbAiGg5ckztBnI5jK5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kAA/I3CS; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kAA/I3CS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3KPgy56xD3brHVAkKuMCg6RXz/ULblojFQ4guq4weU=;
	b=kAA/I3CSEYihhaTa11c1hu2KjZvvkVNOljSLVGPfdloJMIvFOmgU9oNMdrB21CwimrLIqH
	QkSq1Uq35qtO5z/2IZY06Cug3cHb18PEGOzLANV7x2zFCmRMZGIJrwE8lemq9vWuvI4/bu
	WBgW0Wp5XTCDCyIoSpof50VOpNlQ46k=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 05/20] headers: add genl_split_ops compat for kernels < 6.2
Date: Wed, 24 Jun 2026 15:38:29 +0800
Message-ID: <20260624073844.2097504-6-cong.yi@linux.dev>
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

genl_split_ops was introduced in v6.2; for older kernels, define it
as an alias for genl_ops so that pre_doit / post_doit callbacks in
nl80211.c compile without changes.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/net/genetlink.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index c3f05fc0..b98d7110 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -3,6 +3,10 @@
 #include_next <net/genetlink.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(6,2,0)
+#define genl_split_ops genl_ops
+#endif
+
 /* this is for patches we apply */
 static inline struct netlink_ext_ack *genl_callback_extack(struct netlink_callback *cb)
 {
-- 
2.43.0

