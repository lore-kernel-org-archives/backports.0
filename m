Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BE71A38C9
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532144; cv=none; b=ASoF/NdXAAO7h6KEeKdViL8GJuUHlrCe16hajADBQVspknSAuy1rLeUAuisTCkcrOoMdYoOeTYPPQvBMFnjP1nGDck1HkkH9KhCmEf1dyqwg69trSgkKr7IX6aGmBAT/mE0jUcp4Xn9r6+i8gYRc1aIBUP2DdLub9Cb0aAu9Rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532144; c=relaxed/simple;
	bh=4HPE8uCp6LNOsqqkFk16bta9D3BBYo9fjWoFRmmN9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnsjvwoKyBFA/dCgGUmP/iNZzvTMW5JqQwI4e4wCsUDEBbelRy3g1gkYQtKvG4sHvw05At8gJ+evC5ihiurxcrZoN8mlNKpINNF/DM3gxB+HxxlpXjs96QbuenDGyl6autEowFaJ2ljMiq76GP2yEwBxQL9tefW31FJA6kLB4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Xbzr/ref; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Xbzr/ref"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9Fdk5k4wz9sR1;
	Fri, 28 Jun 2024 01:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A19tVZY0QWRO6EQONLxn7biGIIHajG7hFcLVIk+u3Ko=;
	b=Xbzr/refDzR41IYNYbMSIx/1cUqlGE8gHPGQvYW9FJPHOxYvbxRyt3F4cmKJdUmLuRBL0V
	7aup/Gz9OFZd3DkATMXC/5r5ZNPCOHNNRZBf3pJ+9KIm81Z63Fpg4AIqIm3dIbuP92KETt
	Iaept2CDllfhS5MT94XnU+9S81yBhbXOsnAw6QctyzTd4UoWPFXii5LbWe0AZm0f7P8Tlm
	NZbYhRHLuk2IOpMheioZz8rESYu/k1meoxOuEYboXMXYsRE+zCw4m3SOlt6Lg5970z8i1g
	xLtAw41246eGd0ttvtXI5uR7tfV7rmWKLQBM5ln5/jEaVPswgpWPT60kKskDVQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 73/75] patches: add build system workaround for pre 5.17
Date: Fri, 28 Jun 2024 01:47:59 +0200
Message-ID: <20240627234808.1253337-74-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0111-wireless-build-unquote.patch | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 patches/0111-wireless-build-unquote.patch

diff --git a/patches/0111-wireless-build-unquote.patch b/patches/0111-wireless-build-unquote.patch
new file mode 100644
index 00000000..ab324512
--- /dev/null
+++ b/patches/0111-wireless-build-unquote.patch
@@ -0,0 +1,17 @@
+This is needed because on earlier kernels the build system still quotes it.
+commit 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
+in 5.17 changed it.
+
+--- a/net/wireless/Makefile
++++ b/net/wireless/Makefile
+@@ -33,8 +33,8 @@ $(obj)/shipped-certs.c: $(wildcard $(src
+ 	  echo 'unsigned int shipped_regdb_certs_len = sizeof(shipped_regdb_certs);'; \
+ 	 ) > $@
+ 
+-$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR) \
+-		      $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR)/*.x509)
++$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%) \
++		      $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%)/*.x509)
+ 	@$(kecho) "  GEN     $@"
+ 	$(Q)(set -e; \
+ 	  allf=""; \
-- 
2.45.2

