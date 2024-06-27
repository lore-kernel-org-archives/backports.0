Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3747F6F
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532133; cv=none; b=MBDcYotvST+x/a8pKeClYOcONSZOnAyrw8rXPEanhqeN7f4pvENa/8a+Ys0XFItATMcP+kmdfAH9BLJ57lnAm49TFoPFJDGfVYRcM+IGHSAiGmPqV6c+Atnt0KIYpIzkTAbeRBJubXcBUUCSO/uHH9nu6op7bSqMY39UDDOcf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532133; c=relaxed/simple;
	bh=yk76sA6Q850jL9IKlfn+V4iF9y+HC2ZO5agGgcjaFsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/rRE3cwe+b4pXhr3Ci69HzR+tdyyLpSuB8wSMINseP7oDUuCXFNpMXhDLV5ZvHHVJAjmMZtnvjpICTHkJjDG+JawrBAbNJQ1cmpYjS8RVdlarIlKBmWwpq8ZbBJTFFXh01GQli6LeLJ8N3OKY6NRO1ReIQ+DRwyVvOeKPzGalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=iPAP8Xx0; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="iPAP8Xx0"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9FdW5X8kz9sqB;
	Fri, 28 Jun 2024 01:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcqwsqB0+bRNLnqE9BCfjyX/7C8DhSg1+nEZ0TwiOlQ=;
	b=iPAP8Xx0SdESzaUxsLh0Ou4k9dUf6orJYx1UkaYeNyslzJaEPFP9xTTAMC6fe+YkyniOnN
	lJ9wq5/lG8I3wZV7GQWAVrHUJ30HyAmgYIhPbwbqCn7p2zq2/YRMh9or5W4sZm4YeCyvnJ
	+nAu+8Zjs3JuNgu4v1aTN1uNtJovOCAdMNhVs8vj1R6f5FsP7dnv9LrDWov2LS1Bpnmt2X
	Qz5zLq741YTUzsmNpngiqh4mDol8m3AoC5UdbI1TFN05ymVTHznKibIpLd8UWe+tAFd3ij
	o/jZkfDTkknJL7zLNcZjC40a37Hi0mH4WPYeVWCv4xEzzitZNFXMZuqeuq+eEA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 30/75] backports: add thermal_zone_device_enable()
Date: Fri, 28 Jun 2024 01:47:16 +0200
Message-ID: <20240627234808.1253337-31-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdW5X8kz9sqB

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/thermal.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index d9b8153e..f1663eff 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -3,6 +3,18 @@
 #include_next <linux/thermal.h>
 #include <linux/version.h>
 
+#ifdef CONFIG_THERMAL
+#if LINUX_VERSION_IS_LESS(5,9,0)
+static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
+{ return 0; }
+#endif /* < 5.9.0 */
+#else /* CONFIG_THERMAL */
+#if LINUX_VERSION_IS_LESS(5,9,0)
+static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
+{ return -ENODEV; }
+#endif /* < 5.9.0 */
+#endif /* CONFIG_THERMAL */
+
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #define thermal_zone_device_enable LINUX_BACKPORT(thermal_zone_device_enable)
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
-- 
2.45.2

