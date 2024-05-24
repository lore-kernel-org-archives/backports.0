Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA7376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570592; cv=none; b=GZNWTVfEgoA0CMencLaKBDzRwJ1ELgpK+6mwkSqVZZWp+ETISv6DYPbPIcy0U6CGIjpVPV9nlBROSXP4YXA56dErDrNF2iXruGrdGWyhADeifMSd3dzoZqoY2rrwIObElv3XnJ5Srlk+G8ErwP49m7HVXo7dcWDGSwNuB5si41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570592; c=relaxed/simple;
	bh=uliRjOQR0+/6G0ruJ6s5WFoFgLT2MUxA2bB83oc9uB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Otz8EZpjat6HA8iFFzAtFDYKWczDFZmqy9ZKqVSF0LWHkg+GdWI67+g6O9bn9BAhLewKOSQKjXS5SbQByW4i0KTi/LgYhyTebvGFinfRwXQ3Qx87oDjHh6Zog3qgL0tShRJoIaQYN0Tth+usuvG5ttZPkd4RYBfdtf9l3UZKVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=arvQFNqN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="arvQFNqN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WGOFHhKTTHEwF21Lzyq8RdgPJTJYzZGTkXS8shUd0T4=;
	t=1716570591; x=1717780191; b=arvQFNqNIgIzixZeov3s8CP3M1kjbsA8ArgOiRxAK30PM5i
	Sw8Ksorw9gHon2FMUZd52CeAwwQ8u/oTw1ha12cxOseEWF19hODmdDk584ZLpeToDEnJc6yi2YfvC
	UXHg1aSCx0F3TDAZyfvRH5SYER0J7m2fUGPzU0CFGW4D+ZrI7ivP99wFzsUzKIWvDuz8vxxy+5PF3
	paUsddYPiAk9ryv/birhx/uE4VQm5Q4J9CFI5ey/UY35rhYfz4nv3vUSheWeIbBPdPxhiVmmNhkA0
	wol6n1gMKuBop6Ceiw/yVVB+ngFVgh0dVCXb4RRLO+w7zaidYTM8anKmpDOgBUZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQM-00000008Xuw-05tN;
	Fri, 24 May 2024 19:09:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 38/74] thermal: return errors w/o CONFIG_THERMAL
Date: Fri, 24 May 2024 19:07:50 +0200
Message-ID: <20240524190907.ff076c34dfbe.I380a5ee9df3ecaceba5ffaf92b5ad41138b96567@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index d9b8153e9c87..76d4f231aa5a 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -3,6 +3,7 @@
 #include_next <linux/thermal.h>
 #include <linux/version.h>
 
+#ifdef CONFIG_THERMAL
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #define thermal_zone_device_enable LINUX_BACKPORT(thermal_zone_device_enable)
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
@@ -12,5 +13,16 @@ static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
+#else /* CONFIG_THERMAL */
+#if LINUX_VERSION_IS_LESS(5,9,0)
+#define thermal_zone_device_enable LINUX_BACKPORT(thermal_zone_device_enable)
+static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
+{ return -ENODEV; }
+
+#define thermal_zone_device_disable LINUX_BACKPORT(thermal_zone_device_disable)
+static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
+{ return -ENODEV; }
+#endif /* < 5.9 */
+#endif /* CONFIG_THERMAL */
 
 #endif /* __BACKPORT_LINUX_THERMAL_H */
-- 
2.45.1

