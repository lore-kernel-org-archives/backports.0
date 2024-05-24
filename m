Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FA12EBFA
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570597; cv=none; b=pZhq7MUbpIOIWqx1LW13i8AEyZ/cv1Ad60taPnWhJcVAyKO20LQdziXXSTxLe9K6AMoPrndyOW97vEhPqETM0yYgW64GoehiGUnGFAO0oYqz492hzgESFh9Dvex9wblmgpyptGtTl50zMoxTJUMcxR/w2YKeIFW7mpsP5GPr/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570597; c=relaxed/simple;
	bh=9m9U4l7wYrd0KILh8tlZ5w2ArvGB12amjyj2xK/vfQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuYyZqKny34lSzuqqPqlE3agl/AzfNr+p5AgOuBIV6PWRS7VCtPh/zbw7PY+LwYPoFIA/uk/U8wPfn6/P9leAZCqDhZSokCBz21tucqIbBOfOkdqr8RkoYX1eA7tOh4iQ+DnnMllr0y3Vo/dFNAgnE+vHRPDEEgsq3ab0YQMhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HC33c1Rn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HC33c1Rn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eBiHiyxpOrObyZU1UR4cIBSGislCQOpMdEhTpUbITdI=;
	t=1716570595; x=1717780195; b=HC33c1Rn7SBdWMWRwnIVyD409jLmtX3hHAvhPEZ1evQbd3V
	Y6jTIPFGTr97iqfVHfTiO07oTW3YvazxdTqzFnHorc3s22rx3UvKSpsnKhdIaBu/QK8LY02d9NNmF
	s/nrCVFCqSc17EycH1sTRxIQ/IhghxmQ061ENgDojS6NnCgtwmohqwzTZaOswn2EFGeFPJtppswMu
	Nab4Tkrx1Sl8Ay4eG8GcRWwGK7UMW8EXrTQhjN+XijSi24w2Hjsho4jdD9OsO0me4GtNuYZnGy0Ae
	fBrdMElEgVVWjezGTMABlN8B9u92zGlWTQUz/2+80x7DOuhg1qN9KcS6P4SwH2vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQS-00000008Xuw-2LQK;
	Fri, 24 May 2024 19:09:53 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 41/74] backport: move backport-6.4 forward to 6.5
Date: Fri, 24 May 2024 19:07:53 +0200
Message-ID: <20240524190907.026bded40a5d.I5dea5fdff090dacf29f0d046dabf1d8259e08405@changeid>
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

Move backport-6.4 to 6.5 and add some adjustments from
iwlwifi in kunit and thermal.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h     |  6 +++++-
 backport/compat/Makefile                      |  2 +-
 .../compat/{backport-6.4.c => backport-6.5.c} | 21 +------------------
 3 files changed, 7 insertions(+), 22 deletions(-)
 rename backport/compat/{backport-6.4.c => backport-6.5.c} (65%)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 210292509ac3..39b7ca476a3c 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -34,7 +34,11 @@ thermal_zone_device_register_with_trips(const char *type,
 #endif /* <6,0,0 */
 
 #if LINUX_VERSION_IS_LESS(6,4,0)
-void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
+#define thermal_zone_device_priv LINUX_BACKPORT(thermal_zone_device_priv)
+static inline void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
+{
+	return tzd->devdata;
+}
 #endif /* < 6.4.0 */
 #else /* CONFIG_THERMAL */
 #if LINUX_VERSION_IS_LESS(5,9,0)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index d55437d70ae7..30f6180b3dea 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -17,7 +17,7 @@ compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
 compat-$(CPTCFG_KERNEL_5_15) += backport-5.15.o
 compat-$(CPTCFG_KERNEL_6_0) += backport-6.0.o
-compat-$(CPTCFG_KERNEL_6_4) += backport-6.4.o
+compat-$(CPTCFG_KERNEL_6_5) += backport-6.5.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-6.4.c b/backport/compat/backport-6.5.c
similarity index 65%
rename from backport/compat/backport-6.4.c
rename to backport/compat/backport-6.5.c
index af872e5de04d..a27306aa6a6a 100644
--- a/backport/compat/backport-6.4.c
+++ b/backport/compat/backport-6.5.c
@@ -2,10 +2,8 @@
 
 #include <linux/types.h>
 #include <linux/netdevice.h>
-#include <net/dropreason.h>
-#include <linux/thermal.h>
 
-#if LINUX_VERSION_IS_GEQ(6,2,0) && defined(CONFIG_KUNIT)
+#if LINUX_VERSION_IS_GEQ(6,2,0) && IS_ENABLED(CONFIG_KUNIT)
 #include <kunit/test.h>
 
 struct kunit_auto_cleanup {
@@ -45,20 +43,3 @@ void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t cleanup_func,
 }
 EXPORT_SYMBOL_GPL(kunit_add_cleanup);
 #endif /* LINUX_VERSION_IS_GEQ(6,2,0) */
-
-void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
-				  const struct drop_reason_list *list)
-{}
-EXPORT_SYMBOL_GPL(drop_reasons_register_subsys);
-
-void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys)
-{}
-EXPORT_SYMBOL_GPL(drop_reasons_unregister_subsys);
-
-#ifdef CONFIG_THERMAL
-void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
-{
-	return tzd->devdata;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
-#endif /* CONFIG_THERMAL */
-- 
2.45.1

