Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EB376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570583; cv=none; b=jA435ZaLMcR2II744vsZ3MK3L9h4be29uHroxHFwCgDoOLpOkSkMZXmuT1lDGXYcZ9xnd6zpNivYyHTNyPQ/40GpBMuyVoY7HqbsgFup9eA7l21AQhJ0w/6vBqVIQvdoOppU+8PZ7xW1OyARLIMvTtj5cfk/PKGuYK7tvi3FaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570583; c=relaxed/simple;
	bh=vL3zf7PoGdBXbh1cG8nYqz6QsFVYC60SahvOuwIEd1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/O5/mFZFpEwBe9f8yGR9DZ7dUa0PvnTn7xkr+/9bqLWiClUA0yQC34KJPCkiYXTutU3YS8Fc6gkfmsxIQFqtOU22vz1nN/9eVBISj5KHOFvnNj+U34pEWYxA5LpmHE5gS6nHAoNKFDk7tCsYgqcwzP/U+15EnWhj5zU4kyVaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OAZ3VaNW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OAZ3VaNW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=S5DuwPRx1xMgugLJHKl1iU3FZAtGZyq8LxO12D1OiYM=;
	t=1716570582; x=1717780182; b=OAZ3VaNWNNRayd1JsOFHBQTS2YFu632MQ7xjMXTdIPEQ69Y
	7gO7YV2C5cP8Fkq/TyAvBuSyaQr028GUIT9O9DdzI8Fz2LgMgVxw5pHl2807IQVhsneRAeRMf9T9D
	kXiFLlGsqJA5KuDu93lSQrb0ovbo64zkLnIwpMrRZM8EIO/VzV6K7nsBpA+KOPphYb/aMm2slfLMH
	bvzeIf9qq+ra5WAJn+0MHSSi1lZk52qAncQNqQ0XO/jDZ2300K69x94/oqR/Gww2vs2GpX8aR1z1R
	jXy1rJpV3bPgkWRLVifgpnn87lD92J1m+AQcULY4QD38qWKrX6Boe+Adw6itXqQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQF-00000008Xuw-2DIL;
	Fri, 24 May 2024 19:09:39 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 32/74] backports: kunit: add kunit_add_cleanup
Date: Fri, 24 May 2024 19:07:44 +0200
Message-ID: <20240524190907.6b4e9dec2702.I6db5dedc7e92f9bcc8e0139e9e2d9ec18ebbd478@changeid>
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

This will be included upstream in 6.4 hopefully.

Co-Authored-By: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Makefile       |  1 +
 backport/compat/backport-6.4.c | 42 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 backport/compat/backport-6.4.c

diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 3c8430bc4958..62dfc62f7b46 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -16,6 +16,7 @@ compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
 compat-$(CPTCFG_KERNEL_5_15) += backport-5.15.o
+compat-$(CPTCFG_KERNEL_6_4) += backport-6.4.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-6.4.c b/backport/compat/backport-6.4.c
new file mode 100644
index 000000000000..995c1f1d1b22
--- /dev/null
+++ b/backport/compat/backport-6.4.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#if LINUX_VERSION_IS_GEQ(6,2,0) && defined(CONFIG_KUNIT)
+#include <kunit/test.h>
+
+struct kunit_auto_cleanup {
+	struct kunit_resource resource;
+	kunit_cleanup_t cleanup_func;
+};
+
+static void kunit_auto_cleanup_free(struct kunit_resource *res)
+{
+	struct kunit_auto_cleanup *cleanup;
+
+	cleanup = container_of(res, struct kunit_auto_cleanup, resource);
+
+	cleanup->cleanup_func(cleanup->resource.data);
+}
+
+void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t cleanup_func,
+		       const void *data, gfp_t internal_gfp)
+{
+	struct kunit_auto_cleanup *res;
+
+	KUNIT_ASSERT_NOT_NULL_MSG(test, cleanup_func,
+				  "Cleanup function must not be NULL");
+
+	res = kzalloc(sizeof(*res), internal_gfp);
+	if (!res) {
+		cleanup_func(data);
+		KUNIT_ASSERT_FAILURE(test, "Could not allocate resource for cleanup");
+	}
+
+	res->cleanup_func = cleanup_func;
+	res->resource.should_kfree = true;
+
+	/* Cannot fail as init is NULL */
+	__kunit_add_resource(test, NULL, kunit_auto_cleanup_free,
+			     &res->resource, (void *)data);
+}
+EXPORT_SYMBOL_GPL(kunit_add_cleanup);
+#endif /* LINUX_VERSION_IS_GEQ(6,2,0) */
-- 
2.45.1

