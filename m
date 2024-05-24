Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479512C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570612; cv=none; b=HAn719xj9PpB9bJ32DETx3NwUOmmue3L9kTGiy+9Gh6DL5zT6HhdKF6HRKnXv7tym2lTae9Xny6Umg1EEHi2QydYF1zaaEaK9dgiBVtb8htZE8wkqCoPnQv3T8M1Y+9p8HAzcJUUQkr3C+4NohNwHTLNVVQwflAAw32inlhwi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570612; c=relaxed/simple;
	bh=U8ElcQ/Ty7K104y7KEy3kTm6lwwI7OAbweHES1J9pag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owByXMSkW1u7Bqz5WNw82fWjTAuAqNwdLtOTKXBGfCNuVw5cdU10TbmPlKVFJrfbHNxlb8LmIOYfD1NwDWm03aiKvJKZza+fOM5hT3IFuLtgjdxgFV6pRcz82CN/uDwdgGifF9T4ACAGzQmLip0wy8tkA9wu3R6gL0uirPrhaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LmFYVFSz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LmFYVFSz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XVdw+cmrK3/ADNCzEd70kk6gs617TufVVFlasQ2gCNk=;
	t=1716570611; x=1717780211; b=LmFYVFSzKkZ8ipcwuKsf4a4NwEOp8FhM6w0BclL055K/5Yj
	QXIj+xbi5Pm6wUtDzNJqjGBUtcE+2YscqN9GLxx0nj4v3DK12yQio+VR1WvSo9I4RGdKyBKvgRH1m
	qImkH10BJsvkfn0rsDRfHWupZA1gkGHPZi6xSxihM39Uxo/pcxlUNvc3eJj8cClmzYrOjHc/XoIgs
	Uwzqdnz7GuncoJPIjQ2VwMu0IUYMJ7VxICO5Z2U3lGLfysvImjz4iK5W/6E8E5wvMi8wjaOVEWfh6
	Ddw3cXYXh76Sq84TruSJriOIyq7aJUD9XAzitKdcox6W2xkdYhvhTptB54KDQVOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQi-00000008Xuw-2SfJ;
	Fri, 24 May 2024 19:10:09 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 56/74] backports: add ktime_get_coarse_boottime_ns
Date: Fri, 24 May 2024 19:08:08 +0200
Message-ID: <20240524190907.88fd9eae961f.Id1c6b53e4c57d92eb838e4c09ef8042cd42f150f@changeid>
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

... and simplify the code while at it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/timekeeping.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 80c625569d6e..87744572bce6 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -6,23 +6,18 @@
 #include_next <linux/timekeeping.h>
 
 #if LINUX_VERSION_IS_LESS(5,3,0)
-#define ktime_get_boottime_ns LINUX_BACKPORT(ktime_get_boottime_ns)
-static inline u64 ktime_get_boottime_ns(void)
-{
-	return ktime_get_boot_ns();
-}
+#define ktime_get_boottime_ns ktime_get_boot_ns
+#define ktime_get_coarse_boottime_ns ktime_get_boot_ns
 #endif /* < 5.3 */
 
 #if LINUX_VERSION_IS_LESS(4,18,0)
 extern time64_t ktime_get_boottime_seconds(void);
-#endif /* < 4.18 */
 
-#if LINUX_VERSION_IS_LESS(4,18,0)
 #define ktime_get_raw_ts64 LINUX_BACKPORT(ktime_get_raw_ts64)
 static inline void ktime_get_raw_ts64(struct timespec64 *ts)
 {
 	return getrawmonotonic64(ts);
 }
-#endif
+#endif /* < 4.18 */
 
 #endif /* __BACKPORT_TIMEKEEPING_H */
-- 
2.45.1

