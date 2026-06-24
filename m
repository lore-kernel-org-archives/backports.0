Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219932EEE92
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286815; cv=none; b=c+Ey+/WgV1bZlSLRIcGO++4xcn/utU8nAgoB3erXGe1jtyheLSOjMmseiHg/yfCEpDYXOSv69cXjieGLgpg7antrAS+6HylYpXitugXiDFD1Ju0OKmQWxHH5gTTniAiFlONTTUoq+nG/DDzisVn0Oa7sMSZk9h4y760yMl5++P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286815; c=relaxed/simple;
	bh=TFq6HZ5zH3484noKxRXsAoPxMEE/d+IG/t81rmMLjCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBf8JgitNq8hukl94LaWCE4CNKIi/9PE68N4yBILAHH1o3vK1zqb8DDDgJ3WTXHvS3kLPlSzff0HirluTN3heHADwIlWU1aOwEv1Dms0qEUXH3sRGmkFS9UqXNONsTlYbmsGMKGGiJAC0XmNqPUOZGJtsrUxBw2lCMufe1NEubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EV16IB0B; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EV16IB0B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dn/5pyyC49OIlwxdDzFB3ogUw8SiYmu3WFFvUNRl7UA=;
	b=EV16IB0BNcQbt/ZDs+AQktynu1eEheouVmgNDSA7CXf9lYotZjDTjZD+l8xMQXBHgCnmwK
	ARv76kUd1nK+ETVvhbx+L9Yf7Raev4j+R7+v48XWbsjJIoFtM5lTyuGsoQRm7ctrDX9isc
	iLB9NijEgxWTyOMQ5dwcvSMG5nYlsJo=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 04/20] headers: add get_random_u32_inclusive() for kernels < 6.2
Date: Wed, 24 Jun 2026 15:38:28 +0800
Message-ID: <20260624073844.2097504-5-cong.yi@linux.dev>
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

get_random_u32_inclusive() was introduced in v6.2.  Provide it as a
static inline backed by the older prandom_u32_max() helper.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/random.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index f4fd47dc..6437d55e 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -15,4 +15,11 @@ static inline u16 get_random_u16(void)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(6,2,0)
+static inline u32 get_random_u32_inclusive(u32 floor, u32 ceiling)
+{
+	return prandom_u32_max(ceiling - floor + 1) + floor;
+}
+#endif
+
 #endif /* __BACKPORT_RANDOM_H */
-- 
2.43.0

