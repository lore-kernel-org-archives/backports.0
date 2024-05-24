Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46012C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570622; cv=none; b=U/p1ZvEbFTSgraZu7imvkb8p0vxWCpD4Gjd/pcplZrK1Ot1GzrZ5UOsmhQPKIPS6vIu8QVqGgVEJEwMif7v1TBrOIkcQFYL3WoO1tA8ll3w91kFhB5yszGjSzttdMnY+UcGRNafRNHoNJDVbO/R/ug4o1uL+16V1/bmytB1raeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570622; c=relaxed/simple;
	bh=xs/Ljy2zyKBhQdUeM6FNnjAmEvdE6J84L1C2oW7GN18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoO4Evy9Bez8F+HVwDLLX2AX5ZyfVM37hkCasRPICyKMUcVToBLbDKLuO9OgEEFDY+XO3BDIBbi7RXNuokmMtvMOZzHgcCQQmYzpF0xEiD0rRRt9I4zaqqVxkY11TSFXuRfDSOt2X9qzikn+snC/wQysh/jbAycc46EZwcss4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pI2lQyLu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pI2lQyLu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Sth4Riskf5zLmWEO/C24qJmnGMYeWnWc+PSkRAjJrzc=;
	t=1716570620; x=1717780220; b=pI2lQyLu7Os3/m3hKUiXr+raxCE1QByaEsqWAEBSjq8hiJp
	xxbhwbpxpyPNZmF3XSxvLiXTz69Y7iMWFrwxYnBjL2tvrie1Hs3wznzANVZWyNQm/WUuIO9zkGcXy
	1O7DRGQxTusGvm7x6FosPG5/aUq5DB2TXiyilt2hhL/xXY6goMRaKaBQ28mZNFOuY0XMLik+/g/0U
	e6LGH4m2XqNVir8yKjoFEJvkOMCUpYMVOood6QfMVLYeQHIQhY25JVAycXN4Uu0mrp9lf3gIrWdPd
	3TLKVyfQ7f+Qgm3ZXab78WMWLAgiRWTartymfj1WG36xRy2d8gRmKSnMGVtwRSYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQs-00000008Xuw-1qWu;
	Fri, 24 May 2024 19:10:18 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 66/74] backports: add split_ops to nl80211
Date: Fri, 24 May 2024 19:08:18 +0200
Message-ID: <20240524190907.dad1104c296d.I98da0a61961b922d5bd507d894c5cd9b3086df66@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Greenman <gregory.greenman@intel.com>

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0109-add-genl_split_ops.cocci | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 patches/0109-add-genl_split_ops.cocci

diff --git a/patches/0109-add-genl_split_ops.cocci b/patches/0109-add-genl_split_ops.cocci
new file mode 100644
index 000000000000..02b8809a0003
--- /dev/null
+++ b/patches/0109-add-genl_split_ops.cocci
@@ -0,0 +1,43 @@
+@pre@
+identifier fam, f;
+@@
+struct genl_family fam = {
+        .pre_doit = f,
+...
+};
+
+@@
+identifier ops, skb, info;
+identifier pre.f;
+@@
+int f(
++#if LINUX_VERSION_IS_GEQ(6,2,0)
+ const struct genl_split_ops *ops,
++#else
++const struct genl_ops *ops,
++#endif
+        struct sk_buff *skb,
+        struct genl_info *info)
+ { ... }
+
+@post@
+identifier fam, f;
+@@
+struct genl_family fam = {
+        .post_doit = f,
+...
+};
+
+@@
+identifier ops, skb, info;
+identifier post.f;
+@@
+void f(
++#if LINUX_VERSION_IS_GEQ(6,2,0)
+ const struct genl_split_ops *ops,
++#else
++const struct genl_ops *ops,
++#endif
+        struct sk_buff *skb,
+        struct genl_info *info)
+ { ... }
-- 
2.45.1

