Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4A1EFF8D
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286811; cv=none; b=PGMX+MtNfQ3+XHQZPFYRgX/RHZuYfs+HAwAWqI6kvYDDrPCJu+wa7OGbvhvHgbLr6gVjIGnYhLhgkwIxwszKox+4vMH6B7tWJMlSypCi4xNd82T139z3Osb9EoiF4LxlqnPreRn4kcADWmRJyxjbgjiQyyikmgfFfNyVYy8ZvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286811; c=relaxed/simple;
	bh=4obAKH/e9YG9AsA4kn7UIjwZjLuZmYWB3CcccYNsq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGaWKqxgapQvqEbctsHvVvZf37THqcukh0S3qJf7vpOgeqIaWdqsJgJamcJ54HeW6FR+ebCYFP810UZR81eaSoNl2s3IcH6VZrWl6fwZyddYRkjKHuo1z1PWbdgHCNdLmaGED47dCcnoRSN1KpE9t1iUqCgwGb2n4pYFwK+FnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sTxhv0a5; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sTxhv0a5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8N5eJ2VzIt+6NqFoEAeE0aacyzK9cb9RrhUYa3zagY=;
	b=sTxhv0a5riRNUBzSRH3i/GnYDEDViLDtP6zwIK/skAoKYMvIs8W4es+SmWDIA+7QbDoe7a
	x0sSgunRUDuNChPPfCR9WzCTu5k34lMwrA72n/iQCsXU+P0axkLVMZP/BtlpukHkrLkvNf
	PDPAMyYC/nfWgzIb4YrEbVtTJXHdopk=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 01/20] headers: Add timer_shutdown_sync()
Date: Wed, 24 Jun 2026 15:38:25 +0800
Message-ID: <20260624073844.2097504-2-cong.yi@linux.dev>
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

timer_shutdown_sync() was introduced in v6.2. On older kernels it needs
to delete the timer and set its function callback to NULL to emulate the
shutdown semantics (prevent the timer from being rearmed).

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
2.43.0

