Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671492ED870
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286825; cv=none; b=kZxOaBrFygyOlPMm9p0/ssSLypRD3JqSxvc++Ft4jeC1YuaAPIjd9jAVV7kFqewN+7+vKcBD8qOA+uNgiD7JURR2twSkkW1GC7GrLfmGd+a+pa48dJ05zzEgiXKBTE+y118TWp3JVxaxG57rKC4CMlADQm9tx1EcEUdhu+tkkgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286825; c=relaxed/simple;
	bh=tvawAEUj4+52/Mr8EQfZWJNMkeGSwb6c+KqFHkxQuJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9kqA7SdqyHpoXIOopExG6nen84m8Zbz2c+yNRB6tB/UkOCro3n6OMeYCQm6KCTaUcP06PpJEJFhKlv0vexQCEcMEoxqF4N2LxyoaXDreCapG3VhiAhEBg8NjQ4U8b83UDe/sKa+/J275pKmS7NxxCGaoEPhy0TPcI7kvZ0Xh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pM+Butn2; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pM+Butn2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/DcHVyKc7Q8ZDwV05eYvImwqAR3aGBr5dKwj3PAx8M=;
	b=pM+Butn2dC8/SeNMpZjsauem3KBG30+OzQucmT9wZXF+2HjouHk/YZYNGKZuytr8y6W6mE
	hLiyh220s43tASGeuhMpzFPPPNgvHBrhXisqJ/voJctQpd83O9QGCuvx8Tucbq5xcgIzlT
	zceH2ms9UYftxEoixUnt4BXVQNjgTjw=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 11/20] headers: add thermal_zone_device_priv() backport for kernels < 6.4
Date: Wed, 24 Jun 2026 15:38:35 +0800
Message-ID: <20260624073844.2097504-12-cong.yi@linux.dev>
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

thermal_zone_device_priv() was introduced in v6.4 to replace direct
access to tz->devdata. Provide an inline wrapper for older kernels.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/thermal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index af3c114f..ea6568d0 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -43,4 +43,11 @@ thermal_zone_device_register_with_trips(const char *type,
 }
 #endif /* < 6.0 */
 
+#if LINUX_VERSION_IS_LESS(6,4,0)
+static inline void *thermal_zone_device_priv(struct thermal_zone_device *tz)
+{
+	return tz->devdata;
+}
+#endif /* < 6.4 */
+
 #endif /* __BACKPORT_LINUX_THERMAL_H */
-- 
2.43.0

