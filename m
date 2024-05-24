Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D1376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570597; cv=none; b=p3RqC23/fWWmLIN75wevsLvOV6t8zi0cYJoXsNJxVoSIgeuXuEalvPTBbMg22FEHjBQnOgqEMgCCBeGaKZP+cbkhFbQ7R92Q67VuAPt/Vioi6SSumrIkaPYu/zfBDa9aNK8piVn6j5TY1t5uoSbtye28qK3gJLyvE57k/JVo5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570597; c=relaxed/simple;
	bh=ru7FRx5T2zjARZdCfVoFaduHxf5hbZkxa7Ba9hvZnOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc9Yc/JFzmCBcvcjYtyscLMQpllW6ipd8y8A0oLf0SQXqbFoa8YAGZ/lX+dPDVaOCaArfaxOTvu59dhIGUIu6BirQRni+o0eGOuGvi9keEnH4Ai0fX6wNhMU2lj5DuXmWQA0NSBPNaMl4hmJM6jlWCefPCUmFINZh/M9THhTLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xoI5Dh/e; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xoI5Dh/e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=McFCxiVt0ZpiC5jPSgjipyQWJG0zPtRBUrv6/5Xcq5U=;
	t=1716570596; x=1717780196; b=xoI5Dh/eFhafC+T+rGc352A5Ejx6tsH3jYkIOHkc2dC7zBp
	SLlgPHz+jNbJ28YPrXJScVFql7Vsd+5+JgyNEn83kbU8hykWZWGEDeMSbX1ZfS+6gbKEAo+IJLvxK
	Es2u8e4IhWiYgyNlYnv1FQfYARwrSBpQcUuEF1FGw735XuGEs6GNrkPqRMSpu2iyL9YU7FZbEMF8P
	WKrYPO1oZ/kK3IR0KSIi0h+UoUx2AqZ5S3Sh+tZKuqzjh3Dzo08nPCAyuVZ2gaHQCImX0Oph0Hb9R
	2Th4pQaoqNwzuS+0agsTRxHNVI6bvQI0b+SqmkX5IKL0aI11UMv+rAQdY4ThVrBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQU-00000008Xuw-1728;
	Fri, 24 May 2024 19:09:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 42/74] backports: adjust thermal APIs to 6.9
Date: Fri, 24 May 2024 19:07:54 +0200
Message-ID: <20240524190907.b25de3dd9bcf.Ifa45e067fb399ab7fe131a183c462a8a19b867a4@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

- for_each_thermal_trip was added in 6.9, backport it for kernel
  versions that are < 6.9.0 and >= 6.0.0. Kernel versions < 6.0.0
  have the trips internal to the thermal core, so no access to it, on
  the other hand, the local (driver allocated) trips have invalid
  temperature values anyway, so no point iterating those trips,
  so added an empty backport for these kernels.
- struct thermal_trip has a few new fields, add these fields and extend
  the 6.0.0 to 6.9.0
- thermal_zone_device_register_with_trips is no longer supporting the
  mask argument, instead we have:
- THERMAL_TRIP_FLAG_RW_TEMP as a flag of a thermal_trip

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h     | 45 ++++++++++++++++---
 backport/compat/Makefile                      |  2 +-
 .../compat/{backport-6.0.c => backport-6.9.c} |  4 +-
 3 files changed, 42 insertions(+), 9 deletions(-)
 rename backport/compat/{backport-6.0.c => backport-6.9.c} (79%)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 39b7ca476a3c..942883dc1f40 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -14,24 +14,57 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
 
-#if LINUX_VERSION_IS_LESS(6,0,0) && LINUX_VERSION_IS_GEQ(5,10,0)
+#if LINUX_VERSION_IS_LESS(6,9,0) && LINUX_VERSION_IS_GEQ(5,10,0)
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
+	int threshold;
 	enum thermal_trip_type type;
+	u8 flags;
+	void *priv;
 };
 #endif
 
-#if LINUX_VERSION_IS_LESS(6,0,0)
+#if LINUX_VERSION_IS_LESS(6,9,0)
+#define THERMAL_TRIP_FLAG_RW_TEMP       BIT(0)
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type,
 					struct thermal_trip *trips,
-					int num_trips, int mask, void *devdata,
+					int num_trips, void *devdata,
 					struct thermal_zone_device_ops *ops,
 					struct thermal_zone_params *tzp,
 					int passive_delay,
 					int polling_delay);
-#endif /* <6,0,0 */
+#endif /* <6,9,0 */
+
+#if LINUX_VERSION_IS_LESS(6,6,0) && LINUX_VERSION_IS_GEQ(6,0,0)
+static inline
+int for_each_thermal_trip(struct thermal_zone_device *tz,
+			  int (*cb)(struct thermal_trip *, void *),
+			  void *data)
+{
+	int ret;
+
+	for (trip = tz->trips; trip - tz->trips < tz->num_trips; trip++) {
+		ret = cb(trip, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif /* < 6,6,0 && >= 6,0,0 */
+
+/* for < 6,0,0 the trips are invalid anyway*/
+#if LINUX_VERSION_IS_LESS(6,0,0)
+static inline
+int for_each_thermal_trip(struct thermal_zone_device *tz,
+			  int (*cb)(struct thermal_trip *, void *),
+			  void *data)
+{
+	return 0;
+}
+#endif
 
 #if LINUX_VERSION_IS_LESS(6,4,0)
 #define thermal_zone_device_priv LINUX_BACKPORT(thermal_zone_device_priv)
@@ -51,12 +84,12 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 #endif /* < 5.9 */
 
-#if LINUX_VERSION_IS_LESS(6,0,0)
+#if LINUX_VERSION_IS_LESS(6,9,0)
 #define thermal_zone_device_register_with_trips LINUX_BACKPORT(thermal_zone_device_register_with_trips)
 static inline struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type,
 					struct thermal_trip *trips,
-					int num_trips, int mask, void *devdata,
+					int num_trips, void *devdata,
 					struct thermal_zone_device_ops *ops,
 					struct thermal_zone_params *tzp,
 					int passive_delay,
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 30f6180b3dea..bb6fb57edc7e 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -16,7 +16,7 @@ compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
 compat-$(CPTCFG_KERNEL_5_15) += backport-5.15.o
-compat-$(CPTCFG_KERNEL_6_0) += backport-6.0.o
+compat-$(CPTCFG_KERNEL_6_9) += backport-6.9.o
 compat-$(CPTCFG_KERNEL_6_5) += backport-6.5.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
diff --git a/backport/compat/backport-6.0.c b/backport/compat/backport-6.9.c
similarity index 79%
rename from backport/compat/backport-6.0.c
rename to backport/compat/backport-6.9.c
index 7cb699fc0007..6ae485da3975 100644
--- a/backport/compat/backport-6.0.c
+++ b/backport/compat/backport-6.9.c
@@ -7,12 +7,12 @@
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type,
 					struct thermal_trip *trips,
-					int num_trips, int mask, void *devdata,
+					int num_trips, void *devdata,
 					struct thermal_zone_device_ops *ops,
 					struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
 {
-	return thermal_zone_device_register(type, num_trips, mask, devdata, ops, tzp,
+	return thermal_zone_device_register(type, num_trips, 0, devdata, ops, tzp,
 					    passive_delay, polling_delay);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
-- 
2.45.1

