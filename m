Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0012E1EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570593; cv=none; b=Dm39KtdXM4Hb0bvIZhkpKNpqJGOGix6baNLcqhEI/HRSiMprIfI1e622aQCfwHzwDfzdNx1hK0lAmL08jZIi96ks1YOuVJ7OhtoaMxF1MrjRZ91sb48p7SyJ249n8wE8MhqGvqCGj/8lNVyJZAXAmslSqLJeK+FoD4E8DgCDOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570593; c=relaxed/simple;
	bh=y8poYnG3DnYoyyCL4Xj4W7f2BG4FJ/bDp9zXXHk3uSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3ghV20srqH4+NFDUO0natu+4UE5zbliYPY8a2cmyyCpuE3ILMudZaxSdKlf0gv3jzKW4gBLpn3AFy/g9/YjvQLcdu+q4OMHyQjdQ1EQHTeYJzdsaVAIcCp1H0kmJXAKYJ72bS6vuvm/p7oqtgonJKop5GkX4PfVLjIcqxdC0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uHVyphOM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uHVyphOM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=U3Y5CiCnaytMHNjNQ0Es0H6ho3SC3U48BcRJCuHvadY=;
	t=1716570592; x=1717780192; b=uHVyphOMnGXuEuTnlZpfD1samYxvbtZYLKW00kD7HABdsvC
	pJw02CekjkoKY9PN/Q6B8n3h7RXOdcCtF0z2ZF1yFdnjyRs6S+v+lB+k3768Kg5Ti73H+MrwLai77
	ZnJeb0TefEZDERgMZq49Te93kWVf9UldbgJ6PgF2+fitYlSljWXzPwi0wyfPCuf2KbeNL2xGu18Ib
	j3grUUEbGakOVWjXBG1bo26HgXwtwCdGvHZdKePzjQPGx1oKhR1T84j8ajNi+5gQUET84YQVMvGOf
	VlvymaX47cc2se+zl2DBkxWuHL3te0wp6kNqHWQ1v8Gfj4hvJFGy6+LnZQC5hdhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQP-00000008Xuw-2CRD;
	Fri, 24 May 2024 19:09:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 39/74] backports: handle thermal_zone_device_priv() for kernels < 6.4
Date: Fri, 24 May 2024 19:07:51 +0200
Message-ID: <20240524190907.ba6770df16be.I6eb167fc3c298f366fbee88e246be20c58beb6f4@changeid>
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

This function was added in v6.4-rc1.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h | 12 ++++++++++++
 backport/compat/backport-6.4.c            |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 76d4f231aa5a..2e0fcb6b3d28 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -13,6 +13,10 @@ static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
+
+#if LINUX_VERSION_IS_LESS(6,4,0)
+void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
+#endif /* < 6.4.0 */
 #else /* CONFIG_THERMAL */
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #define thermal_zone_device_enable LINUX_BACKPORT(thermal_zone_device_enable)
@@ -23,6 +27,14 @@ static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 #endif /* < 5.9 */
+
+#if LINUX_VERSION_IS_LESS(6,4,0)
+#define thermal_zone_device_priv LINUX_BACKPORT(thermal_zone_device_priv)
+static inline void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
+{
+	return NULL;
+}
+#endif /* < 6.4.0 */
 #endif /* CONFIG_THERMAL */
 
 #endif /* __BACKPORT_LINUX_THERMAL_H */
diff --git a/backport/compat/backport-6.4.c b/backport/compat/backport-6.4.c
index d26f46ebddde..af872e5de04d 100644
--- a/backport/compat/backport-6.4.c
+++ b/backport/compat/backport-6.4.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
 #include <net/dropreason.h>
+#include <linux/thermal.h>
 
 #if LINUX_VERSION_IS_GEQ(6,2,0) && defined(CONFIG_KUNIT)
 #include <kunit/test.h>
@@ -53,3 +54,11 @@ EXPORT_SYMBOL_GPL(drop_reasons_register_subsys);
 void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys)
 {}
 EXPORT_SYMBOL_GPL(drop_reasons_unregister_subsys);
+
+#ifdef CONFIG_THERMAL
+void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
+{
+	return tzd->devdata;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
+#endif /* CONFIG_THERMAL */
-- 
2.45.1

