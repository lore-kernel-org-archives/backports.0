Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399D12EBD5
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570632; cv=none; b=AW9TsbXblVDMR1TtrgbJWBTjtK2gupvc2qBOtCmWwNimdcKfTTPBAEmlhXJZp9/m3upPsqEJ6rh1dds5LUkDHnRmmEPpGq5h6w/xzBaCW4YchWkvIhVRtnA0sF+sCz4qOZxWJSRSKUj/2YfND+p/+LzvP5LdhtdIhcVN4RvA9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570632; c=relaxed/simple;
	bh=wpCXVhxr4IAm9yC+7GUbiofb8qWo66VoFMakST37Svw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSae79OZS/SQ+s2BT5YnGCNSGrkAAFF84x+bsLhjk9n51LY5x0ENrbgMbAgtX7c2kcsAdah8ShgIyvshtCthFtobd48OTlUDnwqln0uxpn9Ye2IKKw6d1GZzoa0VY5xx79oQYM1N6tc9wXeKtOlYIaaXw43shi+LjRuXvaGpVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KepORipF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KepORipF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rxuySBm4Dea+MYM3qghp9v7ljZHUVU7zg5J56OhFycw=;
	t=1716570630; x=1717780230; b=KepORipFj5gs5JQ7MXAV315JZX8g97DPnut5HPkIWwgqe8I
	BUrhbfw4k+z8YuH1De2g7v2wqQOZf9g66KNIbI94TD0F94uZF4GfxIZhPKLi6PJH4j0xm6Gu10HdJ
	Ijs1y2lcVNPoLRF5p6EINdr3qxFcd0QvYI9F269I474Z5Isvlpeo2p/SfoCEut450jO1lwZt83Ix7
	X5js1umei2P46q8Hbi+TFPpZ2g/svkuRFBDPuS03vw+8kqzeY66sb1s0qYFg6KkVTvH4TaNaGLTKo
	POxr9C5npvBzDNNvp9HWWuvzg6hq3lLIvkFfV/25rzibJNseeDmx6TkD30Y9boTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYR1-00000008Xuw-3rob;
	Fri, 24 May 2024 19:10:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 72/74] patches: add patch for class_create() in hwsim
Date: Fri, 24 May 2024 19:08:24 +0200
Message-ID: <20240524190908.30870adf76f4.I5f967e020ac6400b14780e6fd8c757530b3efee9@changeid>
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
 patches/0086-hwsim-class-create.patch | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/0086-hwsim-class-create.patch

diff --git a/patches/0086-hwsim-class-create.patch b/patches/0086-hwsim-class-create.patch
new file mode 100644
index 000000000000..786a5966be0d
--- /dev/null
+++ b/patches/0086-hwsim-class-create.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
++++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
+@@ -6564,7 +6566,11 @@ static int __init init_mac80211_hwsim(void)
+ 	if (err)
+ 		goto out_exit_netlink;
+ 
++#if LINUX_VERSION_IS_GEQ(6,4,0)
+ 	hwsim_class = class_create("mac80211_hwsim");
++#else
++	hwsim_class = class_create(THIS_MODULE, "mac80211_hwsim");
++#endif
+ 	if (IS_ERR(hwsim_class)) {
+ 		err = PTR_ERR(hwsim_class);
+ 		goto out_exit_virtio;
-- 
2.45.1

