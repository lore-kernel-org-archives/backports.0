Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607312EBD4
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570579; cv=none; b=YGKVdNtkYSEw0lfpEOz2ABnkiihPbKOgJKUJEvijITp7gZ1yoS8boFitaw5oNCowgn8nwZHeU7Tv+91W+L4sG7bqKei7vzsDLtH96DIAJplDL6clutcIfs5iMiXF/i8x9FKyj1MVsFC7Z2EHcR43mMmkpiCLyqo272rIimYcKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570579; c=relaxed/simple;
	bh=SSOH+jt5NvGJE6YxGC9QsW7pSGTxCnAxuBdevbMq/nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjXiLsvKoykilrpcqhDsElmPa5EKJ8bvGltrKJzNw7j28FPs2KjwEZJ1fSh3tyFrL7IkZbYOKv6zBXColL/yw2sXnQv+cVu3KjpkTTgrnikqd/vusd9uAa/8SLYA5Jnk7tgIkTrA3OG49VX3E3Lde1T0m8BPbHIHfYZddqrZbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k966ea7x; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k966ea7x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cNPQapZ7VKW+2zCCMWZiuFz5ZhfeIQlm4ffUWuvq8jw=;
	t=1716570578; x=1717780178; b=k966ea7x/y0ahL8poiiFe2bRnWpTorPzGokrQ8i/OAYbZG9
	A9pgiFGbrDda1DWech0C7tbEckrR1hKOKuYSOYxq2WzlVotS0bikekbFGMlUWuVJOvuEtgekjWOs9
	DCXAXh7TAG+NjAGKvR2iufFFudkcGFt6BgBv4WnTiJTsxVmRsh4S6R4/IeQKNnikif0tHXKf4Nlll
	3aYq4kzDWYrpwRZfIjZbwzYPdLnCefXfEbw/7qHgiBd7pVA76InIm2mhTNAkIPQMf8Zpjcy03oj8k
	hTyKBbC3phMb8bLxiiPlOL0tpq/Nm2snTvK/bdkmz9z4z+GfHpNGELfM4Qe/a8tQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQC-00000008Xuw-1Gpz;
	Fri, 24 May 2024 19:09:36 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 29/74] backports: add rfkill_soft_blocked()
Date: Fri, 24 May 2024 19:07:41 +0200
Message-ID: <20240524190907.8c3b5222cab8.Icd550ec514b6d1c90cb113b564c3897aab987d00@changeid>
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
 backport/backport-include/linux/rfkill.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index c0b99d58f9c0..d130c9b70c47 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -21,4 +21,13 @@ static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
 
 #endif /* 5.11 */
 
+#if LINUX_VERSION_IS_LESS(5,17,0) && !defined(CONFIG_WLAN_VENDOR_INTEL_MEI)
+
+static inline bool rfkill_soft_blocked(struct rfkill *rfkill)
+{
+	return rfkill_blocked(rfkill);
+}
+
+#endif /* 5.17 */
+
 #endif /* __BACKPORT_UAPI__RFKILL_H */
-- 
2.45.1

