Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190212EBFA
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570564; cv=none; b=WwhE30ztqxIwoNp++fKIqirBOxZ6qnYes3SRmSp/o8QjDyxkcz1aPKW5zkYE13jsbCHjyBaykNSDq6uXU7vhvf5WTLG7+c2zxoV3ehDUvGN6jjffIl3KHeS32UzvyChCrkuhNmVduPWRaO9Ce8mlQxVxU3cst4CvvGJY3eLzm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570564; c=relaxed/simple;
	bh=srdfCEs2V6qulytPNcCqGQwkpwj4G9C0pRMe7fsx1c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gen7sr2d2LxONy89M4+cKUISbPqrRNfg3zmMRD4VR19TLAgxdWOHZotT2gtZ42jHwb/AKd7jgrZPQW9kkT37X5bV15shvTe+AqKW0sCvKgfBcMMRos+/xQGvimMYrSPZRrX57bmmEG2Vc65dvDC9XTVqU70RyvHdpzze8maQYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sNutgKWE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sNutgKWE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GlFunf2neCwzdqBa/BZYTaJAjlLoyS6g71JZBxbyNzU=;
	t=1716570563; x=1717780163; b=sNutgKWEynFumMwVWTDLEx5bus50xcwjDsoFn++i0YAHMtM
	LXCwIcMbIP3rHUQhSFT64PbdsUH1Oh2mfiKRwlTIDVY3mI+INfJl4GSG5wfF9itbY2NuwJu2+b/Bf
	/L/oFatVss73+kMk2YW2wPMLy5/xOXXU/7p4AzA/xIHOx2DYRXh6Wg90ViMSf+3aUtuwbtWKO6OzQ
	ev01r0oIdsfv3Eg+XrowqkXnaqckhPbC1PH/xIup09RlptLmux4+R02qtg7XI4UL8Q7qpSqZafAc4
	ObEYTHxJJdf2efOWGtlAsoFjNpYWkTSDA99Qg0O3Na86W57UVvgjXAO13oX2Zu3g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPw-00000008Xuw-28VX;
	Fri, 24 May 2024 19:09:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/74] backports: adjust namespace argument const
Date: Fri, 24 May 2024 19:07:24 +0200
Message-ID: <20240524190906.2fce117fbf36.Iedd62c5e3204ee9d1ba2b370a930d19409d7ef37@changeid>
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

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/device.h |  6 ++++++
 patches/0108-namespace-arg-const.cocci   | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 patches/0108-namespace-arg-const.cocci

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 46f2190b06c4..1e5a5534340e 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -7,4 +7,10 @@
 	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
 #endif
 
+#if LINUX_VERSION_IS_LESS(6,2,0)
+#define __ns_const
+#else
+#define __ns_const const
+#endif
+
 #endif /* __BACKPORT_DEVICE_H_ */
diff --git a/patches/0108-namespace-arg-const.cocci b/patches/0108-namespace-arg-const.cocci
new file mode 100644
index 000000000000..a03f32c0010e
--- /dev/null
+++ b/patches/0108-namespace-arg-const.cocci
@@ -0,0 +1,20 @@
+@ns@
+identifier cls, fn;
+identifier __class =~ "class";
+@@
+struct __class cls  = {
+	.namespace = fn,
+	...
+};
+
+@@
+identifier ns.fn, d;
+attribute name __ns_const;
+@@
+fn(
+-const struct device *d
++__ns_const struct device *d
+ )
+{
+	...
+}
-- 
2.45.1

