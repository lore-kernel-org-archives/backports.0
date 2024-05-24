Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B3376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570595; cv=none; b=WqlCOrUinu7ZXGA/nJ5w+ZokKmm9cCNOB8sbqvolcZEhgJ6I+0rG9e3UTe+iTXxwrDmcc/h53czKLlSdYKAnsS5qeb29SZaVmCIi5A/CA6kKnCohmT3JzsTZp88ynCsxAmMouOtiwI6zSZ1XqCRpGKMKUV0bC+7ELQd3D+2lHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570595; c=relaxed/simple;
	bh=Ee7989dLOj4cWvlMWUJyIH670Ybqdv9VqniLMPtTjRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hifWQbMHQmYSC6GgTQiQV1iex2r011zW6NcI3mApN2mA8PRxWpiZbTw6LzhQnqfmvy6tRP+khQ5y0T9kSqllkZ6bvm/HzmwzxtoTVZFOiwSCbB/zS3/n428kFPER4aInoQyD7PU/HA5XSB6wFsjOI7WHlT+wLgADHkRgHQJ9nmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pQXCzlnT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pQXCzlnT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L8HPthczws/bS4VpOU288azrZ170QPZBwB9wbajCjF4=;
	t=1716570594; x=1717780194; b=pQXCzlnTi4v+u99ovI1MQUSSvTmY399VF6BOT5S00bY3BW7
	YnMaNVS4/PrGnVXdBxLoAvvNVUT9+iXg/5QQdkpsVevr9wCy4ZCyj4naEHNcYN5Tg0Bh1MRW+nLxW
	hhostsQNXbLdsMlXgZDiQPR5lmvXmZNY9tuYowODzzQmjuLpxFgdA5yrfKr2k0IgLNRBKJ+KGQV/S
	wYGPSLBsPJhA8v5vBpUrqpwZUpToPOpbrwnq2VsVTtFXBmUiwXGQZ607yFBDBOyLwMNCyoQtgbBVs
	vnCMgovAO562hLlcJ7f80c2EWGfgU5ja9iEyg8kjFemui6gVSo2Xtv1Phau4lSxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQR-00000008Xuw-0Z8Z;
	Fri, 24 May 2024 19:09:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 40/74] backports: handle thermal_trip for kernels < 6.0
Date: Fri, 24 May 2024 19:07:52 +0200
Message-ID: <20240524190907.394dd12cb9eb.I0ae8b3f6d3d2784b230050d7d173921228d3f81f@changeid>
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

thermal_trip struct was removed in kernel 5.10 and added
back in 6.0; in addition 6.0 got some other changes.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h | 34 +++++++++++++++++++++++
 backport/compat/Makefile                  |  1 +
 backport/compat/backport-6.0.c            | 19 +++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 backport/compat/backport-6.0.c

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 2e0fcb6b3d28..210292509ac3 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -14,6 +14,25 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
 
+#if LINUX_VERSION_IS_LESS(6,0,0) && LINUX_VERSION_IS_GEQ(5,10,0)
+struct thermal_trip {
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+};
+#endif
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+struct thermal_zone_device *
+thermal_zone_device_register_with_trips(const char *type,
+					struct thermal_trip *trips,
+					int num_trips, int mask, void *devdata,
+					struct thermal_zone_device_ops *ops,
+					struct thermal_zone_params *tzp,
+					int passive_delay,
+					int polling_delay);
+#endif /* <6,0,0 */
+
 #if LINUX_VERSION_IS_LESS(6,4,0)
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 #endif /* < 6.4.0 */
@@ -28,6 +47,21 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 #endif /* < 5.9 */
 
+#if LINUX_VERSION_IS_LESS(6,0,0)
+#define thermal_zone_device_register_with_trips LINUX_BACKPORT(thermal_zone_device_register_with_trips)
+static inline struct thermal_zone_device *
+thermal_zone_device_register_with_trips(const char *type,
+					struct thermal_trip *trips,
+					int num_trips, int mask, void *devdata,
+					struct thermal_zone_device_ops *ops,
+					struct thermal_zone_params *tzp,
+					int passive_delay,
+					int polling_delay)
+{
+	return NULL;
+}
+#endif
+
 #if LINUX_VERSION_IS_LESS(6,4,0)
 #define thermal_zone_device_priv LINUX_BACKPORT(thermal_zone_device_priv)
 static inline void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 62dfc62f7b46..d55437d70ae7 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -16,6 +16,7 @@ compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
 compat-$(CPTCFG_KERNEL_5_15) += backport-5.15.o
+compat-$(CPTCFG_KERNEL_6_0) += backport-6.0.o
 compat-$(CPTCFG_KERNEL_6_4) += backport-6.4.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
diff --git a/backport/compat/backport-6.0.c b/backport/compat/backport-6.0.c
new file mode 100644
index 000000000000..7cb699fc0007
--- /dev/null
+++ b/backport/compat/backport-6.0.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+#include <linux/thermal.h>
+
+#ifdef CONFIG_THERMAL
+struct thermal_zone_device *
+thermal_zone_device_register_with_trips(const char *type,
+					struct thermal_trip *trips,
+					int num_trips, int mask, void *devdata,
+					struct thermal_zone_device_ops *ops,
+					struct thermal_zone_params *tzp, int passive_delay,
+					int polling_delay)
+{
+	return thermal_zone_device_register(type, num_trips, mask, devdata, ops, tzp,
+					    passive_delay, polling_delay);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
+#endif /* CONFIG_THERMAL */
-- 
2.45.1

