Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6112F368
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570570; cv=none; b=o3OcQ6L92QQPfsNJcncTFOth0wnMTpp+uSsbkBsuLkzQtcjH0rdNOcf4Tw9mhh+RFzhYBOjhSacjNyY+WCHkQ6gmiVLhPJKGwctav0ja6O75twGC2azAoc9pb3RXgSZuO3gHDGeHewxFQc9J9TsORNBhGFsCQ+zui7ZZltSRYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570570; c=relaxed/simple;
	bh=s0+Q/sy+GBwqGGEvH3UFKQMD4tV2i/RjtKiAJVdJ8GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIDTcvJkS71woB06EGijxwEbMPUNDohyZjpjFme6htW5V3L61nbjjtjwNONyFInhpHUM0apxnBhDz5uYzvBZXTC6SEJhfLaG3yyOEyme1NHq+t7jGocbiKnbs5NXybfJixG59Wj0Lcbe2GfMp+1T0nSx18vwpRC+DeCTLIDT900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QzQuDXV8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QzQuDXV8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e7oQg2NKFSJc5TV20YTHn07QvqOw+vNgg1TtLCirW3g=;
	t=1716570569; x=1717780169; b=QzQuDXV8vZf7amnAPVN3HZ1GlFWusds6WKKisDOVxEMHHbN
	4JfjGAVqt0CFnt2SEVzrWE1QmNtR+OfHzLmXy2fdVskY1bq9p3yVM/CFaqsnrcLR/HRZr3n+u9vzr
	pKo9Hyt49M3e5YZ1hkEXiZFTl/i5de5Ly7fffCY/1hwEfD0BfueXdgxlzPCxY5u58cSLVNuYjFtG/
	J66t2uzKLL3BmoTOTP1RCNKe/vncxY99WEfx6fGn/+mkZY6wejlpwkEjPR9bb9/kfFrUZYfhKsSfh
	k4st1Q1yFC+8ZKQfQQKprxPwpMcGh/p59LVVvYAdxXGMgYQ7OWNPkMmlE+24XbOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ2-00000008Xuw-3ozS;
	Fri, 24 May 2024 19:09:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/74] backports: add lockdep_is_held() when needed
Date: Fri, 24 May 2024 19:07:31 +0200
Message-ID: <20240524190907.39c3936c9c58.I013e3ab4f0cfe836d7ff96ae3d68508e55987333@changeid>
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

If lockdep is not enabled and lockdep_is_held() not already defined
as a macro, declare it as an inline just like upstream does now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/lockdep.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 842e24b7ff8f..8295b0d49184 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -9,6 +9,13 @@ struct lockdep_map { };
 #endif /* CONFIG_LOCKDEP */
 #endif /* LINUX_VERSION_IS_LESS(4,15,0) */
 
+#if LINUX_VERSION_IS_LESS(5,11,0)
+#if !defined(CONFIG_LOCKDEP) && !defined(lockdep_is_held)
+/* upstream since 5.11 in this exact same way - calls compile away */
+int lockdep_is_held(const void *);
+#endif
+#endif
+
 #ifndef lockdep_assert_not_held
 #ifdef CONFIG_LOCKDEP
 #ifndef LOCK_STATE_HELD
-- 
2.45.1

