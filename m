Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC833B290
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572916; cv=none; b=V4sHMPYPI4c6zAwUG/wqZVoj34akcOWIylOw3tF3uulsZpz+POElZc3t6XBb2xYs4EQNpr429mb1n8dkuoVSbcvyv0/tHYiY/Avc+mckilLOlp4MLQ2mWa/gcL+O+MH7xh74N5qEA2hHyJeZlbeIGpGYGdAgvK1ZVXCV1gXWevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572916; c=relaxed/simple;
	bh=9O5szq7boBszcSFM0DSZF2uDz9Aajmt+8hCMYUI/Ekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3wmvZlsLC9jNqhQgyz+Ahv6wGNdAIP2/P9NJJj5JE8HgRVoXu+0bOpNdUEcOagDuC844mi7r6iJ6BZmREq96qvOe+P4W1YfDUHFaSCbiU2HK0hsEQjp/UU7SUPQkUQ39QfjWtfVHVeMlV/PMY+9/9YrwSdS9gvMZHh8itrQJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=r8JOsMLw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="r8JOsMLw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dgs0KwQQZyBl4uTVuIzjAmAec56Q6Wp0ZZPc0CppPi8=;
	t=1716572914; x=1717782514; b=r8JOsMLwi2qJgHuAvzSv8lYFWBbHX8OAxnkmw8j5NrN4VDH
	cZJxFPok0c2IO1uOVDyQyBnCj6KhCO+aTysHKvi7jaloJX5l1FKUQW2LzZuPqsNJL6rh1vDqsmNNh
	Yx4LeW4hdsr7IgjeaIA9dy4of+aKUMVMoUw0+a8YrAz2JmQwPdS9JiTPWVPWVry+DBj5abXwd0sLm
	i4Eay8sO7ryD7FEzXqnn7Qf9c5qDpYBl2qZmJ1/HyYQP43fNIP2cv6gvYMTXAEdssuv5sa9UaqlNV
	kidz4q9JVTZeW17Ve0LEc/NmAVl05R/s66DKA1JTOb3EfY/3plrH7dOlr8KqZ2Dw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAZ1s-00000008alk-0lqc;
	Fri, 24 May 2024 19:48:32 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] backports: add timer_delete_sync()
Date: Fri, 24 May 2024 19:48:17 +0200
Message-ID: <20240524194829.ff76233b3f76.I5bacafcbce1f73629f1279043650962ad7573025@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524194829.f11312298857.I2921f495b9feefbfe464ffd71c7350c66be119a8@changeid>
References: <20240524194829.f11312298857.I2921f495b9feefbfe464ffd71c7350c66be119a8@changeid>
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
 backport/backport-include/linux/timer.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
index 69590bb71324..ab0e2e6adcf5 100644
--- a/backport/backport-include/linux/timer.h
+++ b/backport/backport-include/linux/timer.h
@@ -67,4 +67,12 @@ static inline void timer_setup(struct timer_list *timer,
 		__TIMER_INITIALIZER(_function, 0, 0, 0)
 #endif
 
+#if LINUX_VERSION_IS_LESS(6,2,0)
+#define timer_delete_sync LINUX_BACKPORT(timer_delete_sync)
+static inline int timer_delete_sync(struct timer_list *timer)
+{
+	return del_timer_sync(timer);
+}
+#endif
+
 #endif /* _BACKPORT_TIMER_H */
-- 
2.45.1

