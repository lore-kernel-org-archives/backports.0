Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67712C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570630; cv=none; b=OGVEMGrpDcWmJFGxofK1GDv6ljxHFl0VaXJEzOduu4oOR7i0aoNMAcEGIYE40yqlUNiFWrPU4UTF8n//u5vEYonwoP4s198RyxozAS90LSlbYRIAlrCxevzywPM1Ql5DZCtaK0n9eJ+35fh8p6Gw7zyn0rPcywHUcsebik7ELsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570630; c=relaxed/simple;
	bh=d1BPhvRtWgz7rFn2VB/9ANhnpTVUa4npMC07vEPlE/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPAx04Emdh8qG317IF4Gy0PQznddyY4eKBpVA1c4C+YQz0g+Fao08+8Kv90e++N20ML7PP8QJY5jeVkqOxGcIvE+FfRKUZIE0PJQtwzo7gwH3zLezmflxjgNk0MW9xwdrIGB2iPp3VyNTz3UzgcnSkj2JUgNj0iFVQ8oljn0QKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K+38k0U3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K+38k0U3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A9ylCl4s6Ri5b4skZHVKWTbx0b2Mw78xfAGdbzJGVBI=;
	t=1716570629; x=1717780229; b=K+38k0U3tA/pWx2nTXwI8c36e5k/ydeSYIwEP25uFM7j5M+
	3ZIQUwdTYpIgjSLcqB0M4Cx6eCQve9gkOSx5Rz3ocUdo1Mo2fz7x3IGUGQUIMcPq4ahcw0+G2Glqn
	uSjMlyiv+3n+/oHa2Tz1wo/BE1xWprSqEBGWt1mIfKECpL8vYM4SxaFItvVcW1JaSl4qv1wyQXkIB
	pt8bj7Cy5YapWcjlmmnyG22m/1KorDhG9b0itxP1HyWRZfUeApMgD+zuEkNe1p7C1lmsZtRswv0Kp
	1tnTzWeszn7DfxQrR3FVHqeCrzCX59XFbW24yQc6trWAUztW5v7HvR1kWqSRvQVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYR0-00000008Xuw-39Gu;
	Fri, 24 May 2024 19:10:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 71/74] patches: ifdef resv_start_op in hwsim
Date: Fri, 24 May 2024 19:08:23 +0200
Message-ID: <20240524190907.c75a60d4645e.I679603c448239607e8d576065c779b7fcae969da@changeid>
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
 patches/0085-hwsim-resv-start-op.patch | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/0085-hwsim-resv-start-op.patch

diff --git a/patches/0085-hwsim-resv-start-op.patch b/patches/0085-hwsim-resv-start-op.patch
new file mode 100644
index 000000000000..771e3f057b8d
--- /dev/null
+++ b/patches/0085-hwsim-resv-start-op.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
++++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
+@@ -6177,7 +6177,9 @@ static struct genl_family hwsim_genl_family __ro_after_init = {
+ 	.module = THIS_MODULE,
+ 	.small_ops = hwsim_ops,
+ 	.n_small_ops = ARRAY_SIZE(hwsim_ops),
++#if LINUX_VERSION_IS_GEQ(6,1,0)
+ 	.resv_start_op = HWSIM_CMD_REPORT_PMSR + 1, // match with __HWSIM_CMD_MAX
++#endif
+ 	.mcgrps = hwsim_mcgrps,
+ 	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
+ };
-- 
2.45.1

