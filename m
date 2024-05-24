Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346686AD6
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570619; cv=none; b=YzZSuiFQbGmNYiuwUS1Yodgq6e1av8ipfIwANx7ZId8r8KFtedpbjuUM7Fu3o7ttCI34/P98k2f44z7lpq7aeI45IeZWc8hYt06Q+0ivsYWShDA6USbjGTThKxJxwdRr6VIWYUegZNh0Si5ZT2zwPU+hFEjlsNiNOoqdEicAjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570619; c=relaxed/simple;
	bh=g/sQAnLndmW0MKjbjCqBFNSToU45cQEnuCLPmdqeWxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuOz1qzt9Kg+mGA4C8GNnVlZxIKkx9qOQ1UO7+7Rgg7dZoFtHDv5MDra4h9rCgXVgccu9OWRZkEkVXGBVZid3+xLTr6O6FXM54p5r1f6mPH5WgzfWd/OXxNktBxSy1lmzStH51UeSdCiBduINt5EGiCmX0m/j4VntqwA28Sm0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C6oFBpzD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C6oFBpzD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ouomGQfX6m3cakEzgsWojoSqlCCPi++TLp56wOT2SdI=;
	t=1716570618; x=1717780218; b=C6oFBpzDjCjSVWLchszMKK8/K1vZVYGI6mKHIIp7dh6MRl3
	Gw45dcYQrNGf1hNPPTT96WrdlfD3LGl/BTOUCvmNd+ZEUJVRD2STTxyUSwD243Xwxx+UvhphLyQJn
	krSNOG0vlXIVwZZry/T0Zxm9GKUpW2TLtjqwdD77fowEZ5/ioSL/yhmzhdy9xZDniCYESzpOV5WPM
	jGFk6dFkIoOU57jUtDyuA3wJPOfvwn862DittPoqJuRnngI9mA0vfW9hJatHUhBgCLuswMMCP3EFE
	EcZsNyBTKffU0Oy18n2Y23TsSjAf2uLbkb1gLaUgu37qjciLo+Wz2ilt/GbOs1EQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQp-00000008Xuw-1fql;
	Fri, 24 May 2024 19:10:15 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 63/74] backports: update 0028-select_queue/mac80211.patch
Date: Fri, 24 May 2024 19:08:15 +0200
Message-ID: <20240524190907.47b2dd588aa1.Ie02c93aec74e8fa7125a1620808a6093c23cdeb3@changeid>
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

The code in net/mac80211/iface.c changed, commit
107395f9cf44 ("wifi: mac80211: Drop support for TX push path")
removed the code referenced by the patch. Fix mac80211.patch
accordingly.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0028-select_queue/mac80211.patch | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 64a397b96280..d2f2c8c13da8 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,27 +1,5 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -697,9 +697,21 @@ static void ieee80211_uninit(struct net_
- 	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
- }
- 
-+#if LINUX_VERSION_IS_GEQ(5,2,0)
- static u16 ieee80211_netdev_select_queue(struct net_device *dev,
- 					 struct sk_buff *skb,
- 					 struct net_device *sb_dev)
-+#elif LINUX_VERSION_IS_GEQ(4,19,0)
-+static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-+					 struct sk_buff *skb,
-+					 struct net_device *sb_dev,
-+					 select_queue_fallback_t fallback)
-+#else
-+static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-+					 struct sk_buff *skb,
-+					 void *accel_priv,
-+					 select_queue_fallback_t fallback)
-+#endif
- {
- 	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
- }
 @@ -721,9 +733,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
-- 
2.45.1

