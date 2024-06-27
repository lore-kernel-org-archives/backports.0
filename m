Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998E1A3BB2
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532143; cv=none; b=aHZ0Ct3iMk9rq9I5VSNrpZOyHD7umVM/l/+tQGZ5sLcOCOy6d9o5kJcc22ctSneXapXa6jn0XEUqssR5/v1/XwVMCu8Epsg/Vhm5x8vL9lX9+8FlbXbEiUij5X9ObZElaPG4czjcuuij2tLkHFKi8wBIsifFmoB17DjMtjCg0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532143; c=relaxed/simple;
	bh=i4duGUzpTIW1IA4S91jd1h1FO7XV557LKNtKNQWn1Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csmZPjWOJ5GQlRHZ1wmw0tdb8Lzf1YBl5UEGAtWAjiS+lRJObTmmTQbHe6fonhI81UlPTWVR0OI87qeL/cof5JHAfk2r2uh+0ZCFhsNOO91xo2tTjwrUFdzk9TxHMKqI+CX/SBOfBQyU8Bkmo5b6GBNZEhmq8G5qkNXxNL3rqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=1K5ytwYk; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="1K5ytwYk"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdl0B76z9spX;
	Fri, 28 Jun 2024 01:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0UBq8ck7aEZ0mXb2qP/3xV5xn9dNf5K38T4IIeo/NY=;
	b=1K5ytwYkL0VnS6HH8nTwY47Z+GxNevvAsssaBARNUwIfZooHef0P7fQNt+kCRmnNm9DUnO
	j2/aPn6Ul5d6xaeIDkSPoi7kgtPBqxa2KLA9uw4Pyclej7Svfy9Y79iEtwRaKluHPYDs8k
	GKy4eceW0pvlj5tmDOpwTftukZ/pTee1jF9D6IPrKN1W6/Olzxh1jIqWgd6SQQpG55Oy9N
	DdgeGz0UOia5NXxOFl/1fd6tfAK7v18srAK0U6+TCCTv1yioLq8vhRHATHEQGQgHl/JodM
	9pv7bq1F6laiNpl8TLWZ3btCvFT6Pi2Aa7hX4zWI7II+bivcy5WGLsagHE2i1Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 74/75] headers: Add timer_delete_sync()
Date: Fri, 28 Jun 2024 01:48:00 +0200
Message-ID: <20240627234808.1253337-75-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function was renamed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timer.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
index 69590bb7..14467fb6 100644
--- a/backport/backport-include/linux/timer.h
+++ b/backport/backport-include/linux/timer.h
@@ -67,4 +67,16 @@ static inline void timer_setup(struct timer_list *timer,
 		__TIMER_INITIALIZER(_function, 0, 0, 0)
 #endif
 
+/* This was backported to 4.19.312 and 5,4,274, but we do not support such high minor numbers use 255 instead. */
+#if LINUX_VERSION_IS_LESS(6,1,84) &&			\
+	!LINUX_VERSION_IN_RANGE(4,19,255, 4,20,0) &&	\
+	!LINUX_VERSION_IN_RANGE(5,4,255, 5,5,0) &&	\
+	!LINUX_VERSION_IN_RANGE(5,10,215, 5,11,0) &&	\
+	!LINUX_VERSION_IN_RANGE(5,15,154, 5,16,0)
+static inline int timer_delete_sync(struct timer_list *timer)
+{
+	return del_timer_sync(timer);
+}
+#endif /* < 6.1.84 */
+
 #endif /* _BACKPORT_TIMER_H */
-- 
2.45.2

