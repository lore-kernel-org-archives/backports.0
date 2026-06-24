Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE922ED870
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286818; cv=none; b=BKF3HnlqAtz+5mC1m4TOOAJbhzRGUeojjogdn6PmR5uPhYmiICz2J49l0WDikoqDC1iqx7VDaaVA9CxsBNdH32jcY40xu43DHkbT+Ot5JijvuUpOqlm8rSU61lUG5By0znR5j3gc1UkBkAVkpJr9zvEMGA4lNV7r/6KfVBnrCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286818; c=relaxed/simple;
	bh=VOCbeQkmWPTa/Hb3yxpyF/JjXF0ozXxUujRqiVGqcic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPo8A94G+J1bNrcQeKFONiLE6Z0yEs3CgEK/XOnNcXNW7Wx9RxrQdyiCIeUvlM7HqfbnfjNuRadYtu/33ZthT6t458gGGUwFlsEWRFvNS53Hl7gxS8lO3t5pP16IzKIlYrJO56wAFeETpST2qIsI+ZMv2UbiUCyV/gf71QKGybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MIh5ao9o; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MIh5ao9o"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmXvif2lEdCd6LhQjVmJtwmZaZeU4wvJhj6yxVU86vU=;
	b=MIh5ao9oSZ1UxNiRPUByzAnxbO2enyw1WSsTgFH4TLHflkRGMX/Ph9Gup5X0Q/WxKPbzYe
	7Jt6wgcnOOhadqfPr7PjtXYLo0Lg294zZ2iVdXPuP+0i/weQy3XHPcOVvAfiT+fNYUz5So
	DpMuB4SRt9KaITwSPIwe4oB2rlvFHRA=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 06/20] headers: add thermal_zone_device_register_with_trips backport
Date: Wed, 24 Jun 2026 15:38:30 +0800
Message-ID: <20260624073844.2097504-7-cong.yi@linux.dev>
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

v6.3 mt76 and other drivers use thermal_zone_device_register_with_trips()
which was introduced in v6.0.  Map it to thermal_zone_device_register()
for older kernels, passing 0 as num_trips and NULL as trips.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/thermal.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index f1663eff..af3c114f 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -25,4 +25,22 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
 
+#if LINUX_VERSION_IS_LESS(6,0,0)
+#define thermal_zone_device_register_with_trips LINUX_BACKPORT(thermal_zone_device_register_with_trips)
+static inline struct thermal_zone_device *
+thermal_zone_device_register_with_trips(const char *type,
+					 struct thermal_trip *trips,
+					 int num_trips, int mask,
+					 void *devdata,
+					 struct thermal_zone_device_ops *ops,
+					 struct thermal_zone_params *tzp,
+					 int passive_delay,
+					 int polling_delay)
+{
+	return thermal_zone_device_register(type, num_trips, mask, devdata,
+					    ops, tzp, passive_delay,
+					    polling_delay);
+}
+#endif /* < 6.0 */
+
 #endif /* __BACKPORT_LINUX_THERMAL_H */
-- 
2.43.0

