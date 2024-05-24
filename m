Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ACA12EBD4
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570598; cv=none; b=jrboxh820JQ5+iyI/nCysHmh0AGibkiA3GnbIK74VI3ruPQNRehls6LV+1qgdDnMVft2JLBd7SQyEZFhggou1Zfj5DrGJp5nr8oxZES/rSrcJRGHuPyJQJgsZUGeHDwrW1YOO2VG7rNZxP05HPM0yGeLsRkOYedooP6WxzMyStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570598; c=relaxed/simple;
	bh=+M4/RmqbM2b5wUp1FoMkbx2xaslXEhbRInfCNxRcB0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXem2svh+RmkJh6mGi9+U7KrJjbaqppmOnooqAYlf69nr1umy+dvDTwXYbo5SE9uPPwJ+2DSuPFFVN40kk6arC9PYVCznBdQtQ095zc2g33LOokdFhEH9KQ9Scy78TWNqP9ZkWlaiV7Pigzv/OWcGtLY6Xwzp8VSQTbQ6vbf5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pf0bg6Op; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pf0bg6Op"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A3IpyZa4XFQyZES7QShs9kMX8AzIgMleuBRu72f21Y8=;
	t=1716570597; x=1717780197; b=pf0bg6OphtA1n1mhV3gQKD+IgO3qH5F540U/18OKUZiSOva
	MAd6BtEj5u0kbCq2l+yBeJ9kOYFxcXdpTsgr7Dhi1uWPlqEDP47FjAwh5NWV8qNfUNOqjlK3xt+0x
	O0XMUMjeoQQDeJ0XX7Tkzi5/sMCXPqPu/mdXfbjJ1IqV11O4d3IxjjOLd1KzUOx8EpQNY86bA7t66
	tuiAcYuAdGpGpf/JsbTLEBhZ5GSKJe5FNpnzhtF2TPdyDSTnzaGkCctoHrPj/4RSdan4ch9grpMVP
	j7go6i5y2vvroWVCvTmMJ0A+rcQy9gC1N7mdVYj39CP9xbLpHhSo0SLpPZOH+ErA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQU-00000008Xuw-46xt;
	Fri, 24 May 2024 19:09:55 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 43/74] backports: fix thermal backports
Date: Fri, 24 May 2024 19:07:55 +0200
Message-ID: <20240524190907.66a66be05882.I3d068f89b7527c0baecb7d320d1b80ef378fca61@changeid>
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

- backport struct thermal_trip also for kernel versions 5.10-, to have
  the flags field.
- backport for_each_thermal_trip also for kernel versions [6.6, 6.9),
  Since for this kernels we use the backported thermal_trip struct

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 942883dc1f40..546caca8108c 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -14,8 +14,8 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
 
-#if LINUX_VERSION_IS_LESS(6,9,0) && LINUX_VERSION_IS_GEQ(5,10,0)
-struct thermal_trip {
+#if LINUX_VERSION_IS_LESS(6,9,0)
+struct backport_thermal_trip {
 	int temperature;
 	int hysteresis;
 	int threshold;
@@ -23,10 +23,11 @@ struct thermal_trip {
 	u8 flags;
 	void *priv;
 };
-#endif
+#define thermal_trip backport_thermal_trip
 
-#if LINUX_VERSION_IS_LESS(6,9,0)
 #define THERMAL_TRIP_FLAG_RW_TEMP       BIT(0)
+
+#define thermal_zone_device_register_with_trips LINUX_BACKPORT(thermal_zone_device_register_with_trips)
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type,
 					struct thermal_trip *trips,
@@ -37,15 +38,18 @@ thermal_zone_device_register_with_trips(const char *type,
 					int polling_delay);
 #endif /* <6,9,0 */
 
-#if LINUX_VERSION_IS_LESS(6,6,0) && LINUX_VERSION_IS_GEQ(6,0,0)
+#if LINUX_VERSION_IS_LESS(6,9,0) && LINUX_VERSION_IS_GEQ(6,0,0)
+#define for_each_thermal_trip LINUX_BACKPORT(for_each_thermal_trip)
 static inline
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data)
 {
+	struct thermal_trip *trip;
+	struct thermal_trip *trips = (void *)tz->trips;
 	int ret;
 
-	for (trip = tz->trips; trip - tz->trips < tz->num_trips; trip++) {
+	for (trip = trips; trip - trips < tz->num_trips; trip++) {
 		ret = cb(trip, data);
 		if (ret)
 			return ret;
@@ -53,7 +57,7 @@ int for_each_thermal_trip(struct thermal_zone_device *tz,
 
 	return 0;
 }
-#endif /* < 6,6,0 && >= 6,0,0 */
+#endif /* < 6,9,0 && >= 6,0,0 */
 
 /* for < 6,0,0 the trips are invalid anyway*/
 #if LINUX_VERSION_IS_LESS(6,0,0)
-- 
2.45.1

