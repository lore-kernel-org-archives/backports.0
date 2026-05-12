Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB047AF56
	for <backports@vger.kernel.org>; Tue, 12 May 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570060; cv=none; b=Amj/BaIxfFMTz9ydJ40MwKkXbhom2dVTZ53D5Wg72ISp4Bfx0jKJcWP5QGX+TSwsStqxNNt2fP6vM4CrW2Q4BNW2OBBoj4oVkN0Z9brN/AdBMG0VAUKf5d0FzTvCvLs5wuyZpJQ0SUdB39iD+DR6XEtJobyOasjk2RjyTvzQCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570060; c=relaxed/simple;
	bh=YdflgahXGJRA1sLi2oaiphKaIzgZpRpEk4lASWzSYjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fmGRyLcPsR/IVSwucwB29XVs/yq/+YshREmpaPr9J+xiPH5+Zq0gsuIhA63CWGIwoZA34yBwal8stUJPLXLFp0VQopogYJgZ3/s8Qobq5+ioUdl34sGaM907XV8hMMf9L+kyx1ssyeeK+B60YIwvRyo3sYlIW49A5M06uh4KtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URpFEvHc; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="URpFEvHc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778570051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hm0PLDDXopvZOKidZf9+z0CAYTbMiU+96TahutcAjZ8=;
	b=URpFEvHct/V4KtT/J5KfrjXOj9sDqCDl1OaxKRt6doEpokoEadGzIh8/L3fK79JZew8ZBF
	fbVUgb+LHaI6dAh+ujHlteoB6RblVq2O9KRDD/pRLbMDCCa+4hSAnCPduGBQBs755W+eHD
	KKlj3PTePJDkcwohSqalfBpMNl4sBJE=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH] headers: Add timer_shutdown_sync()
Date: Tue, 12 May 2026 15:13:11 +0800
Message-Id: <20260512071311.93802-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

This function need delete timer and set functionm callback
to NULL

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/timer.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
index 14467fb6..36e15340 100644
--- a/backport/backport-include/linux/timer.h
+++ b/backport/backport-include/linux/timer.h
@@ -79,4 +79,18 @@ static inline int timer_delete_sync(struct timer_list *timer)
 }
 #endif /* < 6.1.84 */
 
+#if LINUX_VERSION_IS_LESS(6,2,0)
+static inline int timer_shutdown_sync(struct timer_list *timer)
+{
+    int ret = del_timer_sync(timer);
+    /*
+     * Emulate shutdown semantics: mark as dead to prevent accidental reuse.
+     * Safe to do after del_timer_sync() because timer is no longer
+     * referenced by the timer subsystem.
+     */
+    timer->function = NULL;
+    return ret;
+}
+#endif
+
 #endif /* _BACKPORT_TIMER_H */
-- 
2.25.1

