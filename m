Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2312C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570561; cv=none; b=WMkCja2n9ThliwDtISSQzL8m2sTgzL6IPhUYjzOMlVQ86aRsGxKsO8eam6FfYoziTDIltZLrEVZ8WyT80wBgDywh+Eomu0ygODWpTmdcV3GnLdBfOmBR/bfaIkr3BnglAyhIvszMqA208uC9ztKpy8XgauGV8oUbmaRnR1bUNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570561; c=relaxed/simple;
	bh=hFyHjPiUFU23bXfK0Yt0gWm7ShPE84Y1s2VoEpbLX/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGuMKlb1dTvY/pvTcjJo6igFdDb067Va2K6ckAvRg+gkgC1CDbh3qwZRCMLgL9ktBwaeGcsCBv6OYb4fmvd9Ej/wvJxZONgcX7mcowXMldTCVJJWANP+z87PB501n1X78mqyq8duiWdpVDMtpD80ORXTE6oNi8jbEPOvuDNNMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A9vWalOM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A9vWalOM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TZH6sg472osSJvCrJbBlwmN4WYhiBJzkjqy6o+e8euM=;
	t=1716570559; x=1717780159; b=A9vWalOMWgcoqOR9XQ/iTVp1PVs+C8U9vlwPlZiePkw0ijL
	TnAYDUfxHL6rTYzWSo5RwsWyTiZ+3JyIaTYRfbHAcPVLunL6klpcuzTPj5bt1VzCgywFbaCV454/6
	WTWcogKNt3KlqlHfKHekZ+DkZXHn7qbHO4sI5VsbLNG5F8+mZtoHM9sNAZtDHoWRXzHUjWDSTiUzK
	ur/USY8NQC5etchoT4uXB2BbeXmqm+g6fJLwef0KlyMf9LDNHHUKKFft4GLSkLPJ0J47bxS84A11O
	upkU9a76CPJNeNPhOcIvfyd6VsMFWRELHJeLKM8crpgLTUw2adMi5JEpIFDyVotg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPs-00000008Xuw-2AAZ;
	Fri, 24 May 2024 19:09:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/74] backports: align x509_loader with newer kernels
Date: Fri, 24 May 2024 19:07:19 +0200
Message-ID: <20240524190906.5f730413052a.Icf65a934f1a62061da526c1c37f0c4ecf2b3c38a@changeid>
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

x509_load_certificate_list() was exported in kernel v6.3
by the commit
3609ff6401c3 ("wifi: cfg80211: Deduplicate certificate loading")
There's no any spcial Kconfig dependency for that, so make
it depend on the kernel version.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/keys/asymmetric-type.h | 7 ++++++-
 backport/compat/Makefile                         | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/keys/asymmetric-type.h b/backport/backport-include/keys/asymmetric-type.h
index 35ddd4008c60..7467be40d4fe 100644
--- a/backport/backport-include/keys/asymmetric-type.h
+++ b/backport/backport-include/keys/asymmetric-type.h
@@ -32,5 +32,10 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_1,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
+
 #endif
-#endif /* __BP_ASYMMETRIC_TYPE_H */
+
+int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
+			       const struct key *keyring);
+
+#endif /* _KEYS_ASYMMETRIC_TYPE_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 7c56e92f5ca4..1d47bd59fe90 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -36,6 +36,8 @@ compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/oid.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/asn1parse.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/rsapubkey.asn1.o
 
+compat-$(CPTCFG_KERNEL_6_3) += verification/x509_loader.o
+
 $(obj)/lib-oid_registry.o: $(obj)/oid_registry_data.c
 
 $(obj)/oid_registry_data.c: $(src)/../include/linux/backport-oid_registry.h \
-- 
2.45.1

