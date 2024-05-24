Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DF376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570617; cv=none; b=fOPSzFL/MkibdwbKy5fSupfPoFmQoXcg8HLIEhWUSzf1gDTWy0Hl7dRzdi1UIkXEm71P2Y8I+PAeEQv4Jf6a2y6hRr1Wa0G8jGizoNltfW3bCFWvh42mFLnfx8FRs1V1LEZOGPXmjepNx3+cMzEEwZP4hH+Liycqnnlai5CgpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570617; c=relaxed/simple;
	bh=8lsGNZsm9BTTFoEFKvGJyMPZG2BkQeFNDmiUnRROoXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTjIG3e8vBMxHdmcMklN/ZVgCNpW6CiW0zQYNV9KzGNrSnMXxlA0nT72/C/0gLUOoSE4RbfgGvVCf1EHDcwPEx984Ae5fzFNd/PGQcYvcVZ4jdpBdRBsFPeduRc6w3OswuokAC+pHHEIt23MZAVObz4ZT6Nq96RC5Py+WCjnNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RBbqfkNy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RBbqfkNy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0fWBtYETDJPVJek9p3r279LY8ycaW08DEQjHogvsjMM=;
	t=1716570615; x=1717780215; b=RBbqfkNyi9xdcE8epN+yOaYALfV7sUfM7m0/HpiAsUaTvCO
	1d/kdQGkNCA4otZh+N54oFLwjteRXXyYJlHvuIi+BR32GG8jz/rtphvPPGHHkGPnhOMtO7BdIn6nu
	Gji3iJ/duoH3TwtTUR2NDA8EXrhCHiiESHTLwZ3RBqVRuaLX3mlOcFn5/xXbexFGBeG4NJL7l4hl0
	nltL4nsIzHog0MJTeowxWNnST3CEblhYa5Df69wf6LOJF1iL2pJzgZ+azabJMoZIElqRmmyaMIKIk
	CZQrm5MSgS0j8ie1cSWCaYBWwe1/GkyNH8RgX7arIC2AJBYduR+BQe6UqmK1RTlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQn-00000008Xuw-2RoB;
	Fri, 24 May 2024 19:10:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 61/74] backport: update iwl-debug patch
Date: Fri, 24 May 2024 19:08:13 +0200
Message-ID: <20240524190907.b3a28adeee11.I6eec7e271e27203f0c7bc69672d5d375abd61f9e@changeid>
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

From: Luca Coelho <luciano.coelho@intel.com>

Some code had to be moved around a bit.  Update the patch.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 ...ivers_net_wireless_iwlwifi_iwl-debug.patch | 26 +++----------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
index 870aa41f7745..e8f943f46395 100644
--- a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
+++ b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
@@ -1,6 +1,8 @@
+diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+index ae4c2a3d63d5..339062da2917 100644
 --- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
 +++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
-@@ -69,13 +69,16 @@ void __iwl_ ##fn(struct device *dev, const char *fmt, ...)	\
+@@ -15,13 +15,16 @@ void __iwl_ ##fn(struct device *dev, const char *fmt, ...)	\
  	struct va_format vaf = {				\
  		.fmt = fmt,					\
  	};							\
@@ -21,27 +23,7 @@
  }
  
  __iwl_fn(warn)
-@@ -94,13 +97,18 @@ void __iwl_err(struct device *dev, bool rfkill_prefix, bool trace_only,
- 	va_list args;
- 
- 	va_start(args, fmt);
--	vaf.va = &args;
- 	if (!trace_only) {
-+		va_list args2;
-+
-+		va_copy(args2, args);
-+		vaf.va = &args2;
- 		if (rfkill_prefix)
- 			dev_err(dev, "(RFKILL) %pV", &vaf);
- 		else
- 			dev_err(dev, "%pV", &vaf);
-+		va_end(args2);
- 	}
-+	vaf.va = &args;
- 	trace_iwlwifi_err(&vaf);
- 	va_end(args);
- }
-@@ -117,12 +125,18 @@ void __iwl_dbg(struct device *dev,
+@@ -73,12 +76,18 @@ void __iwl_dbg(struct device *dev,
  	va_list args;
  
  	va_start(args, fmt);
-- 
2.45.1

